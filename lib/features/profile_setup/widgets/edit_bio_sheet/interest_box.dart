import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/form_title_bar.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/interest_sheet.dart';
import 'package:mobile_gigger_app/models/interest_out.dart';

class InterestBox extends StatelessWidget {
  const InterestBox({
    super.key,
    required this.selected,
    required this.items,
    required this.onRemove,
    required this.onChanged,
  });

  final List<InterestOut> selected;
  final List<InterestOut> items;
  final ValueChanged<int> onRemove;
  final ValueChanged<List<InterestOut>> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormTitleBar(
          title: 'Musical Preferences',
          onAdd: (_) => onAdd(context),
          semanticLabel: 'interest_add_btn',
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
                return _InterestItem(
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
    var value = await showModalBottomSheet<List<InterestOut>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => InterestSheet(initialValue: selected),
    );

    if (value == null) return;

    onChanged(value);
  }
}

class _InterestItem extends StatelessWidget {
  const _InterestItem({
    super.key,
    required this.onRemove,
    required this.data,
  });

  final InterestOut data;
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
            controller: TextEditingController(text: data.name),
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
