import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/date_extension.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';

import 'table_component.dart';

class DateTimePicker extends StatefulWidget {
  final bool isMultiple;

  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? initialSelectedDate;

  final DateTime? firstDay;

  const DateTimePicker({
    super.key,
    this.firstDay,
    required this.isMultiple,
    required this.initialSelectedDate,
    required this.startTime,
    required this.endTime,
  });

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  List<DateTime> selected = [];

  DateTime? startTime;
  DateTime? endTime;

  @override
  void initState() {
    super.initState();

    if (widget.initialSelectedDate != null) {
      selected.add(getDMY(widget.initialSelectedDate!));
    }

    startTime = widget.startTime;
    endTime = widget.endTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          color: Colors.white,
          icon: const Icon(Icons.close),
        ),
        title: const Text(
          'Pick Date and Time',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        actions: [
          PopupMenuButton(
            color: colorRed,
            iconColor: Colors.white,
            icon: const Icon(Icons.more_horiz),
            position: PopupMenuPosition.under,
            itemBuilder: (context) => [],
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: TableComponent(
              selected: selected,
              firstDay: widget.firstDay,
              focusedDay: widget.isMultiple
                  ? selected.lastOrNull
                  : selected.firstOrNull,
              onDayTap: (value) {
                if (!widget.isMultiple) {
                  selected = [value];
                  setState(() {});
                  return;
                }

                if (selected.contains(value)) {
                  selected.remove(value);
                } else {
                  selected.add(value);
                }

                setState(() {});
              },
            ),
          ),
          // Expanded(
          //   flex: 2,
          //   child: DateRangePickerDialog(
          //     initialEntryMode: DatePickerEntryMode.calendarOnly,
          //     firstDate: DateTime(DateTime.now().year - 100),
          //     lastDate: DateTime(DateTime.now().year + 100),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextViewWidget(
                    text: 'PICK\nTHE TIME',
                    textSize: 28,
                    height: 1,
                  ),
                  const SizedBox(height: 20),
                  _TimeRow(
                    value: startTime,
                    label: 'Start Time',
                    hintText: widget.isMultiple
                        ? null
                        : '${DateFormat('dd/MM/yyyy ').tryFormat(selected.firstOrNull) ?? ''} : Select time',
                    onChanged: (value) {
                      if (widget.isMultiple) {
                        startTime = value;
                        setState(() {});
                      } else {
                        if (selected.isEmpty) return;

                        var date = selected.first;

                        startTime = value.copyWith(
                          year: date.year,
                          month: date.month,
                          day: date.day,
                        );
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  _TimeRow(
                    value: endTime,
                    label: 'End Time',
                    hintText: widget.isMultiple
                        ? null
                        : '${DateFormat('dd/MM/yyyy ').tryFormat(selected.firstOrNull) ?? ''} : Select time',
                    onChanged: (value) {
                      DateTime date;

                      if (widget.isMultiple) {
                        date = value;
                      } else {
                        if (selected.isEmpty) return;

                        var _date = selected.first;

                        date = value.copyWith(
                          year: _date.year,
                          month: _date.month,
                          day: _date.day,
                        );
                      }

                      if (startTime?.compareTo(date) != -1) {
                        Toast.error('End time must be after start time');
                        return;
                      }

                      endTime = date;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const TextViewWidget(text: 'Cancel'),
                ),
                GradientFilledButton(
                  title: 'Done',
                  onPressed: onDone,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  void onDone() {
    if (startTime == null || endTime == null) {
      Toast.error('Please select start and end time');
      return;
    }

    context.pop([selected, startTime, endTime]);
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow({
    required this.label,
    required this.onChanged,
    required this.value,
    this.hintText,
  });

  final String label;
  final String? hintText;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextViewWidget(text: label, textSize: 14),
        SizedBox(
          width: 180,
          child: TextFormField(
            readOnly: true,
            onTap: () async {
              TimeOfDay? day = await showModalBottomSheet(
                context: context,
                isDismissible: true,
                useRootNavigator: true,
                isScrollControlled: true,
                backgroundColor: colorTransparent,
                constraints: BoxConstraints(maxHeight: .65.sh),
                builder: (context) => TimePickerTheme(
                  data: TimePickerThemeData(
                    backgroundColor: colorBlack,
                    dayPeriodColor: Colors.grey.shade900,
                    hourMinuteColor: Colors.grey.shade900,
                    dialBackgroundColor: Colors.grey.shade900,
                  ),
                  child: MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: false),
                    child: TimePickerDialog(
                      initialTime: value != null
                          ? TimeOfDay.fromDateTime(value!)
                          : TimeOfDay.now(),
                    ),
                  ),
                ),
              );

              if (day == null) return;

              if (!context.mounted) return;

              var date = DateFormat('hh:mm a').parse(day.format(context));

              onChanged(date);
            },
            controller: TextEditingController(
              text: DateFormat('dd/MM/yyyy hh:mm a').tryFormat(value),
            ),
            style: const TextStyle(color: colorWhite, fontSize: 12),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              hintText: hintText ?? 'Select',
              hintStyle: const TextStyle(color: colorTextGrey, fontSize: 12),
              fillColor: Colors.grey.shade900,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
