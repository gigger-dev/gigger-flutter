import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/profile_setup/providers/service_provider.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/search_box.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ServiceSheet extends ConsumerStatefulWidget {
  const ServiceSheet({
    super.key,
    required this.initialValue,
  });

  final List<String> initialValue;

  @override
  ConsumerState<ServiceSheet> createState() => _ServiceSheetState();
}

class _ServiceSheetState extends ConsumerState<ServiceSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      ref.read(serviceProvider.notifier).resetSearchData(widget.initialValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(serviceProvider);
    var data = state.whenData((v) => v).value;

    return DraggableScrollableSheet(
      maxChildSize: .9,
      initialChildSize: .9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              SearchBox(
                onClear: onClear,
                onSearch: onSearch,
                onChanged: onChanged,
                isSearch: data?.isSearch ?? true,
              ),
              Expanded(
                child: state.when(
                  loading: () => CircularLoading(),
                  error: (e, _) => Center(child: TextViewWidget(text: '$e')),
                  data: (data) {
                    var items = data.isSearch ? data.items : data.allItems;

                    if (items.isEmpty) {
                      return const Center(
                        child: TextViewWidget(
                          text: 'No data found',
                          color: colorTextGrey,
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: items.length,
                      padding: EdgeInsets.zero,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        var e = items[index];

                        return CheckboxListTile(
                          dense: true,
                          title: TextViewWidget(text: e.name),
                          value: data.selected.contains(e.uuid),
                          onChanged: (v) => onSelectChanged(v, e.uuid),
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GradientFilledButton(
                  title: 'Save',
                  onPressed: () => context.pop(data?.selected ?? []),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void onSearch() {
    ref.read(serviceProvider.notifier).isSearch(true);
  }

  void onClear() {
    ref.read(serviceProvider.notifier).isSearch(false);
  }

  Future<void> onChanged(String v) async {
    await ref.read(serviceProvider.notifier).search(v);
  }

  void onSelectChanged(bool? value, String uuid) {
    if (value == true) {
      ref.read(serviceProvider.notifier).addSelected(uuid);
    } else {
      ref.read(serviceProvider.notifier).removeSelected(uuid);
    }
  }
}
