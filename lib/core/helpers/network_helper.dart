import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';

class NetworkHelper {
  static StreamSubscription<List<ConnectivityResult>> listen() {
    return Connectivity().onConnectivityChanged.listen(_showToast);
  }

  static Future<bool> check() async {
    // Toast.show('No Internet Connection');
    // return false;
    var result = await Connectivity().checkConnectivity();
    return _showToast(result);
  }

  static bool _showToast(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      Toast.show('No Internet Connection');
      return false;
    }

    return true;
  }
}
