class UserCreate {
  final String name;
  final String pass;
  final String email;
  final String lastname;

  UserCreate({
    required this.name,
    required this.pass,
    required this.email,
    required this.lastname,
  });
}

// {
  // "name": "jaua",
  // "lastname": "cruz",
  // "email": "luis@gmail.com",
  // "pass": "1234"
// }