import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class BirthdaySheet extends StatefulWidget {
  const BirthdaySheet({super.key, this.selectedDate});

  final DateTime? selectedDate;

  @override
  State<BirthdaySheet> createState() => _BirthdaySheetState();
}

class _BirthdaySheetState extends State<BirthdaySheet> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate ?? DateTime(DateTime.now().year - 20);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            colorTextBlack.withOpacity(.9),
            colorTextBlack500.withOpacity(.9),
          ],
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Image.asset(
                Assets.images.closeIcon.path,
                color: colorWhite,
                width: 25,
                height: 15,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: const TextViewWidget(
                text: 'WHEN IS \nYOUR\nBIRTHDAY?',
                fontWeight: FontWeight.bold,

                // style: TextStyle(
                //   fontSize: 17,
                //   fontWeight: FontWeight.bold,
                //   color: colorWhite,
                // ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: const Text(
                "It won't be shown publicly",
                style: TextStyle(fontSize: 12, color: colorWhite),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DatePickerWidget(
                onChange: (newDate, _) {
                  selectedDate = newDate;
                  setState(() {});
                },
                looping: false,
                initialDate: selectedDate,
                dateFormat: 'MMMM/dd/yyyy',
                pickerTheme: const DateTimePickerTheme(
                  backgroundColor: Colors.transparent,
                  itemHeight: 40,
                  itemTextStyle: TextStyle(color: Colors.white, fontSize: 19),
                  dividerColor: colorRedGradient,
                ),
              ),
            ),
            GradientFilledButton(
              title: 'Happy Birthday!',
              onPressed: onSave,
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  void onSave() {
    context.pop(selectedDate);
  }
}
