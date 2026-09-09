import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/utils/date_format.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/auth_bg.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/img_crd_text.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/register_widgets/birthday_sheet.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/register_widgets/register_form.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/register_widgets/register_title.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/sign_in_label_btn.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/register_widgets/term_label_text.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/sign_up.dart';
import 'package:mobile_gigger_app/widgets/loading_button.dart';
import 'package:mobile_gigger_app/widgets/show_sheet.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key, this.fromSheet = false});

  final bool fromSheet;

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final birthday = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      username.text = 'thitlwincoder';
      email.text = 'thitlwincoder@gmail.com';
      password.text = 'Tlwin@123';
      confirmPassword.text = 'Tlwin@123';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(authControllerProvider).whenData((v) => v).value;

    return AuthBg(
      child: Scaffold(
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
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Column(
                      children: [
                        SizedBox(height: 70.h),
                        RegisterTitle(widget.fromSheet),
                        SizedBox(height: 50.h),
                        RegisterForm(
                          email: email,
                          username: username,
                          password: password,
                          birthday: birthday,
                          confirmPassword: confirmPassword,
                          errorGetter: (v) => getErrorText(v, state),
                          onBirthdayTap: () => onBirthdayTap(state?.birthday),
                        ),
                        SizedBox(height: 48.h),
                        TermLabelText(),
                        SizedBox(height: 32.h),
                        LoadingButton(
                          title: 'Sign Up!',
                          isLoading: state?.isLoading ?? false,
                          onPressed: onRegister,
                        ),
                        SizedBox(height: 24.h),
                        SignInLabelBtn(),
                        SizedBox(height: .1.sh),
                        ImgCrdText(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onRegister() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    var out = SignUp(
      email: email.text.trim(),
      password: password.text.trim(),
      username: username.text.trim(),
      confirmPassword: confirmPassword.text.trim(),
      dateOfBirth: birdayDateParse(birthday.text.trim()),
    );

    await ref.read(authControllerProvider.notifier).register(out);
  }

  Future<void> onBirthdayTap(DateTime? selectedDateTime) async {
    var date = await showSheet<DateTime>(
      context: context,
      builder: (context) => BirthdaySheet(
        selectedDate: selectedDateTime,
      ),
    );

    if (date == null) return;

    ref.read(authControllerProvider.notifier).birthday(date);
    birthday.text = birdayDateFormat(date);
  }
}

String? getErrorText(String name, AuthState? state) {
  return state?.formErrorOb
      ?.where((e) => e.loc.contains(name))
      .firstOrNull
      ?.msg
      .split(',')
      .last
      .trim();
}
