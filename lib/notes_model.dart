class NotesModel {
  final int? id;
  final String title;

  final String email;
  final String password;

  NotesModel({
    this.id,
    required this.title,
    required this.email,
    required this.password,
  });

  NotesModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        email = res['email'],
        password = res['password'];

  Map<String, Object?> toMap() {
    return {'id': id, 'title': title, 'email': email, 'password': password};
  }
}
