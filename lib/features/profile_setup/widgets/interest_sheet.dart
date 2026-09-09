import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/interest/providers/interest_provider.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/search_box.dart';
import 'package:mobile_gigger_app/models/interest_out.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class InterestSheet extends ConsumerStatefulWidget {
  const InterestSheet({
    super.key,
    required this.initialValue,
  });

  final List<InterestOut> initialValue;

  @override
  ConsumerState<InterestSheet> createState() => _ServiceSheetState();
}

class _ServiceSheetState extends ConsumerState<InterestSheet> {
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(interestProvider.notifier).setSelectedList(widget.initialValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(interestProvider);
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
                isSearch: isSearch,
                onChanged: onChanged,
              ),
              Expanded(
                child: state.when(
                  loading: () => CircularLoading(),
                  error: (e, _) => Center(child: TextViewWidget(text: '$e')),
                  data: (data) {
                    var items =
                        isSearch ? data.searchResultList : data.interestList;

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
                          value: data.selectedList.contains(e),
                          onChanged: (v) =>
                              onSelectChanged(v, e, data.selectedList.length),
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
                  onPressed: () {
                    context.pop(data?.selectedList ?? []);
                    ref.read(interestProvider.notifier).reset();
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void onSearch() {
    isSearch = true;
    setState(() {});
  }

  void onClear() {
    isSearch = false;
    setState(() {});
  }

  Future<void> onChanged(String v) async {
    debounce(
      () => ref.read(interestProvider.notifier).search(v),
      Duration(milliseconds: 500),
    ).call();
  }

  void onSelectChanged(bool? value, InterestOut data, int length) {
    if (value == true) {
      if (length > 5) return;
      ref.read(interestProvider.notifier).addInterestSelect(data);
    } else {
      ref.read(interestProvider.notifier).removeInterestSelect(data);
    }
  }
}
