import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';

import 'package:mobile_gigger_app/features/profile/presentation/widgets/fab_six_grid.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/video_item.dart';
import 'package:mobile_gigger_app/models/post_out.dart';

class FabSixVideo extends StatelessWidget {
  const FabSixVideo({
    super.key,
    required this.cdnUrl,
    required this.items,
    required this.onDelete,
    required this.isEditMode,
    required this.isOwner,
    required this.uuid,
  });

  final String cdnUrl;
  final bool isEditMode;
  final bool isOwner;
  final List<PostOut> items;
  final String uuid;
  final ValueChanged<String> onDelete;

  @override
  Widget build(BuildContext context) {
    var _items = items.sublist(0, min(items.length, 6));

    return FabSixGrid(
      itemCount:
          _items.length + (_items.length < 6 && !isEditMode && isOwner ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return FabAddBtn();
        }

        var e = _items[index];

        return VideoItem(
          data: e,
          uuid: uuid,
          index: index,
          cdnUrl: cdnUrl,
          items: _items,
          allItems: items,
          isOwner: isOwner,
          isEditMode: isEditMode,
          onDelete: () => onDelete(e.uuid),
        );
      },
    );
  }
}

class FabAddBtn extends ConsumerWidget {
  const FabAddBtn({
    super.key,
    this.height,
    this.width,
  });

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(postFormControllerProvider.notifier).type(ContentType.post);
        PostFormRoute().push(context);
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Color(0xff1D1D1D),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
