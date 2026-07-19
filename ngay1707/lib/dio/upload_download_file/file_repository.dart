// lib/data/repositories/file_repository.dart
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ngay1707/dio/dio.dart';

class FileRepository {
  final Dio _dio = DioClient().dio;

  // upload file don le voi progress tracking
  Future<String?> uploadAvatar(File file, Function(double) onProgress) async {
    try {
      // tao formData
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
        'description': 'My Avatar',
      });

      final resp = await _dio.post(
        '/upload',
        data: formData,
        onSendProgress: (sent, total) {
          // tinh % va truyen ve cho UI thong qua ham callback
          onProgress(sent / total);
        },
      );

      return resp
          .data['url']; // tra ve duong dan anh sau khi upload file thanh cong
    } catch (e) {
      rethrow;
    }
  }

  // upload nhieu file
  Future<void> uploadMultipleFiles(List<File> files) async {
    final formData = FormData();
    for (int i = 0; i < files.length; i++) {
      formData.files.add(
        MapEntry('files[$i]', await MultipartFile.fromFile(files[i].path)),
      );
    }

    await _dio.post('/upload-multiple', data: formData);
  }

  // download file
  Future<void> downloadDocument(
    String url,
    String savePath,
    Function(double) onProgress,
  ) async {
    await _dio.download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) onProgress(received / total);
      },
    );
  }
}
