import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
// ignore: implementation_imports
import 'package:cupertino_calendar_picker/src/src.dart';
import 'package:flutter/material.dart' hide RadioListTile;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/custom_switch_list_tile.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/interest_hashtag_box.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/role_hashtag_box.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/service_filter_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/place_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/text_from_label_widget.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/when_widget.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/core/extension/date_extension.dart';

class ArtistFilterWidget extends StatefulWidget {
  const ArtistFilterWidget({super.key});

  @override
  State<ArtistFilterWidget> createState() => _ArtistFilterWidgetState();
}

class _ArtistFilterWidgetState extends State<ArtistFilterWidget> {
  final formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final genre = TextEditingController();
  final role = TextEditingController();
  final instrument = TextEditingController();

  bool isPro = false;
  bool isAvailable = false;

  DateTime? startDate;
  DateTime? endDate;

  @override
  void dispose() {
    name.dispose();
    genre.dispose();
    role.dispose();
    instrument.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: .44.sh,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              image: AssetImage(Assets.images.giMaskGroup3.path),
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
              stops: const [.4, 1],
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
                text: 'ARTISTS\n& BANDS',
                textSize: 30,
                height: 1,
              ),
              const SizedBox(height: 10),
              const TextViewWidget(
                text: 'Find people and creators to connect with',
              ),
              SizedBox(height: .1.sh),
              const SelectorWidget(
                label: 'Who',
                value: 'User',
                items: ['User', 'Band'],
              ),
              const SizedBox(height: 20),
              TextFormLabelWidget(
                label: 'Name',
                controller: name,
                hintText: 'eg. Equithar',
              ),
              const SizedBox(height: 20),
              InterestHashtagBox(
                title: 'Genre',
                controller: genre,
                hintText: 'eg. Rock, Rap',
              ),
              const SizedBox(height: 20),
              RoleHashtagBox(
                title: 'Role',
                controller: role,
                hintText: 'eg. singer',
              ),
              const SizedBox(height: 20),
              TextFormLabelWidget(
                label: 'Instruments',
                controller: instrument,
                hintText: 'eg. guitar, sinth, sitar, drums',
              ),
              const SizedBox(height: 20),
              CustomSwitchListTile(
                value: isPro,
                title: 'PRO user only',
                onChanged: (_) => SheetUtils.proComingSoonSheet(context),
              ),
              CustomSwitchListTile(
                value: isAvailable,
                title: 'Available!',
                onChanged: (value) {
                  isAvailable = value;

                  if (!value) {
                    startDate = null;
                    endDate = null;
                  }

                  setState(() {});
                },
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => SizeTransition(
                  sizeFactor: animation,
                  child: FadeTransition(opacity: animation, child: child),
                ),
                child: !isAvailable
                    ? SizedBox(key: Key('availability_date_range_hide'))
                    : Column(
                        key: Key('availability_date_range'),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextViewWidget(
                                text: 'Start Date',
                                textSize: 12,
                              ),
                              DatePickerBtn(
                                maximum: endDate,
                                initial: startDate,
                                onDateTimeChanged: (value) {
                                  if (value == null) return;

                                  startDate = value.clean;
                                  endDate ??= value.clean;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextViewWidget(
                                text: 'End Date',
                                textSize: 12,
                              ),
                              DatePickerBtn(
                                initial: endDate,
                                minimum: startDate,
                                onDateTimeChanged: (value) {
                                  if (value == null) return;

                                  endDate = value.clean;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 20),
              const WhenWidget(),
              const SizedBox(height: 20),
              const PlaceWidget(),
              const SizedBox(height: 20),
              const RadiusSelectorWidget(),
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

    GiggerResultRoute(
      isPro: isPro,
      endDate: endDate,
      startDate: startDate,
      name: trim(name.text.trim()),
      instrument: trim(instrument.text.trim()),
      role: trim(role.text.trim().replaceFirst('#', '')),
      genre: trim(genre.text.trim().replaceFirst('#', '')),
    ).push(context);
  }

  String? trim(String text) {
    if (text.isEmpty) return null;
    return text;
  }
}

class DatePickerBtn extends StatelessWidget {
  const DatePickerBtn({
    super.key,
    this.minimum,
    this.maximum,
    this.initial,
    this.onDateTimeChanged,
  });

  final DateTime? minimum;
  final DateTime? maximum;
  final DateTime? initial;
  final ValueChanged<DateTime?>? onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoCalendarPickerButton(
      minuteInterval: 5,
      mainColor: colorRed,
      onCompleted: onDateTimeChanged,
      mode: CupertinoCalendarMode.dateTime,
      buttonDecoration: PickerButtonDecoration(
        textStyle: TextStyle(fontSize: 12.sp),
        backgroundColor: Colors.grey.shade900,
      ),
      monthPickerDecoration: CalendarMonthPickerDecoration(
        defaultDayStyle: CalendarMonthPickerDefaultDayStyle(
          textStyle: TextStyle(fontSize: 14),
        ),
        currentDayStyle: CalendarMonthPickerCurrentDayStyle(
          textStyle: TextStyle(fontSize: 14),
        ),
        disabledDayStyle: CalendarMonthPickerDisabledDayStyle(
          textStyle: TextStyle(fontSize: 14, color: colorGrey),
        ),
        selectedDayStyle: CalendarMonthPickerSelectedDayStyle(
          textStyle: TextStyle(fontSize: 14),
          backgroundCircleColor: colorRed,
          mainColor: colorRed,
        ),
        selectedCurrentDayStyle: CalendarMonthPickerSelectedCurrentDayStyle(
          textStyle: TextStyle(fontSize: 18),
          backgroundCircleColor: colorRed,
          mainColor: colorRed,
        ),
      ),
      minimumDateTime: minimum ?? DateTime(DateTime.now().year),
      maximumDateTime: maximum ?? DateTime(DateTime.now().year + 1),
      initialDateTime: initial ?? DateTime.now().copyWith(minute: 0),
    );
  }
}
