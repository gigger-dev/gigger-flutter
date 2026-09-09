import 'package:flutter/material.dart' hide RadioListTile;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/service_filter_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/place_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/custom_switch_list_tile.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/text_from_label_widget.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class MembershipFilterWidget extends StatelessWidget {
  const MembershipFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: .5.sh,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              image: AssetImage(Assets.images.membershipBg.path),
            ),
          ),
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorBlack.withOpacity(.4),
                colorBlack,
              ],
              stops: const [.2, 8],
            ),
          ),
        ),
        ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(height: .12.sh),
            const TextViewWidget(
              text: 'MEMBERSHIPS',
              textSize: 30,
              height: 1,
            ),
            const SizedBox(height: 10),
            const TextViewWidget(
              text: 'Search available Memberships',
              textSize: 12,
            ),
            SizedBox(height: .1.sh),
            TextFormLabelWidget(
              width: 220,
              label: 'Keywords',
              hintText: 'Eg "chat with" ...',
              onTap: () => SheetUtils.newComingSoonSheet(context),
            ),
            const SizedBox(height: 20),
            CustomSwitchListTile(
              value: true,
              title: 'PRO user only',
              onChanged: (_) => SheetUtils.newComingSoonSheet(context),
            ),
            const SizedBox(height: 20),
            SelectorWidget(
              spacing: 2,
              textsize: 11,
              isUnder: true,
              value: 'one year',
              label: 'Duration (choose one)',
              onChanged: (_) => SheetUtils.newComingSoonSheet(context),
              items: [
                'Single use',
                'one week',
                'one month',
                'one year',
              ],
            ),
            const SizedBox(height: 20),
            TextFormLabelWidget(
              width: 220,
              textsize: 11,
              label: 'Price range',
              hintText: 'Select a range ...',
              onTap: () => SheetUtils.newComingSoonSheet(context),
            ),
            const SizedBox(height: 20),
            CustomSwitchListTile(
              value: true,
              title: 'Include location (if any)',
              onChanged: (_) => SheetUtils.newComingSoonSheet(context),
            ),
            const SizedBox(height: 20),
            const PlaceWidget(width: 220),
            const SizedBox(height: 20),
            const RadiusSelectorWidget(width: 220),
            SizedBox(height: .04.sh),
          ],
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 20,
          child: GradientFilledButton(
            title: 'Search',
            // onPressed: () => context.pop(true),
          ),
        ),
      ],
    );
  }
}
