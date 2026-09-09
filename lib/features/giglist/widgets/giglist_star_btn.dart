import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/giglist/providers/giglist_metadata_controller.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class GiglistStarBtn extends ConsumerWidget {
  const GiglistStarBtn({
    super.key,
    required this.uuid,
    required this.gigListUuid,
  });

  final String uuid;
  final String gigListUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(gigListMetadataControllerProvider(
      gigListUuid: gigListUuid,
      viewerUuid: uuid,
    ));

    var metadata = state.whenData((v) => v).valueOrNull;

    if (metadata == null) return SizedBox();

    return IconButton(
      icon: Column(
        children: [
          Icon(
            metadata.hasAlreadyGivenStar ? Icons.star : Icons.star_outline,
            color: metadata.hasAlreadyGivenStar ? colorRed : colorWhite,
            size: 26,
          ),
          TextViewWidget(text: '${metadata.starCount}', textSize: 14),
        ],
      ),
      onPressed: () => onTap(ref),
    );
  }

  Future<void> onTap(WidgetRef ref) async {
    var controller = ref.read(gigListMetadataControllerProvider(
      gigListUuid: gigListUuid,
      viewerUuid: uuid,
    ).notifier);

    await controller.toggleStar();
  }
}
