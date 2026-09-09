import 'package:flutter/material.dart' hide RadioListTile;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/place_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/custom_switch_list_tile.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/text_from_label_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/when_widget.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ServiceFilterWidget extends StatelessWidget {
  const ServiceFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: .8.sh,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              image: AssetImage(Assets.images.serviceBg.path),
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
              stops: const [.2, .6],
            ),
          ),
        ),
        ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(height: .12.sh),
            const TextViewWidget(
              text: 'PRO\nSERVICES',
              textSize: 30,
              height: 1,
            ),
            const SizedBox(height: 10),
            const TextViewWidget(
              text:
                  'What do you need?\nSelect a cathegory, search below, or\nscroll down for some suggestions ^^ ',
              textSize: 12,
            ),
            SizedBox(height: .04.sh),
            const TextViewWidget(text: 'Fullfill the fields you need'),
            const SizedBox(height: 20),
            TextFormLabelWidget(
              label: 'Keywords',
              hintText: 'eg. Song Review',
              onTap: () => SheetUtils.newComingSoonSheet(context),
            ),
            const SizedBox(height: 20),
            CustomSwitchListTile(
              value: true,
              title: 'Avaiable!',
              onChanged: (_) => SheetUtils.newComingSoonSheet(context),
            ),
            const SizedBox(height: 20),
            const WhenWidget(
              hintText: 'Pick availability date and time or show all',
            ),
            const SizedBox(height: 20),
            const PlaceWidget(),
            const SizedBox(height: 20),
            const RadiusSelectorWidget(),
            const SizedBox(height: 20),
            CustomSwitchListTile(
              value: true,
              title: 'Also available remotely',
              onChanged: (_) => SheetUtils.newComingSoonSheet(context),
            ),
            const SizedBox(height: 40),
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

class RadiusSelectorWidget extends StatelessWidget {
  const RadiusSelectorWidget({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return SelectorWidget(
      width: width,
      label: 'Radius',
      value: '25 km',
      items: const ['10 km', '25 km', '50 km'],
      onChanged: (_) => SheetUtils.newComingSoonSheet(context),
    );
  }
}

class SelectorWidget<T> extends StatelessWidget {
  const SelectorWidget({
    super.key,
    this.label,
    required this.items,
    this.value,
    this.textsize = 12,
    this.spacing = 10,
    this.onChanged,
    this.width,
    this.isUnder = false,
  });

  final bool isUnder;
  final double? width;
  final String? label;
  final T? value;
  final List<T> items;
  final double textsize;
  final double spacing;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    var labelWidget =
        label == null ? null : TextViewWidget(text: label!, textSize: 12);
    var wrapWidget = Wrap(
      spacing: spacing,
      runSpacing: 10,
      children: items.map((e) {
        var isSelected = e == value;

        return ElevatedButton(
          onPressed: () => onChanged?.call(e),
          style: ButtonStyle(
            minimumSize: const WidgetStatePropertyAll(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            ),
            backgroundColor: WidgetStatePropertyAll(
              isSelected ? colorRed : Colors.black38,
            ),
            side: WidgetStateBorderSide.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return const BorderSide(color: colorWhite);
              }
              return null;
            }),
          ),
          child: TextViewWidget(text: '$e', textSize: textsize),
        );
      }).toList(),
    );

    if (!isUnder) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelWidget != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: labelWidget,
              ),
            ),
          SizedBox(width: width ?? 240, child: wrapWidget),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelWidget != null) labelWidget,
        const SizedBox(height: 10),
        wrapWidget,
      ],
    );
  }
}
