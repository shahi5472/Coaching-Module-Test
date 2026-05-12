import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'internet_change_notifier.dart';
import 'network_info.dart';

class NetworkInfoImpl implements INetworkInfo {
  final Connectivity _connectivity;
  final InternetChangeNotifier notifier;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  NetworkInfoImpl({
    required Connectivity connectivity,
    required this.notifier,
  }) : _connectivity = connectivity {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      notifier.value = _hasInternet(result);
    });
  }

  bool _hasInternet(List<ConnectivityResult> result) {
    return !result.contains(ConnectivityResult.none) && !result.contains(ConnectivityResult.bluetooth) && !result.contains(ConnectivityResult.other);
  }

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return _hasInternet(connectivityResult);
  }

  void dispose() {
    _subscription?.cancel();
  }
}
