import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githubuser/model/user.dart';
import 'package:githubuser/page/SearchPage.dart';
import 'package:githubuser/provider/bookmarkData.dart';
import 'package:githubuser/services/githubDataHandler.dart';
import 'package:provider/provider.dart';

class UsersTab extends StatefulWidget {
  @override
  _UsersTabState createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  List<User> users = [];
  String since = "0";
  ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    Provider.of<BookmarkData>(context, listen: false).fetchBookmarkData();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var bookmarkList = Provider.of<BookmarkData>(context);
    return RefreshIndicator(
      onRefresh: () {
        since = "0";
        users.clear();
        return loadData();
      },
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              List<String> logins = [], avatarUrl = [];
              for (int i = 0; i < users.length; i++) {
                logins.add(users[i].login);
                avatarUrl.add(users[i].avatarUrl);
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchPage(
                            logins: logins,
                            avatarUrls: avatarUrl,
                            appBarText: "loaded users",
                          )));
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(7),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(3)),
              alignment: Alignment.centerLeft,
              child: Text(
                "Search",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemBuilder: (context, index) {
                if (index != users.length - 1) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 8),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      NetworkImage(users[index].avatarUrl),
                                ),
                              ),
                              Text(users[index].login),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                                bookmarkList.logins.contains(users[index].login)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border),
                            onPressed: () {
                              if (bookmarkList.logins
                                  .contains(users[index].login)) {
                                bookmarkList.deleteUser(
                                    users[index].login, users[index].avatarUrl);
                              } else {
                                bookmarkList.addUser(
                                    users[index].login, users[index].avatarUrl);
                              }
                            },
                          )
                        ],
                      ),
                      Divider(),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 8),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      NetworkImage(users[index].avatarUrl),
                                ),
                              ),
                              Text(users[index].login),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                                bookmarkList.logins.contains(users[index].login)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border),
                            onPressed: () {
                              if (bookmarkList.logins
                                  .contains(users[index].login)) {
                                bookmarkList.deleteUser(
                                    users[index].login, users[index].avatarUrl);
                              } else {
                                bookmarkList.addUser(
                                    users[index].login, users[index].avatarUrl);
                              }
                            },
                          )
                        ],
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    ],
                  );
                }
              },
              itemCount: users.length,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadData() async {
    List<User> temp = await getUsersList(since);
    setState(() {
      users.addAll(temp);
      since = users.last.id;
    });
  }
}
