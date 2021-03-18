import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkData extends ChangeNotifier {
  List<String> logins = [], avatarUrls = [];
  bool onceFlag = true;

  void addUser(String login, String avatarUrl) {
    logins.add(login);
    avatarUrls.add(avatarUrl);
    storeBookmarkData();
    notifyListeners();
  }

  void deleteUser(String login, String avatarUrl) {
    logins.remove(login);
    avatarUrls.remove(avatarUrl);
    storeBookmarkData();
    notifyListeners();
  }

  Future<void> storeBookmarkData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("logins", logins);
    await prefs.setStringList("avatarUrls", avatarUrls);
  }

  Future<void> fetchBookmarkData() async {
    if (onceFlag) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      logins = (prefs.getStringList("logins") ?? []);
      avatarUrls = (prefs.getStringList("avatarUrls") ?? []);
      onceFlag = false;
    }
  }
}
