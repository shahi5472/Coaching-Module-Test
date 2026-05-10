import 'dart:async';

import 'i_disposable.dart';

abstract class IDependencies extends IDisposable {
  FutureOr<void> dependencies();
}
