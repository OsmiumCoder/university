part of 'authorization_cubit.dart';

abstract class AuthorizationState extends Equatable {
  const AuthorizationState();
}

class AuthorizationSignedOut extends AuthorizationState {
  @override
  List<Object> get props => [];
}

class AuthorizationSignedIn extends AuthorizationState {
  String initials;
  AuthorizationSignedIn({initials}) : this.initials = initials??"ABC";

  @override
  List<Object> get props => [];
}
