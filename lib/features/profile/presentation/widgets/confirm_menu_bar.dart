import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';

class ConfirmMenuBar extends StatelessWidget {
  const ConfirmMenuBar({
    super.key,
    required this.onCancel,
    required this.onSave,
    required this.isEditMode,
    required this.isCoverEdit,
  });

  final VoidCallback onCancel;
  final VoidCallback onSave;
  final bool isEditMode;
  final bool isCoverEdit;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: .01.sh,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: !isEditMode && !isCoverEdit
            ? const SizedBox(key: ValueKey('confirm_menu_hide'))
            : Padding(
                key: const ValueKey('confirm_menu_show'),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(110.w, 40),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: colorWhite, width: 1),
                      ),
                      onPressed: onCancel,
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      key: ValueKey('save_btn'),
                      style: FilledButton.styleFrom(
                        minimumSize: Size(110.w, 40),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: onSave,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
