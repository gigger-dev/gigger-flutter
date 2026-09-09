import 'package:flutter/material.dart' hide RadioListTile;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/num_format.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/service_filter_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/place_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/custom_switch_list_tile.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/text_from_label_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/when_widget.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

enum CategoryType {
  musicians,
  services,
  gear;

  @override
  String toString() => name[0].toUpperCase() + name.substring(1);

  bool get isMusicians => this == musicians;
  bool get isServices => this == services;
  bool get isGear => this == gear;
}

class GiglistFilterWidget extends StatefulWidget {
  const GiglistFilterWidget({super.key});

  @override
  State<GiglistFilterWidget> createState() => _GiglistFilterWidgetState();
}

class _GiglistFilterWidgetState extends State<GiglistFilterWidget> {
  final formKey = GlobalKey<FormState>();

  CategoryType categoryType = CategoryType.musicians;
  final keyword = TextEditingController();
  final price = TextEditingController();
  bool isLookingFor = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: .5.sh,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              image: AssetImage(Assets.images.giglistBg.path),
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
              stops: const [0, .8],
            ),
          ),
        ),
        Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SizedBox(height: .12.sh),
              const TextViewWidget(text: 'GIGLIST', textSize: 30),
              const SizedBox(height: 10),
              const TextViewWidget(
                text: 'Search announcements and classifieds.',
              ),
              SizedBox(height: .1.sh),
              SelectorWidget(
                label: 'Type',
                items: ['Looking for', 'Offering'],
                value: isLookingFor ? 'Looking for' : 'Offering',
                onChanged: (value) {
                  isLookingFor = value == 'Looking for';
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              SelectorWidget(
                spacing: 8,
                textsize: 11,
                label: 'Category',
                value: categoryType,
                items: CategoryType.values,
                onChanged: (value) {
                  categoryType = value;
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              TextFormLabelWidget(
                label: 'Keywords',
                controller: keyword,
                hintText: categoryType.isMusicians
                    ? 'eg. looking for Drummer'
                    : categoryType.isServices
                        ? 'eg. Music marketing masterclass'
                        : 'eg. akg microphone',
              ),
              if (categoryType.isMusicians) ...[
                const SizedBox(height: 20),
                const SelectorWidget(
                  value: '',
                  label: 'Genre',
                  items: ['Male', 'Female', 'Don’t care'],
                ),
                const SizedBox(height: 20),
                const CustomSwitchListTile(
                  value: false,
                  title: 'PRO user only',
                ),
                const CustomSwitchListTile(
                  value: true,
                  title: 'Available to play!',
                ),
              ],
              if (!categoryType.isGear)
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: WhenWidget(
                    hintText: 'Pick availability date and time or show all',
                  ),
                ),
              if (!categoryType.isMusicians)
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: TextFormLabelWidget(
                    textsize: 11,
                    controller: price,
                    hintText: 'Select range',
                    label: categoryType.isServices ? 'Wage / Cost?' : 'Price',
                  ),
                ),
              const SizedBox(height: 20),
              const PlaceWidget(),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: RadiusSelectorWidget(),
              ),
              if (!categoryType.isGear)
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: CustomSwitchListTile(
                    value: true,
                    title: 'Also available remotely',
                    subtitle: !categoryType.isMusicians
                        ? null
                        : 'Select if available even remotely (eg. video calls)',
                  ),
                ),
              SizedBox(height: .14.sh),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 20,
          child: GradientFilledButton(title: 'Search', onPressed: onSearch),
        ),
      ],
    );
  }

  void onSearch() {
    context.clearFocus();

    if (!formKey.currentState!.validate()) return;

    GiglistResultRoute(
      isLookingFor: isLookingFor,
      title: keyword.text.trim(),
      isPerformer: categoryType.isMusicians,
      price: numFormat(double.tryParse(price.text.trim())),
    ).push(context);
  }
}
