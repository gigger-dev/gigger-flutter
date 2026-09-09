import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/models/line_up_and_performer_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class LineupListWidget extends StatelessWidget {
  const LineupListWidget({
    super.key,
    required this.items,
    required this.cdnUrl,
  });

  final String cdnUrl;
  final List<LineUpAndPerformerOut> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return SizedBox();

    return Column(
      children: [
        Center(
          child: TextViewWidget(text: 'Lineup'),
        ),
        SizedBox(height: 20.sp),
        SizedBox(
          height: 110.sp,
          child: ListView.separated(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20),
            separatorBuilder: (_, __) => SizedBox(width: 20.sp),
            itemBuilder: (context, index) {
              var data = items[index];

              return Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: colorGrey,
                    backgroundImage: CachedNetworkImageProvider(
                      '$cdnUrl/${data.profile.avatarMedia}',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextViewWidget(
                    text: data.profile.account.username,
                    textSize: 12.sp,
                    maxLines: 1,
                  ),
                  TextViewWidget(
                    text: DateFormat('HH.mma').format(data.startTime.toLocal()),
                    maxLines: 1,
                    textSize: 10.sp,
                    color: colorTextGrey,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
