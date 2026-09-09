import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SelectTimeSheet extends StatefulWidget {
  const SelectTimeSheet({
    super.key,
    required this.selectedTime,
    required this.minimumDate,
    required this.maximumDate,
  });

  final DateTime selectedTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  @override
  State<SelectTimeSheet> createState() => _SelectTimeSheetState();
}

class _SelectTimeSheetState extends State<SelectTimeSheet> {
  DateTime? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.selectedTime;
  }

  @override
  void didUpdateWidget(covariant SelectTimeSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedTime != widget.selectedTime) {
      selectedTime = widget.selectedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: colorBlack),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextViewWidget(
            text: 'Select time',
            textSize: 16.sp,
          ),
          SizedBox(height: 10),
          SizedBox(
            height: .3.sh,
            child: CupertinoDatePicker(
              minuteInterval: 5,
              minimumDate: widget.minimumDate,
              maximumDate: widget.maximumDate,
              initialDateTime: selectedTime,
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (value) {
                selectedTime = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(height: 10),
          GradientFilledButton(
            title: 'Select',
            onPressed: () => context.pop(selectedTime),
          )
        ],
      ),
    );
  }
}
