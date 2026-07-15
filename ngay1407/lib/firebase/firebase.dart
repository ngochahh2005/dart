/*
  1. Giới thiệu về Firebase Cloud Storage
  Cloud Storage for Firebase là dịch vụ lưu trữ đối tượng (object storage) mạnh mẽ,
  đơn giản và tiết kiệm chi phí, được xây dựng trên cơ sở hạ tầng của Google với
  khả năng mở rộng đến quy mô exabyte.
  Dịch vụ này được thiết kế để giúp bạn lưu trữ và phân phối nội dung do người dùng tạo,
  chẳng hạn như:
  - Hình ảnh (photos)
  - Video
  - Âm thanh (audio)
  - Tài liệu và các loại file khác
  Cloud Storage for Firebase lưu trữ file trong một bucket của Google Cloud Storage,
  cho phép bạn truy cập file thông qua cả Firebase SDK và Google Cloud API.

  2. Các tính năng chính
  - Hoạt động tin cậy: Tự động tạm dừng và tiếp tục truyền dữ liệu khi kết nối mạng bị ngắt.
  - Bảo mật mạnh mẽ: Tích hợp với Firebase Authentication để kiểm soát truy cập dựa trên
    tên file, kích thước, loại nội dung và các siêu dữ liệu khác.
  - Khả năng mở rộng cao: Dễ dàng đáp ứng nhu cầu từ một ứng dụng nhỏ đến một sản phẩm
    quy mô lớn với hàng triệu người dùng.

  3. Thiết lập Firebase Cloud Storage trong Flutter
  3.1. Điều kiện tiên quyết
  - Đã tạo Firebase project và cấu hình Flutter app với Firebase
  - Dự án Firebase phải ở gói thanh toán Blaze (pay-as-you-go)

  3.2. Tạo bucket mặc định
  - Trong Firebase Console, điều hướng đến Storage > Get started
  - Chọn vị trí cho bucket của bạn
  - Cấu hình Firebase Security Rules – trong giai đoạn phát triển, có thể thiết lập public access
  Lưu ý: Mặc định, quyền đọc/ghi Cloud Storage bị hạn chế – chỉ người dùng đã xác thực
  mới có thể đọc/ghi dữ liệu

  4. Các bước triển khai cơ bản
  - Bước 1: Thêm dependency 'firebase_storage' và 'firebase_core' vào pubspec.yaml.
  - Bước 2: Khởi tạo Firebase trong ứng dụng (Firebase.initializeApp()).
  - Bước 3: Tạo một instance của FirebaseStorage:
    final storageRef = FirebaseStorage.instance.ref();
  - Bước 4: Tạo reference đến file cần thao tác:
    final imagesRef = storageRef.child("images/profile.jpg");
  - Bước 5: Thực hiện tải lên (putFile, putData) hoặc tải xuống (getDownloadURL).
 */

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

// 3. Tạo Reference (Tham chiếu)
// Reference là con trỏ đến một file hoặc thư mục trong Cloud Storage. Nó nhẹ, có thể tạo nhiều và tái sử dụng.
void referenceExamples() {
  // tham chieu goc (goc bucket)
  final storageRef = FirebaseStorage.instance.ref();

  // tham chieu den file cu the o bucket
  final mountainsRef = storageRef.child('mountains.jpg');

  // tham chieu den file trong thu muc con
  final mountainImagesRef = storageRef.child('images/mountains.jpg');

  // lay ten va duong dan
  print('Ten: ${mountainsRef.name}'); // mountains.jpg
  print('Duong dan day du: ${mountainsRef.fullPath}'); // mountains.jpg
  print(
    'Bucket: ${mountainsRef.bucket}',
  ); // Tên của "kho chứa" (bucket) nơi file được lưu trữ.

  // di chuyen len parent
  final parentRef = mountainImagesRef.parent; // images/
  final rootRef = mountainImagesRef.root; // goc bucket

  // tao tu url
  // tu gs:// url
  final gsRef = FirebaseStorage.instance.refFromURL(
    "gs://my-bucket/images/stars.jpg",
  );
  // tu https url
  final httpsRef = FirebaseStorage.instance.refFromURL(
    "https://firebasestorage.googleapis.com/b/my-bucket/o/images%20stars.jpg",
  );
}

// 4. Tải File lên
// 4. Tải từ File trên thiết bị
class UploadService {
  final _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  // Ham chon anh va upload
  Future<String?> uploadImage() async {
    try {
      // 1. Chon anh tu gallery
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      if (pickedFile == null) {
        print('Nguoi dung huy chon anh');
        return null;
      }

      // 2. Chuyen sang file
      final file = File(pickedFile.path);

      // 3. Tao ten file duy nhat
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${pickedFile.name}';
      final fileRef = _storage.ref().child('images/$fileName');

      // 4. Metadata
      final metadata = SettableMetadata(
        contentType: pickedFile.mimeType ?? 'image/jpeg',
        customMetadata: {
          'uploadedAt': DateTime.now().toIso8601String(),
          'originalName': pickedFile.name
        }
      );

      // 5. Thuc hien upload
      final UploadTask uploadTask = fileRef.putFile(file, metadata);

      // 6. Lang nghe tien trinh (in ra console)
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final totalBytes = snapshot.totalBytes;
        final transferredBytes = snapshot.bytesTransferred;

        if (totalBytes > 0) {
          double progress = transferredBytes / totalBytes;
          print('Upload progress: ${(progress * 100).toStringAsFixed(1)}%');
        }
      });

      // 7. Cho hoan thanh
      await uploadTask;

      // 8. Lay url
      final downloadUrl = await fileRef.getDownloadURL();
      print('Upload thanh cong! URL: $downloadUrl');

      return downloadUrl;
    } on FirebaseException catch (e) {
      print('Firebase loi: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      print('Loi chung: $e');
      return null;
    }
  }
}
