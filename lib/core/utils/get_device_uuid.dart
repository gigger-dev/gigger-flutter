import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeviceUuid() async {
  final deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    var build = await deviceInfoPlugin.androidInfo;
    return build.id;
  }

  var data = await deviceInfoPlugin.iosInfo;
  return data.identifierForVendor ?? '';
}
