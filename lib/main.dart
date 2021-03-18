import 'package:flutter/material.dart';
import 'package:githubuser/page/bookmark.dart';
import 'package:githubuser/page/users.dart';
import 'package:githubuser/provider/bookmarkData.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookmarkData(),
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.black),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Github Users",
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Text("Users"),
                  ),
                  Tab(icon: Text("Bookmarks")),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                UsersTab(),
                BookmarksTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
