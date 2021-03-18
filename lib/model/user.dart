class User {
  String login;
  String id;
  String avatarUrl;

  User({this.login, this.id, this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        login: json["login"],
        id: json["id"].toString(),
        avatarUrl: json["avatar_url"]);
  }
}

List<User> usersFromJson(responseBody) =>
    List<User>.from(responseBody.map((x) => User.fromJson(x)));
