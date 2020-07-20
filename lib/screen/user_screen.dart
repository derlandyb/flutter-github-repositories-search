import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_github_dev_dojo/model/user.dart';
import 'package:flutter_app_github_dev_dojo/service/github_service.dart';
import 'package:flutter_app_github_dev_dojo/widgets/async_layout_constructor.dart';
import 'package:flutter_app_github_dev_dojo/widgets/widget_call_safe.dart';

class UserScreen extends StatefulWidget {
  final String url;

  const UserScreen({Key key, @required this.url}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>  with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AsyncLayoutConstructor<User>(
        future: GithubService.findUserByUrl(widget.url),
        hasDataWidget: (user){
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [],
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.network(user.avatarUrl),
                    title: Text("${user.name}"),
                    subtitle: Text("${user.login}"),
                  ),
                  WidgetCallSafe(
                    checkIfNull: () => user.email != null || user.bio != null,
                    success: () {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          WidgetCallSafe(
                            checkIfNull: () => user.email != null,
                            success: () {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(user.email),
                              );
                            },
                            fail: () => Container(),
                          ),
                          WidgetCallSafe(
                            checkIfNull: () => user.bio != null,
                            success: () {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(user.bio),
                              );
                            },
                            fail: () => Container(),
                          ),
                          WidgetCallSafe(
                            checkIfNull: () => user.company != null,
                            success: () {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.people),
                                title: Text(user.company)
                              );
                            },
                            fail: () => Container(),
                          ),
                          WidgetCallSafe(
                            checkIfNull: () => user.location != null,
                            success: () {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.person_pin_circle),
                                title: Text(user.location)
                              );
                            },
                            fail: () => Container(),
                          )
                        ],
                      );
                    },
                    fail: () => Container() ,
                  ),
                ],
              ),
            ),
          );
        },
        hasDataEmptyWidget: () => Container(),
        hasErrorWidget: (err) => const Center(child: const Text("Error occurred")),
        loadingWidget: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
