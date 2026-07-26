import 'dart:async';

import 'package:ngay2107/streams/thanh_phan/khoi_tao_StreamController.dart';

// Lắng nghe (Listen) và quản lý Subscription

void setupListener() {
  // lang nghe va nhan ve Subscription
  StreamSubscription<int> subscription = counterController.stream.listen(
      (data) {
        print('Nhan duoc du lieu: $data');
      },
    onError: (error) {
        print('Co loi xay ra: $error');
    },
    onDone: () {
        print('Stream da bi dong!');
    },
    cancelOnError: false, // true neu muon tu huy khi co loi
  );

  // tam dung (VD: khi user scroll)
  subscription.pause();

  // tiep tuc
  subscription.resume();

  // huy bo khi khong can
  subscription.cancel();
}