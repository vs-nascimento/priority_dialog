import 'package:flutter/material.dart';
import 'package:priority_dialog/priority_dialog.dart';

class PriorityDialog implements IDialog {
  DialogEntry? _currentDialog;
  final GlobalKey<NavigatorState> navigatorKey;

  PriorityDialog({required this.navigatorKey});

  @override
  void show({
    required String id,
    String? title,
    String? content,
    List<Widget>? actions,
    DialogPriority priority = DialogPriority.medium,
    bool isFixed = false,
    bool Function()? canBeClosed,
    Widget? customDialog,
  }) {
    Widget dialog = customDialog ?? _defaultDialog(title, content, actions);

    bool shouldReplaceCurrent() {
      if (_currentDialog == null) return true;

      if (_currentDialog!.isFixed &&
          !(priority.index > _currentDialog!.priority.index)) return false;

      if (_currentDialog!.canBeClosed != null &&
          !_currentDialog!.canBeClosed!()) {
        return false;
      }

      return priority.index > _currentDialog!.priority.index;
    }

    if (shouldReplaceCurrent()) {
      if (_currentDialog != null &&
          navigatorKey.currentState?.canPop() == true) {
        navigatorKey.currentState?.pop();
      }

      _currentDialog = DialogEntry(
        id: id,
        dialog: dialog,
        priority: priority,
        isFixed: isFixed,
        canBeClosed: canBeClosed,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState?.push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => WillPopScope(
              child: _currentDialog!.dialog,
              onWillPop: () async => !isFixed,
            ),
          ),
        );
      });
    }
  }

  static Widget _defaultDialog(
      String? title, String? content, List<Widget>? actions) {
    return AlertDialog(
      title: title != null ? Text(title) : null,
      content: content != null ? Text(content) : null,
      actions:
          actions ?? [TextButton(onPressed: () {}, child: const Text("OK"))],
    );
  }

  @override
  void closeDialog(String id) {
    if (_currentDialog?.id == id) {
      if (_currentDialog!.canBeClosed != null &&
          !_currentDialog!.canBeClosed!()) {
        return;
      }

      if (navigatorKey.currentState?.canPop() == true) {
        navigatorKey.currentState?.pop();
      }
      _currentDialog = null;
    }
  }

  @override
  void clearAllDialogs() {
    if (_currentDialog != null && !_currentDialog!.isFixed) {
      if (navigatorKey.currentState?.canPop() == true) {
        navigatorKey.currentState?.pop();
      }
      _currentDialog = null;
    }
  }

  @override
  bool isDialogOpen() => _currentDialog != null;
}
