import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class FirebaseSyncService {
  final _database = FirebaseDatabase.instance;
  StreamSubscription<int>? _progressSubscription;

  // dong bo du lieu reading progress len firebase
  void syncReadingProgress(Stream<int> progressStream, String uid) {
    _progressSubscription?.cancel();
    final progressRef = _database.ref('users/$uid/readingProgress');
    _progressSubscription = progressStream.listen(
      (progress) async {
        try {
          await progressRef.set(progress);
          print('Đã đồng bộ lên Firebase: $progress%');
        } catch (e) {
          print('Lỗi đồng bộ Firebase: $e');
        }
      },
      onDone: () {
        print('Stream tiến độ độc đã hoàn thành');
      },
    );
  }

  void dispose() {
    _progressSubscription?.cancel();
  }
}
