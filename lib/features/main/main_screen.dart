import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/helpers/chat_helper.dart';
import 'package:mobile_gigger_app/core/helpers/messaging_helper.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/switch_user_controller.dart';
import 'package:mobile_gigger_app/features/home/home_screen.dart';
import 'package:mobile_gigger_app/features/main/providers/main_controller.dart';
import 'package:mobile_gigger_app/features/main/providers/noti_token_controller.dart';
import 'package:mobile_gigger_app/features/main/widgets/add_item.dart';
import 'package:mobile_gigger_app/features/main/widgets/custom_bottom_bar.dart';
import 'package:mobile_gigger_app/features/main/widgets/profile_slider.dart';
import 'package:mobile_gigger_app/features/profile/presentation/profile_screen.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profiles_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/chat_token_provider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key, this.child, this.isHide = false});

  final Widget? child;
  final bool isHide;

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    super.initState();
    MessagingHelper.initialize();
    data();
  }

  Future<void> data() async {
    await ref.read(switchUserControllerProvider.notifier).clear();

    await ref.read(profileControllerProvider.notifier).getProfile();
    ref.read(notiTokenControllerProvider);

    var profile = await ref.read(profileControllerProvider.future);

    if (profile == null) {
      ref.read(authControllerProvider.notifier).redirectToProfileSetup();
      return;
    }

    var token = await ref.read(chatTokenProviderProvider(profile.uuid).future);

    var config = await ref.read(configProvider.future);

    if (!mounted) return;
    try {
      await ChatHelper.connectUser(
        context,
        profile,
        config!.cdnUrl,
        token,
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(mainControllerProvider);

    var cdnUrl = ref.watch(configProvider.select((v) => v.value?.cdnUrl));

    var profileState = ref.watch(profileControllerProvider);

    var avatarMedia = profileState.whenData((v) => v?.avatarMedia).valueOrNull;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: widget.child ??
          IndexedStack(
            index: state.bottom,
            children: [
              HomeScreen(),
              SizedBox(),
              ProfileScreen(),
            ],
          ),
      bottomNavigationBar: widget.isHide
          ? null
          : CustomBottomBar(
              items: [
                BottomItem(
                  isSelected: state.bottom == 0,
                  icon: Assets.images.logoMenu,
                  useColor: false,
                  onTap: () => onTap(0),
                ),
                AddItem(key: ValueKey('add_btn')),
                BottomItem(
                  identifier: 'profile_menu_btn',
                  isSelected: state.bottom == 2,
                  onTap: () => onTap(2),
                  onLongPress: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SwitchSheet(),
                  ),
                  icon: Skeletonizer(
                    enabled: profileState.isLoading,
                    child: Skeleton.leaf(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: colorWhite),
                          image: avatarMedia == null
                              ? null
                              : DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    '$cdnUrl/$avatarMedia',
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void onTap(int value) {
    ref.read(mainControllerProvider.notifier).bottom(value);
    if (widget.child != null) MainRoute().go(context);
  }
}

class SwitchSheet extends ConsumerStatefulWidget {
  const SwitchSheet({super.key});

  @override
  ConsumerState<SwitchSheet> createState() => _SwitchSheetState();
}

class _SwitchSheetState extends ConsumerState<SwitchSheet> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider.select((v) => v.value?.cdnUrl));

    var profileUuid = ref.watch(profileControllerProvider).valueOrNull?.uuid;
    var state = ref.watch(profilesControllerProvider);

    return state.when(
      error: (error, stackTrace) => SizedBox(),
      loading: () => CircularLoading(height: .2.sh),
      data: (users) {
        var user = users.elementAtOrNull(index);

        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: .74,
          minChildSize: .74,
          initialChildSize: .74,
          builder: (context, scrollController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 100, child: Divider(color: colorWhite)),
                const SizedBox(height: 20),
                const TextViewWidget(text: 'Change account, or add a new one.'),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  height: user == null ? 10 : 20,
                ),
                ProfileSlider(
                  users: users,
                  cdnUrl: cdnUrl,
                  onChanged: (value) {
                    index = value;
                    setState(() {});
                  },
                ),
                Spacer(),
                if (user != null)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: CachedNetworkImageProvider(
                              '$cdnUrl/${user.avatarMedia}',
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 140,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextViewWidget(text: user.account.username),
                                TextViewWidget(
                                  text:
                                      '${user.location.city} - ${user.location.state}',
                                  maxLines: 1,
                                  textSize: 12,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => context.pop(),
                              child:
                                  const TextViewWidget(text: 'Back to profile'),
                            ),
                            if (profileUuid != user.uuid)
                              GradientFilledButton(
                                title: 'Select',
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                onPressed: () => onSelect(user),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                if (user == null) ...[
                  const SizedBox(height: 10),
                  const TextViewWidget(
                    text: 'Check invitation to be admin',
                    color: colorRed,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // OutlinedBtn(
                        //   onPressed: () {},
                        //   text: 'Create a Band / Collective',
                        // ),
                        // const SizedBox(height: 8),
                        GradientFilledButton(
                          textSize: 14,
                          title: 'Add / create a new account',
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          onPressed: () async {
                            if (users.length > 1) {
                              SheetUtils.proComingSoonSheet(context);
                              return;
                            }

                            await ref
                                .read(authControllerProvider.notifier)
                                .logout();
                          },
                        ),
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const TextViewWidget(text: 'Cancel'),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: 20),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> onSelect(ProfileOut user) async {
    await ref.read(switchUserControllerProvider.notifier).set(user.uuid);
    if (mounted) await ChatHelper.disconnectUser(context);
    await ref.read(authControllerProvider.notifier).logout();
  }
}
