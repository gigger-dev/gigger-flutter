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

class CampaignFilterWidget extends StatelessWidget {
  const CampaignFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.scale(
          scale: 1.1,
          alignment: Alignment.topLeft,
          child: Container(
            height: 8.sh,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.topRight,
                image: AssetImage(Assets.images.campaignBg.path),
              ),
            ),
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colorBlack.withOpacity(.4),
                  colorBlack.withOpacity(.85),
                  colorBlack,
                ],
                stops: const [0, .4, .6],
              ),
            ),
          ),
        ),
        ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(height: .12.sh),
            const TextViewWidget(
              text: 'CAMPAIGNS',
              textSize: 30,
              height: 1,
            ),
            const SizedBox(height: 10),
            const TextViewWidget(
              text: 'Search available Campaigns to support',
              textSize: 12,
            ),
            SizedBox(height: .1.sh),
            TextFormLabelWidget(
              width: 200,
              label: 'Keywords',
              hintText: 'Eg “tour support“etc …',
              onTap: () => SheetUtils.newComingSoonSheet(context),
            ),
            const SizedBox(height: 20),
            CustomSwitchListTile(
              value: true,
              title: 'PRO user only',
              onChanged: (_) => SheetUtils.newComingSoonSheet(context),
            ),
            const SizedBox(height: 20),
            TextFormLabelWidget(
              width: 200,
              label: 'Duration range',
              hintText: 'Pick date and time or show all …',
              onTap: () => SheetUtils.newComingSoonSheet(context),
            ),
            const SizedBox(height: 20),
            TextFormLabelWidget(
              width: 200,
              label: 'Price range',
              hintText: 'Select a range or show all …',
              onTap: () => SheetUtils.newComingSoonSheet(context),
            ),
            const SizedBox(height: 20),
            CustomSwitchListTile(
              value: true,
              title: 'Include location (if any)',
              onChanged: (_) => SheetUtils.newComingSoonSheet(context),
            ),
            const SizedBox(height: 20),
            const PlaceWidget(),
            const SizedBox(height: 20),
            const RadiusSelectorWidget(),
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
