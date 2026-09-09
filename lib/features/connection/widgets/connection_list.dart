import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';

import 'package:mobile_gigger_app/features/connection/widgets/connection_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/profile_fewer_details_out.dart';
import 'package:mobile_gigger_app/widgets/popup_btn.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ConnectionList extends ConsumerWidget {
  const ConnectionList({
    super.key,
    required this.isFollowing,
    required this.items,
    this.onAccept,
    this.onReject,
  });

  final bool isFollowing;
  final Map<String, List<ProfileFewerDetailsOut>> items;

  final ValueChanged<String>? onAccept;
  final ValueChanged<String>? onReject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cdnUrl = ref.watch(configProvider.select((v) => v.value?.cdnUrl));

    // items.removeWhere((key, value) => value.isEmpty);

    return ListView.separated(
      itemCount: items.keys.length,
      padding: const EdgeInsets.all(20),
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        var key = items.keys.toList()[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextViewWidget(text: key),
                if (index != 0)
                  PopupBtn(
                    icon: TextViewWidget(
                      text: 'Sort By',
                      textSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    items: [
                      PopupItem(title: 'Latest', onTap: () {}),
                      PopupItem(title: 'Older', onTap: () {}),
                      PopupItem(title: 'Alphabetical', onTap: () {}),
                    ],
                  )
              ],
            ),
            const SizedBox(height: 20),
            if ((isFollowing ? 0 : 1) == index && ((items[key] ?? []).isEmpty))
              SizedBox(
                height: .2.sh,
                child: Center(
                  child: TextViewWidget(text: 'EMPTY', color: colorGrey),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                itemCount: items[key]?.length ?? 0,
                separatorBuilder: (_, __) => SizedBox(height: 10),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ConnectionItem(
                    items[key]![index],
                    cdnUrl,
                    isFollowing: isFollowing,
                    onAccept: onAccept,
                    onReject: onReject,
                  );
                },
              )
          ],
        );
      },
    );
  }
}
