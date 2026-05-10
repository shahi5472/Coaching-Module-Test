import 'package:flutter/material.dart';

abstract class LifeCycleStateViewModel extends ChangeNotifier {
  /// Called when the view model is initialized.
  void onInit() {}

  /// Called when the view model is disposed.
  void onDispose() {}
}
