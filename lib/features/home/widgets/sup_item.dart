import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/home/providers/new_sup_controller.dart';
import 'package:mobile_gigger_app/features/sup/sup_all_screen.dart';
import 'package:mobile_gigger_app/models/profile_fewer_details_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SupItem extends ConsumerWidget {
  const SupItem(this.data, this.cdnUrl, this.index, {super.key});

  final int index;
  final String? cdnUrl;
  final ProfileFewerDetailsOut data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var newSups = ref.watch(newSupControllerProvider(data.uuid));

    var isNew = newSups.values.any((e) => e.values.any((e) => e));

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SupAllScreen(index: index),
            ));
            // showModalBottomSheet(
            //   context: context,
            //   isScrollControlled: true,
            //   backgroundColor: colorTransparent,
            //   builder: (context) => SupAllScreen(index: index),
            // );
          },
          child: SizedBox(
            width: .23.sw,
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: colorGrey,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        '$cdnUrl/${data.avatarMedia}',
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 6,
                        offset: const Offset(4, 14),
                        color: Colors.black.withOpacity(.6),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: TextViewWidget(
                    text: data.account.username,
                    color: colorWhite,
                    maxLines: 1,
                    textSize: 12.sp,
                    textAlign: TextAlign.center,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
        if (isNew)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 4,
                    offset: Offset(3, 7),
                    color: Colors.black26,
                  ),
                ],
              ),
              child: const TextViewWidget(
                text: 'NEW S\'UP!',
                color: Colors.white,
                textSize: 6,
              ),
            ),
          ),
      ],
    );
  }
}
