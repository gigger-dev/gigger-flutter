import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart' hide RadioListTile;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/service_filter_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/place_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/custom_switch_list_tile.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/text_from_label_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/when_widget.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class EventFilterWidget extends ConsumerStatefulWidget {
  const EventFilterWidget({super.key});

  @override
  ConsumerState<EventFilterWidget> createState() => _EventFilterWidgetState();
}

class _EventFilterWidgetState extends ConsumerState<EventFilterWidget> {
  final formKey = GlobalKey<FormState>();
  final keyword = TextEditingController();

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
              image: AssetImage(Assets.images.eventBg.path),
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
        Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SizedBox(height: .12.sh),
              const TextViewWidget(
                text: 'EVENTS\nHAPPENING\nS& CONCERTS',
                textSize: 30,
                height: 1,
              ),
              const SizedBox(height: 10),
              const TextViewWidget(
                text:
                    'Search or create your favourite Events\nor scroll down for some suggestions ^^',
                textSize: 12,
              ),
              SizedBox(height: .05.sh),
              TextFormLabelWidget(
                label: 'Keywords',
                controller: keyword,
                hintText: 'eg. Equithar',
              ),
              const SizedBox(height: 20),
              const TextFormLabelWidget(
                label: 'Genre',
                hintText: 'eg. Rock, Rap',
              ),
              const SizedBox(height: 20),
              const WhenWidget(),
              const SizedBox(height: 20),
              const PlaceWidget(),
              const SizedBox(height: 20),
              const RadiusSelectorWidget(),
              const SizedBox(height: 10),
              const CustomSwitchListTile(
                value: true,
                title: 'Also available remotely',
              ),
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

    EventResultRoute(keyword: keyword.text.trim()).push(context);
  }
}
