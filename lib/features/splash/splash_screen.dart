import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/features/splash/providers/splash_controller.dart';
import 'package:mobile_gigger_app/features/splash/widgets/footer_text.dart';
import 'package:mobile_gigger_app/features/splash/widgets/refresh_btn.dart';
import 'package:mobile_gigger_app/features/splash/widgets/splash_bg.dart';
import 'package:mobile_gigger_app/features/splash/widgets/splash_logo.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(configProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    var splashError = ref.watch(splashControllerProvider);

    return Scaffold(
      body: SplashBg(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SplashLogo(),
                  const SizedBox(height: 30),
                  splashError == null
                      ? Transform.scale(
                          scale: .6,
                          child: const CircularProgressIndicator(),
                        )
                      : RefreshBtn(onTap: () => onRefresh(ref)),
                ],
              ),
            ),
            FooterText(),
          ],
        ),
      ),
    );
  }

  void onRefresh(WidgetRef ref) {
    ref.read(splashControllerProvider.notifier).update(null);
  }
}
