import 'package:flutter/cupertino.dart';

class WidgetCallSafe extends StatelessWidget {
  final bool Function() checkIfNull;
  final Widget Function() success;
  final Widget Function() fail;

  const WidgetCallSafe({
    Key key,
    @required this.checkIfNull,
    @required this.success,
    @required this.fail
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isTrue = checkIfNull();

    if(isTrue) {
      return success();
    }

    return fail();
  }
}
