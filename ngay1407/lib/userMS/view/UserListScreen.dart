import 'package:ngay1407/userMS/model/User.dart';
import '../db/UserDatabaseHelper.dart';
import 'UserDetailScreen.dart';
import 'UserListItem.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User>> _userList;

  @override
  void initState() {
    super.initState();
    _refreshUsers();
  }

  Future<void> _refreshUsers() async {
    setState(() {
      _userList = UserDatabaseHelper.instance.getAllUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sach nguoi dung'),
      ),
      body: FutureBuilder<List<User>>(
          future: _userList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Da xay ra loi: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Khong co nguoi dung nao'),);
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final user = snapshot.data![index];
                    return UserListItem(
                      user: user,
                      onDelete: () async {
                        await UserDatabaseHelper.instance.deleteUser(user.id!);
                        _refreshUsers();
                      },
                      onEdit: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailScreen(user: user),
                          ),
                        );
                        _refreshUsers();
                      }
                    );
                  }
              );
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // final created = await Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => UserRegistrationForm(),
          //   ),
          // );
          // if (created == true) {
          //   _refreshUsers();
          // }
        },
      ),
    );
  }
}