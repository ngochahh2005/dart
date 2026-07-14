import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ngay1307/secure_storage_example/model/storage_item.dart';

class StorageService {
  final _secureStorage = const FlutterSecureStorage();

  // Phương thức của lớp StorageService dùng để đặt thuộc tính encryptedSharedPreferences thành true
  AndroidOptions? _getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true);

  // Phương thức chịu trách nhiệm ghi dữ liệu vào bộ nhớ an toàn
  Future<void> writeSecureData(StorageItem newItem) async {
    await _secureStorage.write(key: newItem.key, value: newItem.value, aOptions: _getAndroidOptions());
  }

  // Phuong thuc readSecureData de doc du lieu duoc bao mat theo khoa
  Future<String?> readSecureData(String key) async {
    var readData = await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  // phuong thuc deleteSecureData de xoa 1 cap khoa - gia tri
  Future<void> deleteSecureData(StorageItem item) async {
    await _secureStorage.delete(key: item.key, aOptions: _getAndroidOptions());
  }

  // phuong thuc containsKeyInSecureData de kiem tra xem bo nho co chua khoa da cho hay khong
  Future<bool> containsKeyInSecureData(StorageItem item) async {
    return await _secureStorage.containsKey(key: item.key, aOptions: _getAndroidOptions());
  }

  // phuong thuc readAllSecureData de doc tat ca du lieu duoc bao mat
  // tra ve 1 list cac StorageItem sau khi doc tat ca du lieu
  Future<List<StorageItem>> readAllSecureData() async {
    var allData = await _secureStorage.readAll(aOptions: _getAndroidOptions());
    List<StorageItem> list = allData.entries.map((e) => StorageItem(e.key, e.value)).toList();
    return list;
  }

  // phuong thuc deleteAllSecureData de xoa tat ca due lieu duoc bao mat
  Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
  }
}