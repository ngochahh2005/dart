import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recipeify/core/router/app_router.dart';
import 'package:recipeify/features/auth/bloc/auth_bloc.dart';
import 'package:recipeify/features/auth/bloc/auth_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(onPressed: () {
            context.go(AppRoute.login.path);
            context.read<AuthBloc>().add(AuthLogout());
          }, icon: Icon(CupertinoIcons.square_arrow_right))
        ],
      ),
    );
  }

}