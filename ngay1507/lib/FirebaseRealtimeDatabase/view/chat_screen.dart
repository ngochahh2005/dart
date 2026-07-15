import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ngay1507/FirebaseRealtimeDatabase/services/auth_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = AuthService();
  final _textController = TextEditingController();
  DatabaseReference? _messageRef;
  String? _myUid;
  String? _otherUid;
  String? _chatId;
  bool _isLoading = false;

  // Dùng initState để khởi tạo các biến độc lập với context
  // (ví dụ: khởi tạo TextEditingController, khởi tạo các biến flag bool, gọi super.initState()).
  @override
  void initState() {
    super.initState();
    _myUid = _auth.currentUser?.uid;
  }

  // Dùng didChangeDependencies cho các biến phụ thuộc vào context
  // (ví dụ: lấy dữ liệu từ Navigator, lấy Theme của app, hoặc các thay đổi về kích thước màn hình).
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // lay chat Id
    if (_chatId == null) {
      final Object? args = ModalRoute.of(context)?.settings.arguments;
      _chatId = args as String;
      List<String> parts = _chatId!.split('_');
      _otherUid = parts.first == _myUid ? parts.last : parts.first;
      _messageRef = FirebaseDatabase.instance.ref('messages/$_chatId');
    }
  }

  // gui tin nhat
  Future<void> _sendMessage() async {
    String text = _textController.text.trim();
    if (text.isEmpty || _chatId == null || _messageRef == null) return;
    _textController.clear();
    setState(() => _isLoading = true);

    try {
      // tao tin nhan moi
      DatabaseReference newMsgRef = _messageRef!.push();
      await newMsgRef.set({
        'senderId': _myUid,
        'text': text,
        'timestamp': ServerValue.timestamp,
        'readBy': {_myUid: true, _otherUid: false},
      });

      // cap nhat thong tin chat (last message)
      await FirebaseDatabase.instance.ref('chats/$_chatId').update({
        'lastMessage': text,
        'lastTimestamp': ServerValue.timestamp,
        'participants/$_myUid': true,
        'participants/$_otherUid': true,
      });
    } catch (e) {
      print('Loi gui tin nhan: $e');
    }
    setState(() => _isLoading = false);
  }

  // lang nghe tin nhan theo thoi gian thuc (stream)
  Stream<DatabaseEvent> getMessageStream() {
    return _messageRef!.orderByChild('timestamp').onValue;
  }

  // danh dau tin nhan da doc
  void _markAsRead(Map<String, dynamic> msg, String msgKey) {
    if (msg['readBy'] != null && msg['readBy'][_myUid] == false) {
      // chi danh dau neu chua doc
      _messageRef!.child('$msgKey/readBy/$_myUid').set(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_chatId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.lightGreen[100],
              child: Icon(Icons.person, color: Colors.green[900]),
            ),
            const SizedBox(width: 12),
            StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref('users/$_otherUid/name')
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  return Text(
                    snapshot.data!.snapshot.value.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  );
                }
                return const Text(
                  'Đang tải...',
                  style: TextStyle(fontSize: 18),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: getMessageStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('Chưa có tin nhắn'));
                }

                final event = snapshot.data as DatabaseEvent;
                final data = event.snapshot.value as Map?;

                if (data == null || data.isEmpty) {
                  return const Center(child: Text('Chưa có tin nhắn'));
                }

                // chuyen map --> list va sap xep theo timestamp
                List<MapEntry> entries = data.entries.toList();
                List<Map<String, dynamic>> msgs = [];

                for (var entry in entries) {
                  Map<String, dynamic> msg = Map.from(entry.value);
                  msg['key'] = entry.key;
                  msgs.add(msg);
                }
                msgs.sort(
                  (a, b) =>
                      (a['timestamp'] ?? 0).compareTo(b['timestamp'] ?? 0),
                );

                // danh dau da doc neu tin nhan tu nguoi khac va chua doc
                for (var msg in msgs) {
                  if (msg['senderId'] != _myUid) {
                    _markAsRead(msg, msg['key']);
                  }
                }

                return ListView.builder(
                  reverse: true, // hien thi tin nhan moi nhat o cuoi
                  itemCount: msgs.length,
                  itemBuilder: (context, index) {
                    final msg = msgs[msgs.length - 1 - index];
                    bool isMe = msg['senderId'] == _myUid;
                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8,
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe
                                ? Colors.lightGreen[200]
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                msg['text'] ?? '',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _formatTimestamp(msg['timestamp']),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Nhập tin nhắn',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send, color: Colors.lightGreen),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return '';
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
