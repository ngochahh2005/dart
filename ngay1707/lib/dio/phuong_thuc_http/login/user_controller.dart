import '../data/repositories/user_repository.dart';

class UserController {
  final UserRepository _repository = UserRepository();

  Future<void> fetchUsers() async {
    try {
      final users = await _repository.getUsers(page: 1);
      // cap nhat len UI (setState hoac emit state moi)
    } catch (e) {
      // hien thi thong bao loi len man hinh
    }
  }
}