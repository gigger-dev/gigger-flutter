import 'package:flutter/cupertino.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/text_from_label_widget.dart';

class WhenWidget extends StatelessWidget {
  const WhenWidget({super.key, this.hintText, this.width});

  final double? width;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormLabelWidget(
      width: width,
      textsize: 11,
      label: 'When?',
      hintText: hintText ?? 'Pick availability date and time',
      onTap: () => SheetUtils.newComingSoonSheet(context),
    );
  }
}
