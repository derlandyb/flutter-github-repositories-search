import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_github_dev_dojo/delegate/github_search_delegate.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search repositories"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: GitHubSearchDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Center(child: Icon(FlutterIcons.github_zoc, size: 48,)),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: const Text("Searh public repositories"))
          )
        ]
      ),
    );
  }
}
