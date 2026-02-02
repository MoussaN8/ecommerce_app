abstract class Failures {
  final String message;
  const Failures(this.message);
}

class AuthFailure extends Failures {
  const AuthFailure(super.message);
}

class ServerFailure extends Failures {
  const ServerFailure(super.message);
}

class ConnectionFailure extends Failures {
  const ConnectionFailure(super.message);
}

