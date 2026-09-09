import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/core/providers/token_controller.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/login_widgets/login_bg_image.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class UserSwitchingWidget extends ConsumerStatefulWidget {
  const UserSwitchingWidget(this.uuid, {super.key});

  final String uuid;

  @override
  ConsumerState<UserSwitchingWidget> createState() =>
      _UserSwitchingWidgetState();
}

class _UserSwitchingWidgetState extends ConsumerState<UserSwitchingWidget> {
  ProfileOut? user;

  @override
  void initState() {
    super.initState();
    switchUser();
  }

  Future<void> switchUser() async {
    var data = await ref.read(secureStorageProvider).read(key: widget.uuid);
    if (data == null) return;

    user = ProfileOut.fromJson(jsonDecode(data));
    setState(() {});

    if (user == null) return;

    await ref.read(tokenControllerProvider.notifier).switchUser(user!.uuid);

    await ref
        .read(authControllerProvider.notifier)
        .refreshToken(isSwitchUser: true, resetState: true);
  }

  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).valueOrNull?.cdnUrl;

    return LoginBgImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: user == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: CachedNetworkImageProvider(
                            '$cdnUrl/${user!.avatarMedia}',
                          ),
                        ),
                        SizedBox(height: 8),
                        TextViewWidget(text: user!.account.username),
                        SizedBox(height: 40),
                        Transform.scale(
                          scale: .6,
                          child: CircularProgressIndicator(),
                        ),
                        TextViewWidget(text: 'Switching'),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
