import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_github_dev_dojo/model/repository.dart';
import 'package:flutter_app_github_dev_dojo/screen/repository_code_screen.dart';
import 'package:flutter_app_github_dev_dojo/screen/user_screen.dart';
import 'package:flutter_app_github_dev_dojo/widgets/text_icon.dart';

class RepositoryTabScreen extends StatefulWidget {

  final Repository repository;

  const RepositoryTabScreen({Key key, this.repository}) : super(key: key);
  @override
  _RepositoryTabScreenState createState() => _RepositoryTabScreenState();
}

class _RepositoryTabScreenState extends State<RepositoryTabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScroled){
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScroled,
                title: Text("${widget.repository.name}"),
                snap: true,
                floating: true,
                titleSpacing: 0,
                bottom: TabBar(
                  tabs: [
                    Container(
                      child: const TextIcon(title: "Código", icon: const Icon(Icons.code)),
                      width: MediaQuery.of(context).size.width * 0.4
                    ),
                    Container(
                      child: const TextIcon(title: "Proprietário", icon: const Icon(Icons.person)),
                      width: MediaQuery.of(context).size.width * 0.4
                    )
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            children: [
              RepositoryCodeScreen(repository: widget.repository),
              UserScreen(url: widget.repository.owner.url)
            ],
          ),
        ),
      ),
    );
  }
}
