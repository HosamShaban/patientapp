class Register {
  late int id;
  late String name;
  late String email;
  late String password;

  Register(this.id, this.name, this.email, this.password);

  Register.fromjson(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.email = map['email'];
    this.password = map['password'];
  }
}
