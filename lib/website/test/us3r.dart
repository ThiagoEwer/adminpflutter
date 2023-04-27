class User {
  final String email;
  final int telefone;
  final int porta;
  final Map<String, String> empresas;
  final Map<String, String> urls;

  User({
    required this.email,
    required this.telefone,
    required this.porta,
    required this.empresas,
    required this.urls,
  });
}
