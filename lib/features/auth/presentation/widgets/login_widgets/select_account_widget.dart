import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/core/providers/token_controller.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/switch_user_controller.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/login_widgets/login_bg_image.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profiles_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/widgets/outlined_btn.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SelectAccountWidget extends ConsumerStatefulWidget {
  const SelectAccountWidget(this.profiles, {super.key});

  final List<ProfileOut> profiles;

  @override
  ConsumerState<SelectAccountWidget> createState() =>
      _SelectAccountWidgetState();
}

class _SelectAccountWidgetState extends ConsumerState<SelectAccountWidget> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).valueOrNull?.cdnUrl;

    return LoginBgImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextViewWidget(
                  textSize: 20,
                  text: 'Select Account',
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 40),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: widget.profiles.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      var user = widget.profiles[index];

                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        onTap: () => onTap(user.uuid),
                        leading: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            '$cdnUrl/${user.avatarMedia}',
                          ),
                        ),
                        title: TextViewWidget(text: user.account.username),
                        trailing: ElevatedButton(
                          onPressed: () => onDelete(user.uuid),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            minimumSize: Size.zero,
                            padding: EdgeInsets.all(6),
                            backgroundColor: colorWhite,
                          ),
                          child: Icon(
                            CupertinoIcons.trash,
                            color: colorRed,
                            size: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (widget.profiles.length < 2) ...[
                  SizedBox(height: 40),
                  TextButton(
                    onPressed: () =>
                        LoginRoute(showProfiles: false).go(context),
                    child: Center(
                      child: TextViewWidget(text: 'Log in to another account'),
                    ),
                  ),
                  SizedBox(height: 20),
                  OutlinedBtn(
                    onPressed: () {
                      context.clearFocus();
                      const RegisterRoute().replace(context);
                    },
                    text: 'Create new account',
                  ),
                  SizedBox(height: 20),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onTap(String uuid) async {
    ref.read(switchUserControllerProvider.notifier).set(uuid);
    // await ref.read(tokenControllerProvider.notifier).switchUser(uuid);

    // var tokens =
    //     await ref.read(tokenControllerProvider.notifier).getTokens(uuid);

    // if (tokens.token == null || tokens.refreshToken == null) {
    //   await ref.read(tokenControllerProvider.notifier).removeUuid(uuid);
    //   ref.read(profilesControllerProvider.notifier).refresh();
    //   return;
    // }

    // try {
    //   await ref.read(authControllerProvider.notifier).setToken(
    //         TokenOut(
    //           accessToken: tokens.token!,
    //           refreshToken: tokens.refreshToken!,
    //         ),
    //         isSwitchUser: true,
    //       );
    // } catch (e) {
    //   var r = await ref.read(refreshTokenProvider(tokens.refreshToken!).future);
    //   await ref.read(authControllerProvider.notifier).setToken(
    //         r,
    //         isSwitchUser: true,
    //       );
    // }
  }

  Future<void> onDelete(String uuid) async {
    await ref.read(tokenControllerProvider.notifier).removeUuid(uuid);
    ref.read(profilesControllerProvider.notifier).refresh();
  }
}
