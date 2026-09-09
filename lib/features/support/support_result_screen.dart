import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SupportResultScreen extends ConsumerStatefulWidget {
  const SupportResultScreen(this.profile, {super.key});

  final ProfileOut profile;

  @override
  ConsumerState<SupportResultScreen> createState() =>
      _SupportResultScreenState();
}

class _SupportResultScreenState extends ConsumerState<SupportResultScreen> {
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
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'THANK YOU,\n',
                            style: TextStyle(
                              fontSize: 36,
                              color: colorWhite,
                              height: 1,
                            ),
                          ),
                          TextSpan(
                            text: user.account.username,
                            style: const TextStyle(
                              height: 1,
                              fontSize: 36,
                              color: colorTextRed,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const TextViewWidget(
                      text: 'YOU SUPPORTED',
                      textSize: 20,
                    ),
                    const SizedBox(height: 20),
                    const TextViewWidget(
                      text: '129',
                      color: colorTextGrey,
                      textSize: 24,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: 60,
                        child: Divider(color: colorGrey),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text.rich(
                          TextSpan(
                            style: TextStyle(color: colorWhite, fontSize: 24),
                            children: [
                              TextSpan(
                                text: '130',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 34,
                                ),
                              ),
                              TextSpan(text: 'TIMES'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Image.asset(
                          Assets.images.badge.path,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          Assets.images.badgeOutline.path,
                          height: 20,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: 60,
                        child: Divider(color: colorGrey),
                      ),
                    ),
                    const TextViewWidget(
                      text: '131',
                      color: colorTextGrey,
                      textSize: 24,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const TextViewWidget(
                text: 'GIGGERS\naround the World',
                textAlign: TextAlign.center,
                textSize: 28,
                height: 1,
              ),
              const SizedBox(height: 14),
              const TextViewWidget(
                text:
                    'Your transaction is successful and it will be processed shortly,\nYou’ll be notified by email. Have a great day\nand remember to smile!',
                textAlign: TextAlign.center,
                textSize: 10,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: GradientFilledButton(
                  title: 'Close',
                  textSize: 16,
                  onPressed: () => context.pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
