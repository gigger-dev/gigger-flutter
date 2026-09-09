import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.availabilityStatus,
    required this.isEditMode,
    this.onEdit,
    required this.onTap,
  });

  final bool isEditMode;
  final bool availabilityStatus;
  final VoidCallback? onEdit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEditMode ? onEdit : onTap,
      child: Row(
        children: [
          Container(
            height: 10.h,
            width: 10.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: availabilityStatus ? Colors.green : Colors.red,
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            availabilityStatus ? 'Available!' : 'Unavailable!',
            style: TextStyle(color: colorWhite, fontSize: 13.sp),
          ),
          SizedBox(width: 8.w),
          TextViewWidget(
            text: isEditMode ? 'Edit availability' : 'When?',
            color: colorRed,
            textSize: 13.sp,
          ),
        ],
      ),
    );
  }
}
