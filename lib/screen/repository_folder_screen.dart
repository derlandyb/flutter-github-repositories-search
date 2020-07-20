import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_github_dev_dojo/model/repository_content.dart';
import 'package:flutter_app_github_dev_dojo/service/github_service.dart';
import 'package:flutter_app_github_dev_dojo/widgets/async_layout_constructor.dart';
import 'package:flutter_app_github_dev_dojo/widgets/list_content.dart';

class RepositoryFolderScreen extends StatelessWidget {
  final RepositoryContent content;

  const RepositoryFolderScreen({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(content.name), titleSpacing: 0),
      body: AsyncLayoutConstructor<List<RepositoryContent>>(
        future: GithubService.findFolderByUrl(content.url),
        hasDataWidget: (data) => ListContent(contents: data),
        hasErrorWidget: (err) => const Center(child: Text("Error occurred")),
        loadingWidget: () => const Center(child: CircularProgressIndicator()),
        hasDataEmptyWidget: () => Container(),
      ),
    );
  }
}
