import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/notification/presentation/provider/noti_count_provider.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class NotiBtn extends ConsumerWidget {
  const NotiBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notiCount = ref.watch(notiCountProvider);

    return StreamBuilder(
      stream: StreamChat.of(context).client.state.totalUnreadCountStream,
      builder: (context, snapshot) {
        var count = (snapshot.hasError ? 0 : snapshot.data ?? 0) + notiCount;

        return IconButton(
          onPressed: () => const NotiRoute().push(context),
          icon: Badge.count(
            smallSize: 1,
            largeSize: 11,
            count: int.parse('$count'),
            textColor: colorWhite,
            padding: EdgeInsets.zero,
            backgroundColor: colorRed,
            isLabelVisible: count > 0,
            child: Image.asset(
              Assets.images.giNotificationOutline.path,
              fit: BoxFit.fill,
              color: colorWhite,
              width: 22,
              height: 22,
            ),
          ),
        );
      },
    );
  }
}
