import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_github_dev_dojo/delegate/github_search_delegate.dart';
import 'package:flutter_app_github_dev_dojo/widgets/home_empty_view.dart';
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
      body: HomeEmptyView(),
    );
  }
}
