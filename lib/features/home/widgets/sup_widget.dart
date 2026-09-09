import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/features/home/providers/selector_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/sup_controller.dart';
import 'package:mobile_gigger_app/features/home/widgets/sup_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';

class SupWidget extends ConsumerStatefulWidget {
  const SupWidget({super.key});

  @override
  ConsumerState<SupWidget> createState() => _SupWidgetState();
}

class _SupWidgetState extends ConsumerState<SupWidget> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;

    var createFrom = ref.watch(selectorControllerProvider);

    var state = ref.watch(supControllerProvider(createFrom));

    return state.when(
      loading: () => SizedBox(),
      error: (error, stackTrace) => SizedBox(),
      data: (data) => ListView.separated(
        itemCount: data.items.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          var e = data.items[index];

          return SupItem(e, cdnUrl, index);
        },
      ),
    );
  }
}
