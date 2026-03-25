import 'package:flutter/cupertino.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Ошибка'),
      content: Text(message, maxLines: 50, overflow: TextOverflow.ellipsis),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('ОК'),
        ),
      ],
    );
  }
}
