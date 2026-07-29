import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meow_collector/features/auth/bloc/auth_bloc.dart';
import 'package:meow_collector/features/auth/bloc/auth_event.dart';
import 'package:meow_collector/features/auth/bloc/auth_state.dart';
import 'package:meow_collector/routes/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go(AppRoute.home.path);
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Form(
            key: _key,
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 40,
                children: [
                  Expanded(flex: 1, child: Container()),
                  Text(
                    'LOGIN SCREEN',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email here!',
                      prefixIcon: Icon(Icons.email_outlined),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _emailController.clear();
                          });
                        },
                        icon: Icon(Icons.clear),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address!';
                      }
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Passwords must be at least 8 characters long',
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isShowPassword = !_isShowPassword;
                          });
                        },
                        icon: Icon(
                          !_isShowPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    obscureText: !_isShowPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password!';
                      }
                      if (value.length < 8) {
                        return 'The password is too short; it must have at least 8 characters.';
                      }
                      return null;
                    },
                  ),

                  Expanded(flex: 1, child: Container()),

                  ElevatedButton(
                    onPressed: () => _handleLogin(),
                    child: Text('Login'),
                  ),

                  Expanded(flex: 1, child: Container()),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account yet?'),
                      TextButton(
                        onPressed: () {
                          context.push(AppRoute.register.path);
                        },
                        child: Text('Register now!'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleLogin() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      context.read<AuthBloc>().add(
        AuthLogin(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        ),
      );
    }
  }
}
