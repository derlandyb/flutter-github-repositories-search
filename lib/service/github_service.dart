import 'dart:convert';

import 'package:flutter_app_github_dev_dojo/http/http_provider.dart';
import 'package:flutter_app_github_dev_dojo/model/repository_content.dart';
import 'package:flutter_app_github_dev_dojo/model/user.dart';
import 'package:flutter_app_github_dev_dojo/util/api_path.dart';
import 'package:flutter_app_github_dev_dojo/util/pagination.dart';
import 'package:flutter_app_github_dev_dojo/model/repository.dart';

abstract class GithubService {
  static Future <Pagination<Repository>> findAllRepositoryByName(String name, int page) async {
    var response = await HttpProvider.get("$apiPath/search/repositories?q=$name&page=$page");

    var keymap = json.decode(response.body);

    Iterable iterable = keymap['items'];

    List<Repository> repositories = iterable.map((repository) => Repository.fromJson(repository)).toList();

    return Pagination<Repository>(items: repositories, total: keymap["total_count"]);
  }

  static Future<List<RepositoryContent>> findAllContentByFullName(String fullName) async {
    var response = await HttpProvider.get("$apiPath/repos/$fullName/contents");

    Iterable itarable = json.decode(response.body);

    return itarable.map((content) => RepositoryContent.fromJson(content)).toList();
  }

  static Future<List<RepositoryContent>> findFolderByUrl(String url) async{
    var response = await HttpProvider.get(url);
    Iterable itarable = json.decode(response.body);
    return itarable.map((content) => RepositoryContent.fromJson(content)).toList();
  }

  static Future<RepositoryContent> findFileByUrl(String url) async {
    var response = await HttpProvider.get(url);

    return RepositoryContent.fromJson(json.decode(response.body));
  }

  static Future<User> findUserByUrl(String url) async{
    var response = await HttpProvider.get(url);
    return User.fromJson(json.decode(response.body));
  }
}