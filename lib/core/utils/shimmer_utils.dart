import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUtils {
  static Widget topVideoList = StaggeredGridView.countBuilder(
    scrollDirection: Axis.vertical,
    crossAxisCount: 2,
    shrinkWrap: true,
    itemCount: 12,
    itemBuilder: (BuildContext context, int index) {
      return Shimmer.fromColors(
        baseColor: colorBlackSemiTransparent,
        highlightColor: colorTransparent,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
        ),
      );
    },
    staggeredTileBuilder: (int index) {
      if (index % 6 == 5) {
        return const StaggeredTile.extent(3, (1 / 2) * 400);
      } else if (index % 6 == 3) {
        return const StaggeredTile.extent(1, (1 / 2) * 400);
      } else if (index % 6 == 4) {
        return const StaggeredTile.extent(2, (1 / 2) * 400);
      } else {
        return const StaggeredTile.extent(1, (1 / 2) * 400);
      }
    },
    padding: EdgeInsets.only(left: 10.w, right: 10.w),
    mainAxisSpacing: 10.0,
    crossAxisSpacing: 10.0,
  );
}
