import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';

class PlaceSelectSheet extends StatefulWidget {
  const PlaceSelectSheet({
    super.key,
    required this.latLong,
  });

  final LatLng? latLong;

  @override
  State<PlaceSelectSheet> createState() => _PlaceSelectSheetState();
}

class _PlaceSelectSheetState extends State<PlaceSelectSheet> {
  LatLng? pickedLocation;

  final query = TextEditingController();

  late GoogleMapController controller;

  late LatLng _currentLatLng;

  @override
  void initState() {
    super.initState();
    _currentLatLng =
        widget.latLong ?? const LatLng(27.671332124757402, 85.3125417636781);

    if (widget.latLong != null) {
      goToLocation();
    } else {
      goToCurrentLocation();
    }
    query.addListener(() {
      if (mounted) setState(() {});
    });
  }

  Future<void> goToLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    pickedLocation = widget.latLong;
    _currentLatLng = widget.latLong!;
    if (mounted) setState(() {});
  }

  Future<void> goToCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    var _currentPosition = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
    _currentLatLng =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);
    pickedLocation = _currentLatLng;

    if (mounted) setState(() {});

    controller.animateCamera(CameraUpdate.newLatLng(_currentLatLng));
  }

  @override
  Widget build(BuildContext context) {
    var bottomViewInset = MediaQuery.viewInsetsOf(context).bottom;

    var bottom = (bottomViewInset > 20 ? 20 : 90) + bottomViewInset;

    var border = OutlineInputBorder(borderRadius: BorderRadius.circular(25));

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: context.pop,
            icon: const Icon(CupertinoIcons.clear, color: colorWhite, size: 28),
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
                    mapToolbarEnabled: false,
                    initialCameraPosition:
                        CameraPosition(zoom: 18, target: _currentLatLng),
                    markers: pickedLocation == null
                        ? {}
                        : {
                            Marker(
                              markerId: MarkerId('selected'),
                              position: pickedLocation!,
                            )
                          },
                    onMapCreated: (controller) {
                      this.controller = controller;
                      if (mounted) setState(() {});
                    },
                    onTap: (v) {
                      pickedLocation = v;
                      if (mounted) setState(() {});
                    },
                  ),
                  Positioned(
                    left: 20,
                    right: 50,
                    bottom: bottom,
                    child: TextField(
                      controller: query,
                      onSubmitted: (value) async {
                        if (value.isEmpty) return;

                        getLocation(value);
                      },
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
                        if (query.text.trim().isEmpty) {
                          goToCurrentLocation();
                        } else {
                          getLocation(query.text.trim());
                        }
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
                      child: Icon(
                        query.text.trim().isEmpty
                            ? Icons.gps_not_fixed_sharp
                            : CupertinoIcons.search,
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
                      onPressed: onDone,
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

  Future<void> getLocation(String value) async {
    context.clearFocus();

    var items = await locationFromAddress(value);

    if (items.isEmpty) return;

    var item = items.first;
    pickedLocation = LatLng(item.latitude, item.longitude);
    setState(() {});

    controller.animateCamera(CameraUpdate.newLatLngZoom(pickedLocation!, 14));
  }

  Future<void> onDone() async {
    if (pickedLocation == null) return;

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        pickedLocation!.latitude,
        pickedLocation!.longitude,
      );

      if (placemarks.isEmpty) return;

      if (!mounted) return;

      context.pop([pickedLocation, placemarks]);
    } catch (e, _) {
      Toast.error(e.toString());
    }
  }
}

class PlaceData {
  final LatLng latLng;
  final Placemark placemark;

  PlaceData({required this.latLng, required this.placemark});
}
