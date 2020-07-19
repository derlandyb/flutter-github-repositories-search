import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_github_dev_dojo/model/repository.dart';
import 'package:flutter_app_github_dev_dojo/model/repository_content.dart';
import 'package:flutter_app_github_dev_dojo/service/github_service.dart';
import 'package:flutter_app_github_dev_dojo/widgets/async_layout_constructor.dart';
import 'package:flutter_app_github_dev_dojo/widgets/list_content.dart';

class RepositoryCodeScreen extends StatefulWidget {

  final Repository repository;

  const RepositoryCodeScreen({Key key, this.repository}) : super(key: key);

  @override
  _RepositoryCodeScreenState createState() => _RepositoryCodeScreenState();
}

class _RepositoryCodeScreenState extends State<RepositoryCodeScreen> with AutomaticKeepAliveClientMixin<RepositoryCodeScreen>{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: AsyncLayoutConstructor<List<RepositoryContent>>(
        future: GithubService.findAllContentByFullName(widget.repository.fullName),
        hasDataWidget: (data) {
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [],
            body: ListContent(contents: data),
          );
        },
        hasErrorWidget: (err) => const Center(child: Text("Ocorreu um erro")),
        loadingWidget: () => const Center(child: CircularProgressIndicator()),
        hasDataEmptyWidget: () => Container(),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
