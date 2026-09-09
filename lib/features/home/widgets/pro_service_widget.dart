import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/shimmer_utils.dart';
import 'package:mobile_gigger_app/features/home/providers/pro_service_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ProServiceWidget extends ConsumerWidget {
  const ProServiceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;
    var state = ref.watch(proServiceControllerProvider);

    return state.when(
      error: (error, stackTrace) => Text('$error'),
      loading: () => ShimmerUtils.topVideoList,
      data: (data) => StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
        itemCount: data.length,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 200),
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: index.isOdd ? 30 : 0),
            child: _ProServiceItem(data[index], cdnUrl: cdnUrl),
          );
        },
      ),
    );
  }
}

class _ProServiceItem extends StatelessWidget {
  const _ProServiceItem(this.data, {this.cdnUrl});

  final ProService data;
  final String? cdnUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 280,
          decoration: BoxDecoration(
            color: colorGrey,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(data.thumbnail),
            ),
          ),
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(6),
          child: Row(
            children: [
              TextViewWidget(text: data.name),
              SizedBox(width: 4),
              Icon(Icons.check_circle, color: colorRed, size: 14),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextViewWidget(text: data.title, textSize: 13),
              TextViewWidget(text: data.description, textSize: 10),
              if (data.location.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: colorTextGrey,
                        size: 11,
                      ),
                      Expanded(
                        child: TextViewWidget(
                          text:
                              '${data.location} - ${data.kilometers} from you',
                          textSize: 11,
                          maxLines: 1,
                          color: colorTextGrey,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
