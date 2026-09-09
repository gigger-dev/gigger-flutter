import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
    required this.lat,
    required this.lng,
    required this.uuid,
  });

  final num? lat;
  final num? lng;
  final String uuid;

  @override
  Widget build(BuildContext context) {
    var latLng = lat == null || lng == null
        ? null
        : LatLng(lat!.toDouble(), lng!.toDouble());

    return Container(
      height: .34.sh,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: latLng == null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  'https://i.sstatic.net/HILmr.png',
                ),
              )
            : null,
      ),
      child: latLng == null
          ? null
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GoogleMap(
                gestureRecognizers: {Factory(() => EagerGestureRecognizer())},
                markers: {Marker(markerId: MarkerId(uuid), position: latLng)},
                initialCameraPosition: CameraPosition(zoom: 17, target: latLng),
              ),
            ),
    );
  }
}
