import 'package:flutter/material.dart';
import 'package:priority_dialog/priority_dialog.dart';

late PriorityDialog priorityDialog;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    priorityDialog = PriorityDialog(navigatorKey: navigatorKey);

    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stack Dialog Example'),
        ),
        body: Center(
          child: PaginationDialog(),
        ),
      ),
    );
  }
}

class PaginationDialog extends StatefulWidget {
  @override
  _PaginationDialogState createState() => _PaginationDialogState();
}

class _PaginationDialogState extends State<PaginationDialog> {
  void _showMultipleDialogs() {
    _showLowPriorityDialog();
    _showMediumPriorityDialog();
    _showHighPriorityDialog();
  }

  void _showLowPriorityDialog() {
    priorityDialog.show(
      id: 'low_priority_dialog',
      title: 'Low Priority Dialog',
      content: 'This is a low priority dialog that opens at the bottom.',
      actions: [
        TextButton(
          onPressed: () {
            priorityDialog.closeDialog('low_priority_dialog');
          },
          child: const Text('Close'),
        ),
      ],
      priority: DialogPriority.low,
      canBeClosed: () {
        return true;
      },
    );
  }

  void _showMediumPriorityDialog() {
    priorityDialog.show(
      id: 'medium_priority_dialog',
      title: 'Medium Priority Dialog',
      content: 'This is a medium priority dialog that opens above the low one.',
      actions: [
        TextButton(
          onPressed: () {
            priorityDialog.closeDialog('medium_priority_dialog');
          },
          child: const Text('Close'),
        ),
      ],
      priority: DialogPriority.medium,
      isFixed: true,
    );
  }

  void _showHighPriorityDialog() {
    priorityDialog.show(
      id: 'high_priority_dialog',
      title: 'High Priority Dialog',
      content: 'This is a high priority dialog that will be on top.',
      actions: [
        TextButton(
          onPressed: () {
            priorityDialog.closeDialog('high_priority_dialog');
          },
          child: const Text('Close'),
        ),
      ],
      priority: DialogPriority.low,
      isFixed: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _showMultipleDialogs,
          child: const Text('Show Multiple Dialogs'),
        ),
      ],
    );
  }
}
