import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/empty_card.dart';

class SixGrid extends StatelessWidget {
  const SixGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      itemCount: 6,
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      staggeredTileBuilder: (i) {
        if (i == 1) return StaggeredTile.extent(2, (1 / 2) * 340);
        if (i == 5) return StaggeredTile.extent(3, (1 / 2) * 340);
        return StaggeredTile.extent(1, (1 / 2) * 340);
      },
      itemBuilder: (context, index) {
        return const EmptyCard();
      },
    );
  }
}
