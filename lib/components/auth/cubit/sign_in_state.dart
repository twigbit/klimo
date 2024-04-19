part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {
  final String? email;
  const SignInInitial({this.email = ''});

  SignInState copyWith({String? email}) {
    return SignInInitial(email: email ?? this.email);
  }

  @override
  List<Object?> get props => [email!];
}

class SignInLoading extends SignInState {
  final bool isEmailAuth;

  const SignInLoading({this.isEmailAuth = false});

  @override
  List<Object?> get props => [isEmailAuth];
}

class SignInAwaitEmailConfirmation extends SignInInitial {
  const SignInAwaitEmailConfirmation(String email) : super(email: email);
}

class SignInError extends SignInInitial {
  final String error;

  const SignInError(this.error, {String? email}) : super(email: email);

  @override
  List<Object?> get props => [error, email!];
}

class SignInSuccess extends SignInState {}
