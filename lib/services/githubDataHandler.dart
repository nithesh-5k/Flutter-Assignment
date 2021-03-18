import 'package:githubuser/model/user.dart';
import 'package:githubuser/services/request.dart';

Future<List<User>> getUsersList(String since) async {
  List<User> users = [];
  Uri uri = Uri.parse("https://api.github.com/users?since=$since&per_page=10");
  dynamic responseBody = await getRequest(uri);
  users = usersFromJson(responseBody);
  return users;
}
