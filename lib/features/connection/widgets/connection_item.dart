import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/models/profile_fewer_details_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ConnectionItem extends ConsumerWidget {
  const ConnectionItem(
    this.data,
    this.cdnUrl, {
    super.key,
    required this.isFollowing,
    this.onAccept,
    this.onReject,
  });

  final String? cdnUrl;
  final bool isFollowing;
  final ProfileFewerDetailsOut data;
  final ValueChanged<String>? onAccept;
  final ValueChanged<String>? onReject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      dense: true,
      onTap: () => ProfileRoute(uuid: data.uuid).push(context),
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: colorGrey,
        backgroundImage: CachedNetworkImageProvider(
          '$cdnUrl/${data.avatarMedia}',
        ),
      ),
      title: TextViewWidget(
        text: data.account.username,
        textSize: 16,
      ),
      subtitle: isFollowing
          ? null
          : Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () => onAccept?.call(data.uuid),
                    style: FilledButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: TextViewWidget(text: 'Confirm'),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: FilledButton(
                    onPressed: () => onReject?.call(data.uuid),
                    style: FilledButton.styleFrom(
                      minimumSize: Size.zero,
                      backgroundColor: colorTextGrey,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: TextViewWidget(
                      text: 'Delete',
                      color: colorBlack,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
