import 'package:flutter/material.dart';
import 'package:priority_dialog/priority_dialog.dart';

class DialogEntry {
  final String id;
  final Widget dialog;
  final DialogPriority priority;
  final bool isFixed;
  final bool Function()? canBeClosed;

  DialogEntry({
    required this.id,
    required this.dialog,
    this.priority = DialogPriority.medium,
    this.isFixed = false,
    this.canBeClosed,
  });
}
