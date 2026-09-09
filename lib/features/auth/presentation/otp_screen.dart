import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/auth/presentation/register_screen.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/auth_bg.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/img_crd_text.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/otp_widgets/pin_box.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/sign_in_label_btn.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/loading_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class OTPScreen extends ConsumerStatefulWidget {
  const OTPScreen({super.key});

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  final _formKey = GlobalKey<FormState>();

  final otp = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      otp.text = '133733';
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(authControllerProvider).whenData((v) => v).value;

    return AuthBg(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Image.asset(
              Assets.images.giRedGigger.path,
              width: 70.w,
            ),
            Expanded(
              child: Stack(
                children: [
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      children: [
                        SizedBox(height: 60.h),
                        OTPTitle(),
                        SizedBox(height: 60.h),
                        PinBox(
                          otp: otp,
                          errorOb: state?.errorOb ?? getErrorText('otp', state),
                        ),
                        SizedBox(height: .3.sh),
                        LoadingButton(
                          title: 'Confirm this code',
                          key: ValueKey('confirm_btn'),
                          isLoading: state?.isLoading ?? false,
                          onPressed: () => onConfirm(state),
                        ),
                        SizedBox(height: 20.h),
                        SignInLabelBtn(),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(child: ImgCrdText()),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onConfirm(AuthState? state) async {
    try {
      if (!_formKey.currentState!.validate()) return;
      _formKey.currentState!.save();

      isLoading(true);

      await ref
          .read(authControllerProvider.notifier)
          .verifyOTP(otp.text.trim());

      if (!mounted) return;
      isLoading(false);
    } catch (e) {
      isLoading(false);
    }
  }

  void isLoading(bool value) {
    ref.read(authControllerProvider.notifier).isLoading(value);
  }
}

class OTPTitle extends StatelessWidget {
  const OTPTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: TextViewWidget(
            text: 'INSERT OTP',
            textSize: 31.sp,
            height: 1,
            color: colorWhite,
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          alignment: Alignment.centerLeft,
          child: TextViewWidget(
            text: 'Check your email, we sent you an OTP password',
            textSize: 13.sp,
            color: colorWhite,
          ),
        ),
      ],
    );
  }
}
