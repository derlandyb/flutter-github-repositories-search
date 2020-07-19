import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_github_dev_dojo/model/repository_content.dart';
import 'package:flutter_app_github_dev_dojo/screen/repository_content_blob_screen.dart';
import 'package:flutter_app_github_dev_dojo/screen/repository_folder_screen.dart';

class ListContent extends StatelessWidget {

  final List<RepositoryContent> contents;
  final Map<String, Widget> typeWidget = {
    "dir": const Icon(Icons.folder, color: Colors.blue),
    "file": const Icon(Icons.insert_drive_file, color: Colors.grey)
  };

  ListContent({Key key, this.contents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<RepositoryContent> files = contents.where((element) => element.type == "file").toList();
    final List<RepositoryContent> folders = contents.where((element) => element.type == "dir").toList();
    folders.addAll(files);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      itemCount: folders.length,
      addAutomaticKeepAlives: false,
      itemBuilder: (context, index) {
        final RepositoryContent content = folders[index];
        final Widget icon = typeWidget[content.type];
        return ListTile(
          onTap: callback(context, content),
          leading: icon,
          title: Text(content.name)
        );
      },
    );
  }

  Function callback(BuildContext context, RepositoryContent content) {
    final Map<String, Function> typeCallback = {
      "dir" : () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => RepositoryFolderScreen(content: content))
        );
      },
      "file" : () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => RepositoryContentBlobScreen(content: content))
        );
      }
    };

    return typeCallback[content.type];
  }
}
