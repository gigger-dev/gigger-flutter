import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class PlaceSelectSheet extends StatefulWidget {
  const PlaceSelectSheet({super.key});

  @override
  State<PlaceSelectSheet> createState() => _PlaceSelectSheetState();
}

class _PlaceSelectSheetState extends State<PlaceSelectSheet> {
  // Position? _currentPosition;

  late GoogleMapController controller;

  final LatLng _currentLatLng =
      const LatLng(27.671332124757402, 85.3125417636781);

  // @override
  // void initState() {
  //   super.initState();
  //   goToCurrentLocation();
  // }

  // Future<void> goToCurrentLocation() async {
  //   await Geolocator.checkPermission();
  //   await Geolocator.requestPermission();
  //   _currentPosition = await Geolocator.getCurrentPosition(
  //     locationSettings: LocationSettings(
  //       accuracy: LocationAccuracy.high,
  //     ),
  //   );
  //   _currentLatLng =
  //       LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
  //   controller.animateCamera(CameraUpdate.newLatLng(_currentLatLng));
  //   if (!mounted) return;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    var bottomViewInset = MediaQuery.of(context).viewInsets.bottom;

    var bottom = (bottomViewInset > 20 ? 20 : 90) + bottomViewInset;

    var border = OutlineInputBorder(borderRadius: BorderRadius.circular(25));

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              CupertinoIcons.clear,
              color: colorWhite,
              size: 28,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 14, bottom: 20),
            child: TextViewWidget(text: 'Choose location on map: '),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25)),
              child: Stack(
                children: [
                  GoogleMap(
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    initialCameraPosition:
                        CameraPosition(zoom: 16, target: _currentLatLng),
                    onMapCreated: (controller) {
                      this.controller = controller;
                      setState(() {});
                    },
                  ),
                  Positioned(
                    left: 20,
                    right: 50,
                    bottom: bottom,
                    child: TextField(
                      style: const TextStyle(color: colorWhite, fontSize: 12),
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        border: border,
                        focusedBorder: border,
                        fillColor: Colors.black,
                        hintText: 'Enter an address ...',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        hintStyle:
                            const TextStyle(color: colorWhite, fontSize: 12),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: bottom,
                    child: FilledButton(
                      onPressed: () {
                        // goToCurrentLocation();
                      },
                      style: FilledButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(14),
                        backgroundBuilder: (context, states, child) {
                          return Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [colorRed, colorOrangeRed],
                              ),
                            ),
                            child: child,
                          );
                        },
                      ),
                      child: const Icon(
                        Icons.gps_not_fixed_sharp,
                        size: 20,
                        color: colorGreyLight,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 24,
                    right: 24,
                    child: GradientFilledButton(
                      title: 'Done',
                      onPressed: () => context.pop(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
