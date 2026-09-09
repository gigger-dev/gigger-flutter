import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/size_utils.dart';
import 'package:mobile_gigger_app/features/event_form/providers/line_up_controller.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class LineUpWidget extends ConsumerWidget {
  const LineUpWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var lineups = ref.watch(lineUpControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.edit, color: colorWhite),
          onTap: () => LineUpListRoute().push(context),
          title: TextViewWidget(
            text: 'Add lineup and performers',
            textSize: SizeUtils.textSizeExtraSmall,
          ),
        ),
        lineups.isEmpty
            ? SizedBox()
            : GestureDetector(
                onTap: () => LineUpListRoute().push(context),
                child: Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: lineups.length == 1 ? 30.0 : 24.0 * lineups.length,
                      child: Stack(
                        children: List.generate(
                          lineups.length,
                          (i) => Positioned(
                            left: i == 0 ? 0 : 14.0 * i,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: colorWhite),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    lineups[i].profile,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.more_horiz),
                    SizedBox(width: 4),
                    TextViewWidget(
                      text: 'Edit',
                      color: colorRed,
                      textSize: 14.sp,
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
