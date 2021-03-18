import 'dart:async';

import 'package:flutter/material.dart';
import 'package:githubuser/provider/bookmarkData.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  List<String> logins, avatarUrls;
  String appBarText;

  SearchPage(
      {@required this.logins,
      @required this.avatarUrls,
      @required this.appBarText});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> logins = [], avatarUrls = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchUser("");
  }

  void searchUser(String value) {
    logins.clear();
    avatarUrls.clear();
    for (int i = 0; i < widget.logins.length; i++) {
      if (widget.logins[i].toLowerCase().contains(value.toLowerCase())) {
        logins.add(widget.logins[i]);
        avatarUrls.add(widget.avatarUrls[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer debouncer;
    var bookmarkList = Provider.of<BookmarkData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search in ${widget.appBarText}"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: TextField(
              autofocus: true,
              onChanged: (value) {
                if (debouncer?.isActive ?? false) debouncer.cancel();
                debouncer = Timer(Duration(milliseconds: 300), () {
                  setState(() {
                    searchUser(value);
                  });
                });
              },
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(3),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(3),
                ),
                hintText: 'Search',
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: logins.length == 0
                ? Center(
                    child: Text("No user available"),
                  )
                : ListView.builder(
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
                                          NetworkImage(avatarUrls[index]),
                                    ),
                                  ),
                                  Text(logins[index]),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                    bookmarkList.logins.contains(logins[index])
                                        ? Icons.bookmark
                                        : Icons.bookmark_border),
                                onPressed: () {
                                  if (bookmarkList.logins
                                      .contains(logins[index])) {
                                    bookmarkList.deleteUser(
                                        logins[index], avatarUrls[index]);
                                  } else {
                                    bookmarkList.addUser(
                                        logins[index], avatarUrls[index]);
                                  }
                                },
                              ),
                            ],
                          ),
                          Divider(),
                        ],
                      );
                    },
                    itemCount: logins.length,
                  ),
          ),
        ],
      ),
    );
  }
}
