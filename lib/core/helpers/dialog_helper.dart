import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

import '../consts/color.dart';

class DialogHelper {
  static Future<bool> showOverlay(
    BuildContext context, {
    bool barrierDismissible = true,
  }) async {
    return await showDialog<bool>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: colorRed,
              ),
              padding: const EdgeInsets.all(6),
              child: Transform.scale(
                scale: .6,
                child: const CircularProgressIndicator(color: colorWhite),
              ),
            ),
          );
        }).then((bool? value) {
      return true;
    });
  }

  static Future<bool> showLoadingDialog(
    BuildContext context, {
    bool barrierDismissible = false,
    Color? color,
    String? message,
  }) async {
    return await showDialog<bool>(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: 68,
              margin: EdgeInsets.symmetric(horizontal: 52.w),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  const CircularProgressIndicator(
                    color: colorGrey,
                    strokeWidth: 3,
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  TextViewWidget(
                    text: message ?? 'Logout.....',
                    textSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    textDecoration: TextDecoration.none,
                    color: Colors.red,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        }).then((bool? value) {
      return true;
    });
  }

  static Future<bool> showErrorDialog(
    BuildContext context, {
    bool barrierDismissible = true,
    Color? color,
    required String message,
  }) async {
    return await showDialog<bool>(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 52.w,
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: TextViewWidget(
                text: message,
                textDecoration: TextDecoration.none,
                textSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          );
        }).then((bool? value) {
      return true;
    });
  }

  static Future<bool> showCreatePostSuccessDialog(
    BuildContext context, {
    bool barrierDismissible = true,
    Color? color,
    required String message,
  }) async {
    return await showDialog<bool>(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 52.w,
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: TextViewWidget(
                text: message,
                textSize: 16.sp,
                fontWeight: FontWeight.w600,
                textDecoration: TextDecoration.none,
                color: Colors.red,
              ),
            ),
          );
        }).then((bool? value) {
      return true;
    });
  }

  static Future<ProfileStatus> changeProfileEditStatus(
    BuildContext context, {
    bool barrierDismissible = true,
    required String message,
  }) async {
    int selectedValue = message == 'Available' ? 1 : 2;
    return await showDialog<ProfileStatus>(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter innerSetState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: TextViewWidget(
                      text: 'Change Status',
                      textSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      textDecoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: 1,
                              groupValue: selectedValue,
                              activeColor: Colors.green,
                              fillColor: WidgetStateProperty.resolveWith(
                                  getAvailableColor),
                              onChanged: (int? value) {
                                innerSetState(() {
                                  selectedValue = 1;
                                });
                              },
                            ),
                            TextViewWidget(
                              text: 'Available',
                              textSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              textDecoration: TextDecoration.none,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: 2,
                              groupValue: selectedValue,
                              activeColor: colorOrangeRed,
                              fillColor: WidgetStateProperty.resolveWith(
                                  getUnavailableColor),
                              onChanged: (int? value) {
                                innerSetState(() {
                                  selectedValue = 2;
                                });
                              },
                            ),
                            TextViewWidget(
                              text: 'Unavailable',
                              textSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              textDecoration: TextDecoration.none,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: colorWhite,
                      gradient: const LinearGradient(
                          begin: Alignment(0, 50),
                          end: Alignment(100, 50),
                          colors: [
                            colorBtnOrangeRed,
                            colorOrangeRed,
                          ],
                          stops: [
                            0,
                            1
                          ]),
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(
                              52, 21, 0, 0.75), // Shadow color (RGBA)
                          offset: Offset(45, 45), // X, Y offset
                          blurRadius: 37.5, // Blur radius
                          spreadRadius: 0.0, // Spread radius
                        ),
                      ],
                    ),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                      onPressed: () {
                        context.pop(ProfileStatus(
                            selectedValue: selectedValue, isBack: true));
                      },
                      child: Text(
                        'Ok',
                        style: TextStyle(
                          color: colorWhite,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        }).then((ProfileStatus? value) {
      return value != null
          ? ProfileStatus(selectedValue: selectedValue, isBack: true)
          : ProfileStatus(
              selectedValue: message == 'Available' ? 1 : 2, isBack: false);
    });
  }

  static Color getUnavailableColor(Set<WidgetState> states) {
    return Colors.redAccent;
  }

  static Color getAvailableColor(Set<WidgetState> states) {
    return Colors.green;
  }

  static hideLoading(BuildContext context) {
    if (context.canPop()) context.pop();
  }
}

class ProfileStatus {
  int selectedValue;
  bool isBack;

  ProfileStatus({required this.selectedValue, this.isBack = false});
}

class VideoStatus {
  int selectedValue;
  bool isBack;

  VideoStatus({required this.selectedValue, this.isBack = false});
}
