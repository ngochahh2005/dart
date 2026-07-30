import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meow_collector/core/widgets/responsive_grid_builder.dart';
import 'package:meow_collector/features/auth/bloc/auth_bloc.dart';
import 'package:meow_collector/features/auth/bloc/auth_event.dart';
import 'package:meow_collector/features/home/bloc/home_bloc.dart';
import 'package:meow_collector/features/home/bloc/home_event.dart';
import 'package:meow_collector/features/home/bloc/home_state.dart';
import 'package:meow_collector/routes/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Home Screen'),
        actions: [
          IconButton(onPressed: () {
            context.read<AuthBloc>().add(AuthLogout());
          }, icon: Icon(Icons.logout, size: 24))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(HomeLoad());
        },
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeLoaded) {
              final breeds = state.breed;

              return ResponsiveGridBuilder(breeds: breeds);
            }

            return Container();
          },
        ),
      ),
    );
  }
}