import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/service_filter_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/place_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/text_from_label_widget.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class AllFilterWidget extends StatefulWidget {
  const AllFilterWidget({super.key});

  @override
  State<AllFilterWidget> createState() => _AllFilterWidgetState();
}

class _AllFilterWidgetState extends State<AllFilterWidget> {
  final keyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: .5.sh,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              image: AssetImage(Assets.images.giAlenaDarmel1.path),
            ),
          ),
          foregroundDecoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorTransparent,
                Color.fromRGBO(0, 0, 0, 0.93),
                colorBlack,
              ],
              stops: [.7, .9, 1],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, .14.sh, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextViewWidget(
                text: 'DISCOVER\nGIGGER\'S WORLD',
                textSize: 30,
                height: 1,
              ),
              const SizedBox(height: 10),
              const TextViewWidget(
                text:
                    'What do you need?\nSearch or select a filter above to refine your results',
                textSize: 12,
              ),
              SizedBox(height: .1.sh),
              TextFormLabelWidget(
                label: 'Keywords',
                controller: keyword,
                hintText: 'eg. Musician manager',
              ),
              const SizedBox(height: 20),
              const PlaceWidget(),
              const SizedBox(height: 20),
              const RadiusSelectorWidget(),
              const Spacer(),
              GradientFilledButton(title: 'Search', onPressed: onSearch),
            ],
          ),
        ),
      ],
    );
  }

  void onSearch() {
    context.clearFocus();

    AllResultRoute(keyword: keyword.text.trim()).push(context);
  }
}
