import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/place_select_sheet.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/pro_feature_sheet.dart';
import 'package:mobile_gigger_app/widgets/share_content_widget.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SheetUtils {
  static Future<T?> showSheet<T>({
    Widget? action,
    Widget? title,
    double? height,
    Decoration? decoration,
    bool isScrollControlled = false,
    Decoration? foregroundDecoration,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? actionPadding,
    required BuildContext context,
    required List<Widget> children,
    bool showAction = true,
    bool showDragHandle = false,
    bool fullWidth = false,
    CrossAxisAlignment? crossAxisAlignment,
  }) {
    return showSimpleSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: [
          if (showAction)
            Padding(
              padding: actionPadding ?? EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: context.pop,
                    child: Image.asset(
                      Assets.images.closeIcon.path,
                      color: colorWhite,
                      width: 25,
                      height: 15,
                    ),
                  ),
                  title ?? const SizedBox(),
                  action ?? const SizedBox(),
                ],
              ),
            ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  static Future<T?> showSimpleSheet<T>({
    required BuildContext context,
    required Widget child,
    bool? showDragHandle,
    bool isScrollControlled = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      showDragHandle: showDragHandle,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color.fromRGBO(12, 11, 11, 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: child,
        ),
      ),
    );
  }

  static Future<String> shareContentSheet({
    required BuildContext context,
    String? selectedContent,
    String? title,
    required String uuid,
  }) async {
    var value = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ShareContentSheet(
        title: title,
        uuid: uuid,
      ),
    );

    return value ?? '';
  }

  static Future<void> proFeatureSheet({
    required BuildContext context,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorRed,
      builder: (_) => const ProFeatureSheet(),
    );
  }

  static Future<void> proComingSoonSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: colorRed,
      builder: (_) => ProComingSoon(isNewFeature: false),
    );
  }

  static Future<void> newComingSoonSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: colorRed,
      builder: (_) => ProComingSoon(isNewFeature: true),
    );
  }

  static Future<PlaceData?> placeSheet(
    BuildContext context, {
    // bool showSelector = true,
    num? lat,
    num? long,
  }) async {
    var r = await showModalBottomSheet<List>(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      constraints: BoxConstraints(
        minHeight: .8.sh,
        maxHeight: .8.sh,
      ),
      builder: (_) => PlaceSelectSheet(
        latLong: lat == null ? null : LatLng(lat.toDouble(), long!.toDouble()),
      ),
    );

    if (r == null) return null;

    var latLng = r[0] as LatLng;
    var placemarks = r[1] as List<Placemark>;

    return PlaceData(latLng: latLng, placemark: placemarks.first);

    // if (!showSelector) {
    //   return PlaceData(latLng: latLng, placemark: placemarks.first);
    // }

    // if (!context.mounted) return null;

    // var p = await showModalBottomSheet<Placemark>(
    //   context: context,
    //   isScrollControlled: true,
    //   builder: (context) => SelectLocationSheet(placemarks: placemarks),
    // );

    // if (p == null || !context.mounted) return null;

    // return PlaceData(latLng: latLng, placemark: p);
  }
}

class ProComingSoon extends StatelessWidget {
  const ProComingSoon({super.key, required this.isNewFeature});

  final bool isNewFeature;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 18),
          child: GestureDetector(
            onTap: context.pop,
            child: Image.asset(
              Assets.images.closeIcon.path,
              color: colorWhite,
              width: 25,
              height: 15,
            ),
          ),
        ),
        SizedBox(
          height: 140,
          child: Center(
            child: TextViewWidget(
              text: '${isNewFeature ? 'New' : 'Pro'} feature coming soon',
              textSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}
