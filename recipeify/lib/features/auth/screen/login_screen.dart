import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../widgets/email_text_field.dart';
import '../../../widgets/password_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AuthAuthenticated) {
            context.go(AppRoute.home.path);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: const CircularProgressIndicator());
          }

          return Form(
            key: _key,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // spacing: 12,
                          children: [
                            Spacer(flex: 2,),

                            const Text(
                              'Đăng nhập',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            Spacer(flex: 1,),

                            // email
                            EmailTextField(
                              controller: _emailController,
                              textInputAction: TextInputAction.next,
                            ),

                            SizedBox(height: 36),

                            // password
                            PasswordTextField(
                              controller: _passwordController,
                              labelText: 'Mật khẩu',
                              hintText: 'Nhập mật khẩu của bạn',
                              textInputAction: TextInputAction.go,
                              onFieldSubmitted: (value) => _handleLogin(),
                            ),

                            Spacer(flex: 2,),

                            // login button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 8,
                                shadowColor: Colors.black.withOpacity(0.5),
                              ),
                              onPressed: _handleLogin,
                              child: Text(
                                'Đăng nhập',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),

                            Spacer(flex: 1,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Chưa có tài khoản?'),
                                TextButton(
                                  onPressed: () {
                                    context.go(AppRoute.register.path);
                                  },
                                  child: Text('Đăng ký ngay!'),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
