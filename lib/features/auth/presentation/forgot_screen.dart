import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/auth_bg.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/forgot_widgets/email_form_widget.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/forgot_widgets/new_password_widget.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/img_crd_text.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/sign_in_label_btn.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/forgot_password.dart';
import 'package:mobile_gigger_app/widgets/loading.dart';
import 'package:mobile_gigger_app/widgets/loading_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ForgotScreen extends ConsumerStatefulWidget {
  const ForgotScreen(this.initialPage, {super.key});

  final int initialPage;

  @override
  ConsumerState<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends ConsumerState<ForgotScreen> {
  final loading = Loading();

  final _formKey = GlobalKey<FormState>();

  late PageController controller;

  final email = TextEditingController();

  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller = PageController(initialPage: widget.initialPage);
    if (kDebugMode) {
      email.text = 'thitlwincoder@gmail.com';
      password.text = 'Tlwin@111';
      confirmPassword.text = 'Tlwin@111';
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
            SizedBox(height: 70.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  children: [
                    TextViewWidget(
                      text: 'FORGOT PASSWORD',
                      textSize: 31.sp,
                      height: 1,
                    ),
                    SizedBox(height: 50.h),
                    SizedBox(
                      height: .3.sh,
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: PageView(
                          controller: controller,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            EmailFormWidget(email),
                            NewPasswordWidget(
                              password: password,
                              confirmPassword: confirmPassword,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    LoadingButton(
                      title: 'Confirm',
                      isLoading: state?.isLoading ?? false,
                      onPressed: () => onConfirm(state),
                    ),
                    SizedBox(height: 24.h),
                    SignInLabelBtn(),
                  ],
                ),
              ),
            ),
            Center(child: ImgCrdText()),
          ],
        ),
      ),
    );
  }

  Future<void> onConfirm(AuthState? state) async {
    if (!_formKey.currentState!.validate()) return;

    if (controller.page == 0.0) {
      loading.show(context);
      setState(() {});

      await ref
          .read(authControllerProvider.notifier)
          .forgotPasswordRequest(email.text.toLowerCase());

      loading.hide();
      setState(() {});

      return;
    }

    loading.show(context);
    setState(() {});

    var body = ForgotPassword(
      password: password.text.trim(),
      confirmPassword: confirmPassword.text.trim(),
    );

    await ref.read(authControllerProvider.notifier).forgotPassword(body);

    loading.hide();
    setState(() {});
  }
}
