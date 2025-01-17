import 'package:email_validator/email_validator.dart';
import 'package:flow_app/domain/auth/auth_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flow_app/application/auth/login_bloc.dart';

import 'login_state.dart';

class LoginBloc extends StateNotifier<LoginState> {
  final AuthRepo authRepo;

  LoginBloc(this.authRepo)
      : super(LoginState(
          email: '',
          password: '',
        ));

  void emailChanged(String email) {
    final isValid = EmailValidator.validate(email);
    state = state.copyWith(
        email: email,
        emailError: isValid ? null : 'Please enter a valid email!');
  }

  void passwordChanged(String password) {
    final isValid = password.length > 6;
    state = state.copyWith(
        password: password,
        passwordError: isValid
            ? null
            : 'The lenght of the password should be at least 7 characters!');
  }

  void loginPressed() {
    if (state.emailError == null && state.passwordError == null) {
      authRepo.login(state.email, state.password);
    }
  }

  void registerPressed() {
    if (state.emailError == null && state.passwordError == null) {
      authRepo.register(state.email, state.password);
    }
  }
}

final loginBlocProvider = StateNotifierProvider<LoginBloc>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return LoginBloc(authRepo);
});
