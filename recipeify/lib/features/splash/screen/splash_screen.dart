import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recipeify/core/router/app_router.dart';
import 'package:recipeify/features/auth/bloc/auth_bloc.dart';
import 'package:recipeify/features/auth/bloc/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _canNavigate = false;
  AuthState? _cachedState;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        _cachedState = state;

        if (_canNavigate) _handleRouting(state);
      },
      listenWhen: (previous, current) =>
          current is AuthAuthenticated ||
          current is AuthRequiresPin ||
          current is AuthUnauthenticated ||
          current is AuthError,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/app_logo.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.restaurant_menu, size: 100, color: Color(0xFF4A1620));
                },
              ),

              const SizedBox(height: 24,),

              const Text(
                'Recipeify',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2
                ),
              ),

              const SizedBox(height: 48,),

              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(strokeWidth: 4,),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() {
        _canNavigate = true;
      });
      if (_cachedState != null) {
        _handleRouting(_cachedState!);
      }
    });
  }

  void _handleRouting(AuthState state) {
    if (state is AuthAuthenticated) {
      context.go(AppRoute.home.path);
    } else if (state is AuthRequiresPin) {
      context.go(AppRoute.pinVerification.path);
    } else if (state is AuthUnauthenticated || state is AuthError) {
      context.go(AppRoute.login.path);
    }
  }
}
