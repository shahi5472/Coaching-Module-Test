import 'package:connectivity_plus/connectivity_plus.dart';

import 'internet_change_notifier.dart';
import 'network_info.dart';

class NetworkInfoImpl implements INetworkInfo {
  final Connectivity _connectivity;
  final InternetChangeNotifier notifier;

  NetworkInfoImpl({
    required Connectivity connectivity,
    required this.notifier,
  }) : _connectivity = connectivity;

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await (_connectivity.checkConnectivity());
    _connectivity.onConnectivityChanged.listen((result) {
      if (connectivityResult.contains(ConnectivityResult.none) || connectivityResult.contains(ConnectivityResult.bluetooth) || connectivityResult.contains(ConnectivityResult.other)) {
        notifier.value = false;
      } else {
        notifier.value = true;
      }
    });
    return (connectivityResult.contains(ConnectivityResult.none) || connectivityResult.contains(ConnectivityResult.bluetooth) || connectivityResult.contains(ConnectivityResult.other)) ? false : true;
  }
}
