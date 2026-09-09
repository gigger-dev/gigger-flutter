import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FabSixGrid extends StatelessWidget {
  const FabSixGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.isDynamic = true,
  });

  final int itemCount;
  final bool isDynamic;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      crossAxisCount: 3,
      itemCount: itemCount,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      itemBuilder: itemBuilder,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      staggeredTileBuilder: (int index) {
        if (!isDynamic) return const StaggeredTile.extent(1, (1 / 2) * 400);

        if (index % 6 == 2 || index % 6 == 3 || index % 6 == 4) {
          return const StaggeredTile.extent(1, (1 / 2) * 400);
        } else if (index % 6 == 0) {
          return const StaggeredTile.extent(1, (1 / 2) * 400);
        } else if (index % 6 == 1) {
          return const StaggeredTile.extent(2, (1 / 2) * 400);
        } else {
          return const StaggeredTile.extent(3, (1 / 2) * 400);
        }
      },
    );
  }
}
