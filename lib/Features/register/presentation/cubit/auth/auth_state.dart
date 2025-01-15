part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
// Login states =================================================================

final class SigninLoading extends AuthState {}

final class SigninSuccess extends AuthState {}

final class SigninFailed extends AuthState {
  final String error;

  SigninFailed(this.error);
}

// Logout states =================================================================

final class SignoutLoading extends AuthState {}

final class SignoutSuccess extends AuthState {}

final class SignoutFailed extends AuthState {
  final String error;

  SignoutFailed(this.error);
}

//======== sign in with google ====================
final class SigninWithGoogleLoading extends AuthState {}

final class SigninWithGoogleSuccess extends AuthState {}

final class SigninWithGoogleFailed extends AuthState {
  final String error;

  SigninWithGoogleFailed(this.error);
}

//==============reset password ===================
final class ResetPasswordLoading extends AuthState {}

final class ResetPasswordSuccess extends AuthState {}

final class ResetPasswordfaild extends AuthState {
  final String error;

  ResetPasswordfaild({required this.error});
}
