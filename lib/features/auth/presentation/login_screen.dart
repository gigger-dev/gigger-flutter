import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/switch_user_controller.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/login_widgets/login_bg_image.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/login_widgets/login_btn.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/login_widgets/password_widget.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/login_widgets/select_account_widget.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/login_widgets/sign_up_btn.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/login_widgets/user_switching_widget.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/login_widgets/username_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profiles_controller.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/sign_in.dart';

import '../../../../../core/consts/color.dart';
import '../../../../../widgets/text_view_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({
    super.key,
    this.showProfiles = true,
  });

  final bool showProfiles;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final username = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      username.text = 'thitlwincoder@gmail.com';
      password.text = 'Tlwin@111';
    }
    Future.delayed(Duration.zero, () {
      ref.read(authControllerProvider.notifier).reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(authControllerProvider).valueOrNull;
    var switchUserUuid = ref.watch(switchUserControllerProvider).valueOrNull;
    var profiles = ref.watch(profilesControllerProvider).valueOrNull ?? [];

    if (switchUserUuid != null) {
      return UserSwitchingWidget(switchUserUuid);
    }

    if (profiles.isNotEmpty && widget.showProfiles) {
      return SelectAccountWidget(profiles);
    }

    return LoginBgImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    context.canPop()
                        ? IconButton(
                            style: IconButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: Icon(CupertinoIcons.back, color: colorWhite),
                            onPressed: context.pop,
                          )
                        : Image.asset(
                            Assets.images.giGiggerLogoWhiteSmall.path,
                            width: 58.w,
                          ),
                    Image.asset(
                      Assets.images.menu.path,
                      width: 30.w,
                      height: 16.h,
                      fit: BoxFit.cover,
                      color: colorWhite,
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          SizedBox(height: .14.sh),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 22.w),
                            child: TextViewWidget(
                              text: 'LOGIN',
                              color: colorWhite,
                              textSize: 28.sp,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 70.h),
                          UserNameWidget(
                            controller: username,
                            onChanged: () {
                              if (state?.errorOb != null) {
                                ref
                                    .read(authControllerProvider.notifier)
                                    .clearErrorOb();
                              }
                            },
                          ),
                          SizedBox(height: 30.h),
                          PasswordWidget(
                            controller: password,
                            onChanged: () {
                              if (state?.errorOb != null) {
                                ref
                                    .read(authControllerProvider.notifier)
                                    .clearErrorOb();
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: CupertinoButton(
                                minSize: 0,
                                padding: EdgeInsets.zero,
                                onPressed: () => ForgotRoute().push(context),
                                child: TextViewWidget(
                                  text: 'Forgot your password?',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 38.h),
                          LoginBtn(
                            onTap: login,
                            key: ValueKey('login_btn'),
                            isLoading: state?.isLoading ?? false,
                          ),
                          SizedBox(height: 28.h),
                          const SignUpBtn(),
                          SizedBox(height: 120.h),
                          TextViewWidget(
                            text: 'Awesome image by Jakala Toney: Thank you!',
                            color: colorWhite.withOpacity(0.5),
                            textSize: 9.sp,
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    try {
      if (!_formKey.currentState!.validate()) return;

      context.clearFocus();

      isLoading(true);

      await ref.read(authControllerProvider.notifier).login(
            SignIn(
              email: username.text.trim(),
              password: password.text.trim(),
            ),
          );

      isLoading(false);
    } catch (e) {
      isLoading(false);
    }
  }

  void isLoading(bool value) {
    if (!mounted) return;
    ref.read(authControllerProvider.notifier).isLoading(value);
  }
}
