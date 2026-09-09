import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/models/event_out.dart';

class EventContentTile extends StatelessWidget {
  const EventContentTile(
    this.data,
    this.cdnUrl, {
    super.key,
    required this.index,
    required this.items,
  });

  final int index;
  final EventOut data;
  final String? cdnUrl;
  final List<EventOut> items;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        EventScrollRoute(index: index, $extra: items).push(context);
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorGrey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      '$cdnUrl/${data.thumbnailUrl}',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 25.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: TextStyle(color: colorWhite, fontSize: 15.sp),
                  ),
                  SizedBox(height: 5.h),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(color: colorWhite, fontSize: 12.sp),
                      text: DateFormat('EEE dd MMM yyyy')
                          .format(data.startTime.toLocal()),
                      children: [
                        TextSpan(text: ' - '),
                        TextSpan(
                          text: DateFormat('h:mma')
                              .format(data.startTime.toLocal())
                              .toLowerCase(),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
