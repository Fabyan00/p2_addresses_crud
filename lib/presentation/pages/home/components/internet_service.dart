import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum InternetStatus { connected, disconnected }

class InternetConnectionService {
  final StreamController<InternetStatus> _statusController = StreamController<InternetStatus>.broadcast();

  Stream<InternetStatus> get onStatusChange => _statusController.stream;

  Future<bool> get hasInternetAccess async {
    // Implement your logic to check for internet access
    // Example: return
    return await InternetConnection().hasInternetAccess;
  }

  void checkInternetConnection() async {
    final hasInternet = await hasInternetAccess;
    _statusController.add(hasInternet ? InternetStatus.connected : InternetStatus.disconnected);
  }

  void dispose() {
    _statusController.close();
  }
}