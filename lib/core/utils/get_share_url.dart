import 'package:mobile_gigger_app/core/consts/const.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';

String getProfileShareUrl(String uuid) {
  return '$redirectUrl${ProfileRoute(uuid: uuid).location}';
}

String getGiglistShareUrl(String uuid) {
  return '$redirectUrl${GiglistScrollRoute(uuid: uuid).location}';
}

String getEventShareUrl(String uuid) {
  return '$redirectUrl${EventScrollRoute(uuid: uuid).location}';
}

String getSupShareUrl(String uuid) {
  return '$redirectUrl${SupRoute(uuid: uuid).location}';
}

String getVideoShareUrl(String uuid) {
  return '$redirectUrl${VideoPlayerRoute(uuid: uuid).location}';
}
