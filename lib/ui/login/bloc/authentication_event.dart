abstract class AuthEvent {}

class AuthLoadingRequest extends AuthEvent {
  String username;
  String passeord;
  AuthLoadingRequest(this.username, this.passeord);
}
