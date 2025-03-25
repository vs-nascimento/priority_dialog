import 'package:flutter/material.dart';
import 'package:priority_dialog/src/core/dialog_priority.dart';

abstract class IDialog {
  void show({
    required String id,
    String? title,
    String? content,
    List<Widget>? actions,
    DialogPriority priority,
    bool isFixed,
    bool Function()? canBeClosed,
    Widget? customDialog,
  });

  void closeDialog(String id);

  void clearAllDialogs();
  bool isDialogOpen();
}
