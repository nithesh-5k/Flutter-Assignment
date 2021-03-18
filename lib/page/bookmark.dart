import 'package:flutter/material.dart';
import 'package:githubuser/page/SearchPage.dart';
import 'package:githubuser/provider/bookmarkData.dart';
import 'package:provider/provider.dart';

class BookmarksTab extends StatefulWidget {
  @override
  _BookmarksTabState createState() => _BookmarksTabState();
}

class _BookmarksTabState extends State<BookmarksTab> {
  @override
  Widget build(BuildContext context) {
    var bookmarkList = Provider.of<BookmarkData>(context);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchPage(
                          logins: bookmarkList.logins,
                          avatarUrls: bookmarkList.avatarUrls,
                          appBarText: "bookmarks",
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
            itemBuilder: (context, index) {
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
                                  NetworkImage(bookmarkList.avatarUrls[index]),
                            ),
                          ),
                          Text(bookmarkList.logins[index]),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.bookmark),
                        onPressed: () {
                          bookmarkList.deleteUser(bookmarkList.logins[index],
                              bookmarkList.avatarUrls[index]);
                        },
                      ),
                    ],
                  ),
                  Divider(),
                ],
              );
            },
            itemCount: bookmarkList.logins.length,
          ),
        ),
      ],
    );
  }
}
