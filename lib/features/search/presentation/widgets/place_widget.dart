import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/text_from_label_widget.dart';

class PlaceWidget extends StatelessWidget {
  const PlaceWidget({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return TextFormLabelWidget(
      width: width,
      label: 'Place',
      textsize: 11,
      hintText: 'Type or let it blank to see the nearest',
      onTap: () => SheetUtils.newComingSoonSheet(context),
    );
  }
}
