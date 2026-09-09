import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/form_title_bar.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/service_sheet.dart';
import 'package:mobile_gigger_app/models/my_services_out.dart';

class ServiceBox extends ConsumerWidget {
  const ServiceBox({
    super.key,
    required this.items,
    required this.onRemove,
    required this.selected,
    required this.onChanged,
  });

  final ValueChanged<int> onRemove;
  final List<MyServicesOut> items;
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormTitleBar(
          title: 'What I can do',
          onAdd: (_) => onAdd(context),
          semanticLabel: 'service_add_btn',
        ),
        if (selected.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: selected.length,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                return _ServiceItem(
                  items: items,
                  data: selected[index],
                  onRemove: () => onRemove(index),
                );
              },
            ),
          )
      ],
    );
  }

  Future<void> onAdd(BuildContext context) async {
    var value = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ServiceSheet(initialValue: selected),
    );

    if (value == null) return;

    onChanged(value);
  }
}

class _ServiceItem extends StatelessWidget {
  const _ServiceItem({
    required this.onRemove,
    required this.data,
    required this.items,
  });

  final String data;
  final List<MyServicesOut> items;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.circle_outlined, color: colorRed, size: 14),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            readOnly: true,
            onTap: onRemove,
            validator: (v) => v!.isEmpty ? 'required' : null,
            controller: TextEditingController(
              text: items.where((e) => e.uuid == data).firstOrNull?.name,
            ),
            style: const TextStyle(fontSize: 13, color: colorWhite),
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Insert here ...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        CupertinoButton(
          minSize: 0,
          onPressed: onRemove,
          padding: EdgeInsets.zero,
          child: const Icon(Icons.clear, color: colorWhite, size: 20),
        )
      ],
    );
  }
}
