import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../widgets/email_text_field.dart';
import '../../../widgets/password_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

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

          if (state is AuthRegisterSuccess) {
            context.go(AppRoute.login.path);
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
                          children: [
                            const Spacer(flex: 2,),

                            const Text(
                              'Đăng ký',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Spacer(flex: 1,),

                            // email
                            EmailTextField(
                              controller: _emailController,
                              textInputAction: TextInputAction.next,
                            ),

                            SizedBox(height: 24),

                            // password
                            PasswordTextField(
                              controller: _passwordController,
                              labelText: 'Mật khẩu',
                              hintText: 'Mật khẩu phải có tối thiểu 6 ký tự',
                              textInputAction: TextInputAction.next,
                            ),

                            SizedBox(height: 24),

                            // confirm password
                            PasswordTextField(
                              controller: _confirmController,
                              labelText: 'Xác nhận mật khẩu',
                              hintText: 'Nhập lại mật khẩu tại đây',
                              textInputAction: TextInputAction.go,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mật khẩu xác nhận không được để trống!';
                                }
                                if (value != _passwordController.text) {
                                  return 'Mật khẩu xác nhận không khớp với mật khẩu đã nhập!';
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) => _handleRegister(),
                            ),

                            Spacer(flex: 2,),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 8,
                                shadowColor: Colors.black.withOpacity(0.5),
                              ),
                              onPressed: _handleRegister,
                              child: const Text(
                                'Đăng ký',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),

                            Spacer(flex: 1,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Đã có tài khoản?'),
                                TextButton(
                                  onPressed: () =>
                                      context.go(AppRoute.login.path),
                                  child: const Text('Đăng nhập ngay!'),
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

  void _handleRegister() {
    if (_key.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthRegister(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        ),
      );
    }
  }
}
