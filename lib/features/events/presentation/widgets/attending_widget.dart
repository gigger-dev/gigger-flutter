import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/features/events/presentation/widgets/event_detail_sheet.dart';
import 'package:mobile_gigger_app/features/home/providers/event_metadata_controller.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class AttendingWidget extends ConsumerWidget {
  const AttendingWidget({
    super.key,
    required this.viewerUuid,
    required this.eventUuid,
    required this.cdnUrl,
  });

  final String cdnUrl;
  final String viewerUuid;
  final String eventUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var metadata = ref
        .watch(eventMetadataControllerProvider(
          eventUuid: eventUuid,
          viewerUuid: viewerUuid,
        ))
        .valueOrNull;

    if (metadata == null || metadata.goingProfile.isEmpty) return SizedBox();

    return Row(
      children: [
        TextViewWidget(text: 'Attending', textSize: 12.sp),
        SizedBox(width: 20.sp),
        AvatarGroup(
          count: metadata.goingProfile.length,
          imgGetter: (i) => '$cdnUrl/${metadata.goingProfile[i].avatarMedia}',
        ),
        Icon(Icons.more_horiz),
      ],
    );
  }
}
