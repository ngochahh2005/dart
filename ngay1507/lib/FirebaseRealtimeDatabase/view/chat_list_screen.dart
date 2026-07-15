import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ngay1507/FirebaseRealtimeDatabase/services/auth_service.dart';
import 'package:ngay1507/FirebaseRealtimeDatabase/view/chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final _auth = AuthService();
  late final DatabaseReference _chatsRef;
  late final DatabaseReference _usersRef;
  late final DatabaseReference _messageRef;
  String? _myUid;
  bool _isCreatingChat = false;

  @override
  void initState() {
    super.initState();
    _myUid = _auth.currentUser?.uid;
    _chatsRef = FirebaseDatabase.instance.ref('chats');
    _usersRef = FirebaseDatabase.instance.ref('users');
    _messageRef = FirebaseDatabase.instance.ref('messages');
  }

  // tao chatId cho 2 nguoi (sap xep uid de luon giong nhau)
  String generateChatId(String uid1, String uid2) {
    List<String> uids = [uid1, uid2]..sort();
    return '${uids[0]}_${uids[1]}';
  }

  // lay danh sach chat cua user hien tai
  Stream<DatabaseEvent> getChatsStream() {
    return _chatsRef.onValue;
  }

  Future<void> _deleteChat(String chatId) async {
    try {
      // xoa metadata chat
      await _chatsRef.child(chatId).remove();
      // xoa toan bo tin nhan trong doan chat
      await _messageRef.child(chatId).remove();
    } catch (e) {
      print('Loi xoa chat: $e');
    }
  }

  // hien thi dialog nhap email de tao chat moi
  void _showNewChatDialog() {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Tạo cuộc trò chuyện mới'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Nhập email người dùng',
                      hintText: 'example@gmail.com',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) =>
                        _createChat(emailController.text, setDialogState),
                  ),

                  if (_isCreatingChat)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: _isCreatingChat
                      ? null
                      : () => Navigator.pop(context),
                  child: Text('Hủy'),
                ),
                ElevatedButton(
                  onPressed: _isCreatingChat
                      ? null
                      : () => _createChat(emailController.text, setDialogState),
                  child: Text('Tạo'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      _isCreatingChat = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danh sách chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
            fontSize: 36,
            fontFamily: 'k2d',
          ),
        ),
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
            onPressed: _auth.logout,
            icon: Icon(Icons.logout, color: Colors.green[900]!),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: getChatsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Chưa có cuộc trò chuyện nào!'));
          }
          final event = snapshot.data as DatabaseEvent;
          final data = event.snapshot.value as Map?;
          if (data == null || data.isEmpty) {
            return const Center(child: Text('Chưa có cuộc trò chuyện nào!'));
          }

          // Loc danh sach chat: Chi lay nhung chat co minh tham gia
          final chatIds = data.keys.where((id) {
            final chat = data[id] as Map;
            final participants = chat['participants'] as Map?;
            return participants != null && participants.containsKey(_myUid);
          }).toList();

          if (chatIds.isEmpty) {
            return const Center(child: Text('Chưa có cuộc trò chuyện nào!'));
          }

          return _MyListChat(
            chatIds: chatIds,
            data: data,
            myUid: _myUid!,
            onDelete: (id) => _deleteChat(id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewChatDialog,
        tooltip: 'Tạo cuộc trò chuyện mới',
        child: Icon(Icons.chat, color: Colors.lightGreen),
      ),
    );
  }

  Future<void> _createChat(String email, StateSetter setDialogState) async {
    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Vui lòng nhập email')));
      return;
    }

    setDialogState(() {
      _isCreatingChat = true;
    });

    try {
      // tim uid theo email
      String? otherUid = await _auth.findUidByEmail(email);

      if (!mounted) return;

      if (otherUid == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không tìm thấy người dùng với email này')),
        );
        setDialogState(() {
          _isCreatingChat = false;
        });
        return;
      }

      if (otherUid == _myUid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bạn không thể tạo đoạn chat với chính mình')),
        );
        setDialogState(() {
          _isCreatingChat = false;
        });
        return;
      }

      // tao chatId
      String chatId = generateChatId(_myUid!, otherUid);

      // kiem tra xem chat da ton tai chua
      final snapshot = await _chatsRef.child(chatId).once();

      if (!mounted) return;

      if (snapshot.snapshot.exists) {
        // chat da ton tai -> chuyen den man hinh chat
        Navigator.pop(context); // dong dialog
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(),
            settings: RouteSettings(arguments: chatId),
          ),
        );
        return;
      }

      // tao chat moi
      await _chatsRef.child(chatId).set({
        'participants': {_myUid: true, otherUid: true},
        'lastMessage': '',
        'lastTimestamp': ServerValue.timestamp,
        'createdAt': ServerValue.timestamp,
      });

      // dam bao thong tin user cua nguoi kia da co
      final userSnapshot = await _usersRef.child(otherUid).once();

      if (!mounted) return;

      if (!userSnapshot.snapshot.exists) {
        await _usersRef.child(otherUid).set({
          'uid': otherUid,
          'email': email,
          'name': 'User $otherUid', // ten tam
          'createdAt': ServerValue.timestamp,
        });
      }

      Navigator.pop(context); // dong dialog
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(),
          settings: RouteSettings(arguments: chatId),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
        setDialogState(() {
          _isCreatingChat = false;
        });
      }
    }
  }
}

class _MyListChat extends StatelessWidget {
  const _MyListChat({
    super.key,
    required this.chatIds,
    required this.data,
    required this.myUid,
    required this.onDelete,
  });

  final List<dynamic> chatIds;
  final Map<dynamic, dynamic>? data;
  final String myUid;
  final Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatIds.length,
      itemBuilder: (context, index) {
        final chatId = chatIds[index];
        final chatInfo = data?[chatId] as Map;
        String lastMessage = chatInfo['lastMessage'] ?? '';

        // Tim UID cua nguoi kia
        final participants = chatInfo['participants'] as Map;
        final otherUid = participants.keys.firstWhere(
          (uid) => uid != myUid,
          orElse: () => myUid,
        );

        return Dismissible(
          key: Key(chatId),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red[100],
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.delete_forever_outlined,
              color: Colors.red[800],
              size: 32,
            ),
          ),
          onDismissed: (direction) {
            onDelete(chatId);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Đã xóa cuộc trò chuyện'),
                backgroundColor: Colors.orange,
              ),
            );
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.lightGreen[100],
              child: Icon(Icons.person, color: Colors.green[900]),
            ),
            title: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref('users/$otherUid/name')
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  return Text(
                    snapshot.data!.snapshot.value.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                }
                return const Text('Đang tải...');
              },
            ),
            subtitle: Text(
              lastMessage.isEmpty ? 'Chưa có tin nhắn' : lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(),
                  settings: RouteSettings(arguments: chatId),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
