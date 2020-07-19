import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_github_dev_dojo/model/repository_content.dart';
import 'package:flutter_app_github_dev_dojo/service/github_service.dart';
import 'package:flutter_app_github_dev_dojo/widgets/async_layout_constructor.dart';
import 'package:flutter_app_github_dev_dojo/widgets/widget_call_safe.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class RepositoryContentBlobScreen extends StatelessWidget {

  final Base64Codec base64codec = Base64Codec();
  final Utf8Codec utf8codec = Utf8Codec();

  final RepositoryContent content;

  RepositoryContentBlobScreen({Key key, this.content}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              titleSpacing: 0,
              title: Text(content.name ?? content.path),
            )
          ];
        },
        body: AsyncLayoutConstructor<RepositoryContent>(
          future: GithubService.findFileByUrl(content.url),
          hasDataWidget: (data){
            final String decodedContent = tryDecode(data);

            return WidgetCallSafe(
              checkIfNull: () => decodedContent != null,
              fail: () => Center(child: Text("Não foi possível ler o arquivo")),
              success: () {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: HighlightView(
                      decodedContent,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      theme: githubTheme,
                      language: "javascript",
                    ),
                  ),
                );
              },
            );
          },
          hasErrorWidget: (err) => const Center(child: Text("Ocorreu um erro")),
          loadingWidget: () => const Center(child: CircularProgressIndicator()),
          hasDataEmptyWidget: () => Container(),
        ),
      ),
    );
  }

  String tryDecode(RepositoryContent content) {
    try {
      return utf8codec.decode(base64codec.decode(content.content.replaceAll("\n", "")));
    } catch(err) {
      print(err);
      return null;
    }
  }
}
