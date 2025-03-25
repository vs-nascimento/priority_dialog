# `PriorityDialog` - A Dialog Management System with Priority and Customization

## Overview

The `priority_dialog` package provides a flexible and powerful solution for managing dialogs in Flutter applications. It allows developers to display dialogs with varying priorities, ensuring that higher-priority dialogs (such as mandatory updates or critical messages) are displayed over lower-priority ones. Additionally, it provides mechanisms to handle custom dialogs, dialog closures, and fixed dialogs that cannot be dismissed.

This package is ideal for applications that require complex dialog management with control over dialog priorities, conditions for closing dialogs, and customizable content.

## Features

- **Priority-based Dialog Management**: Show dialogs with different priorities, ensuring that important dialogs (such as updates or alerts) are shown first.
- **Customizable Dialogs**: Display custom dialogs with user-defined content, including actions, titles, and more.
- **Conditional Dialog Closure**: Define custom logic for dialog closure using a `canBeClosed` callback to decide whether a dialog can be dismissed.
- **Fixed Dialogs**: Keep essential dialogs on screen by marking them as fixed, preventing them from being dismissed until explicitly removed.
- **Global Navigation**: Manage dialogs using a `GlobalKey<NavigatorState>`, allowing for seamless navigation between dialogs and interaction with the app’s navigation priority.
- **Support for Multiple Dialogs**: Show multiple dialogs with different priorities, ensuring the user experience is not interrupted by less important dialogs.

## Installation

To use `priority_dialog` in your Flutter project, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  priority_dialog: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Setup

To get started, create a `PriorityDialog` instance and provide it with a `GlobalKey<NavigatorState>` that you will use for navigation. This key is essential for managing dialog navigation.

If you need the dialog to be globally accessible throughout your app, you can make `PriorityDialog` a singleton using a state management solution like **GetIt** or **GetX**.

#### Using GetIt:

```dart
// Register PriorityDialog as a singleton
final GetIt getIt = GetIt.instance;
getIt.registerSingleton<PriorityDialog>(PriorityDialog(navigatorKey: GlobalKey<NavigatorState>()));
```

#### Using GetX:

```dart
// Register PriorityDialog as a singleton
class DialogController extends GetxController {
  final PriorityDialog priorityDialog = PriorityDialog(navigatorKey: GlobalKey<NavigatorState>());
}

void main() {
  Get.put(DialogController());
}
```

### Show a Dialog

You can display a dialog by calling the `show` method. This method allows you to specify parameters like the dialog's title, content, actions, priority, and more.

```dart
PriorityDialog.show(
  id: 'update-dialog',
  title: 'Update Available',
  content: 'A new version of the app is available. Please update now.',
  actions: [
    TextButton(onPressed: () {}, child: Text("Update")),
    TextButton(onPressed: () {}, child: Text("Cancel"))
  ],
  priority: DialogPriority.high,
  isFixed: true, // Prevents closure until the update is performed
  canBeClosed: () => false, // Dialog can't be closed
);
```

### Close a Dialog

To close a dialog, use the `closeDialog` method with the dialog's ID. This will remove the dialog from the priority if it can be closed.

```dart
PriorityDialog.closeDialog('update-dialog');
```

### Clear All Dialogs

To clear all open dialogs, you can use the `clearAllDialogs` method. This is useful for resetting the dialog priority.

```dart
PriorityDialog.clearAllDialogs();
```

### Check if a Dialog is Open

You can check if any dialog is currently open using the `isDialogOpen` method.

```dart
bool dialogOpen = PriorityDialog.isDialogOpen();
```

## Example

Here's a simple example where a mandatory update dialog is shown with high priority, ensuring that it stays open until the user interacts with it.

```dart
class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final PriorityDialog priorityDialog;

  MyApp({super.key}) : priorityDialog = PriorityDialog(navigatorKey: navigatorKey);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(title: Text('Priority Dialog Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              priorityDialog.show(
                id: 'mandatory-update',
                title: 'App Update Required',
                content: 'Please update the app to continue using it.',
                priority: DialogPriority.high,
                isFixed: true,
                canBeClosed: () => false,
              );
            },
            child: Text('Show Update Dialog'),
          ),
        ),
      ),
    );
  }
}
```

## Dialog Priority

The `DialogPriority` enum allows you to assign a priority to each dialog:

- `DialogPriority.low` - Low priority dialog.
- `DialogPriority.medium` - Medium priority dialog.
- `DialogPriority.high` - High priority dialog.

Dialogs with higher priority will replace lower-priority ones if both are displayed at the same time.

## Conclusion

The `priority_dialog` package offers an easy-to-use and flexible solution for managing dialogs in Flutter. Whether you're handling mandatory updates, showing error messages, or providing user notifications, `priority_dialog` provides the tools you need to create a seamless dialog experience with full control over their display and behavior.
