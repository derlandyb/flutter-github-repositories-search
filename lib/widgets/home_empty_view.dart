import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomeEmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Center(child: Icon(FlutterIcons.github_zoc, size: 48,)),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: const Text("Searh public repositories"))
          )
        ]
    );
  }
}
