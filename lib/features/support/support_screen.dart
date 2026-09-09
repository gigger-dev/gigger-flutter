import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/get_profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/metadata_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/count_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/widgets/circular_image_widget.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SupportScreen extends ConsumerStatefulWidget {
  const SupportScreen(this.profile, {super.key});

  final ProfileOut profile;

  @override
  ConsumerState<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends ConsumerState<SupportScreen> {
  late ProfileOut profile;

  @override
  void initState() {
    super.initState();
    profile = widget.profile;
  }

  @override
  Widget build(BuildContext context) {
    var cdnurl = ref.read(configProvider).valueOrNull?.cdnUrl;

    var user = ref.watch(profileControllerProvider).value!;

    var metadata = ref
        .watch(metadataControllerProvider(profile.uuid))
        .whenData((v) => v)
        .valueOrNull;

    return Scaffold(
      backgroundColor: colorBlack,
      body: Stack(
        children: [
          Container(
            height: .8.sh,
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: .8,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                image: CachedNetworkImageProvider(
                  '$cdnurl/${profile.coverMedia}',
                ),
              ),
            ),
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colorBlack,
                  colorBlack.withOpacity(.6),
                  colorBlack,
                ],
                stops: const [.1, .3, .7],
              ),
            ),
          ),
          AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: colorWhite),
            title: const TextViewWidget(
              text: 'Support this user',
              textSize: 14,
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: .1.sh),
                      const TextViewWidget(
                        text: 'YOU ARE\nSUPPORTING',
                        textSize: 28,
                        height: 1,
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularImageWidget(
                            imageUrl: '$cdnurl/${profile.avatarMedia}',
                            radius: 36,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextViewWidget(text: profile.account.username),
                                TextViewWidget(
                                  text: profile.skills
                                      .map((e) => e.name)
                                      .join(', '),
                                  textSize: 12,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 2),
                                      child: Icon(
                                        Icons.location_on,
                                        color: colorWhite,
                                        size: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: TextViewWidget(
                                        text: locationFormat2(profile.location),
                                        textSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (user.uuid != profile.uuid)
                            FollowBtn(
                              minSize: 0,
                              onFollowTap: onFollowTap,
                              onUnFollowTap: onUnFollowTap,
                              isPrivateProfile: profile.isPrivateProfile,
                              isAlreadyFollowing: metadata?.relationshipMetaData
                                      ?.isAlreadyFollowing ??
                                  false,
                              isAlreadyRequestedToFollow: metadata
                                      ?.relationshipMetaData
                                      ?.isAlreadyRequestedToFollow ??
                                  false,
                            )
                        ],
                      ),
                      const SizedBox(height: 30),
                      CountWidget(
                        isVisitor: true,
                        uuid: profile.uuid,
                        profileUuid: user.uuid,
                        likeCount: metadata?.likeCount ?? 0,
                        viewCount: metadata?.viewCount ?? 0,
                        followersCount: metadata?.followersCount ?? 0,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorBlack,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: const Column(
                        children: [
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: TextViewWidget(text: 'Payments method'),
                            subtitle: TextViewWidget(
                              text:
                                  'Currently default method: associated creadit card',
                              textSize: 10,
                            ),
                            trailing: Icon(
                              CupertinoIcons.right_chevron,
                              color: colorWhite,
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  _TextForm(hintText: 'Amount ...'),
                                  SizedBox(height: 30),
                                  _TextForm(hintText: 'Add message ...'),
                                  SizedBox(height: 30),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: colorWhite,
                                        size: 20,
                                      ),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: TextViewWidget(
                                          text:
                                              'The total will be charged to the payment method chosen as default',
                                          color: colorTextGrey,
                                          textSize: 11,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GradientFilledButton(
                        title: 'Confirm & Support',
                        textSize: 16,
                        onPressed: () {
                          SupportResultRoute(profile).replace(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> onFollowTap() async {
    await ref
        .read(getProfileControllerProvider(profile.uuid).notifier)
        .follow();

    ref.read(metadataControllerProvider(profile.uuid).notifier).refresh();
  }

  Future<void> onUnFollowTap() async {
    await ref
        .read(getProfileControllerProvider(profile.uuid).notifier)
        .unfollow();

    ref.read(metadataControllerProvider(profile.uuid).notifier).refresh();
  }
}

class _TextForm extends StatelessWidget {
  const _TextForm({
    required this.hintText,
  });

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 12, color: colorWhite),
      decoration: InputDecoration(
        isDense: true,
        hintStyle: const TextStyle(fontSize: 12, color: colorTextGrey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        hintText: hintText,
      ),
    );
  }
}
