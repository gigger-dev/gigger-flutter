import 'package:geocoding/geocoding.dart';

String getLocationData(Placemark placemark) {
  var subLocality = placemark.subLocality ?? '';
  if (subLocality.isNotEmpty) return subLocality;

  var subAdministrativeArea = placemark.subAdministrativeArea ?? '';
  if (subAdministrativeArea.isNotEmpty) return subAdministrativeArea;

  var administrativeArea = placemark.administrativeArea ?? '';
  if (administrativeArea.isNotEmpty) return administrativeArea;

  var locality = placemark.locality ?? '';
  if (locality.isNotEmpty) return locality;

  var country = placemark.country ?? '';
  return country;
}
