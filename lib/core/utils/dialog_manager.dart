import 'package:flutter/cupertino.dart';
import 'package:test_task/core/core.dart';

class DialogManager {
  static Future<void> showErrorDialog(BuildContext context, {required String message}) async =>
      await showCupertinoDialog<void>(
        context: context,
        builder: (context) => ErrorDialog(message: message),
      );
}
