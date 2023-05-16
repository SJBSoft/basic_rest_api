class User {
 final int id;
  final String username;
  final String name;
  final String email;
  final String? profileImage;
  String? token;

  User({required this.id, required this.username, required this.name, required this.email, this.profileImage, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        name: json['name'],
        profileImage: json['profile_image'],
        token: json['token'],
        email: json['email']);
  }



}
