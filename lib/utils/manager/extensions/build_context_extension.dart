import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  void get unFocus => FocusScope.of(this).unfocus();
}
