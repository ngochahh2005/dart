import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const AuthEvent();
}

class AuthSubscriptionStarted extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}

class AuthRegister extends AuthEvent {
  final String email;
  final String password;

  const AuthRegister(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthLogout extends AuthEvent {}
