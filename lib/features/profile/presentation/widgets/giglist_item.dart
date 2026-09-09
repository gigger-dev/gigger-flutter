import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/models/gig_list_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class GiglistItem extends StatelessWidget {
  const GiglistItem(
    this.data,
    this.cdnUrl, {
    super.key,
    required this.index,
    required this.isVisitor,
    required this.uuid,
  });

  final String? cdnUrl;
  final GigListOut data;
  final int index;
  final String? uuid;
  final bool isVisitor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GiglistScrollRoute(
        profileUuid: uuid,
        index: index,
        isVisitor: isVisitor,
      ).push(context),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: colorGrey,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      data.thumbnailUrl.isEmpty
                          ? '$cdnUrl/${data.gigListMedia.values.where((e) => !e.isVideo).firstOrNull?.mediaUrl}'
                          : '$cdnUrl/${data.thumbnailUrl}',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 25.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextViewWidget(text: data.title),
                    SizedBox(height: 5.h),
                    if (data.location.isNotEmpty)
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: colorWhite,
                            size: 12,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: TextViewWidget(
                              text: data.location,
                              //  - ${Random().nextInt(100) + 20} km from you',
                              textSize: 10, maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
