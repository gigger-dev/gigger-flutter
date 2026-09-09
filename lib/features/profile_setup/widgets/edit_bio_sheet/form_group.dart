import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/form_title_bar.dart';

class FormGroup extends StatelessWidget {
  const FormGroup({
    super.key,
    required this.title,
    required this.items,
    required this.onAdd,
    this.hintText,
    required this.onRemove,
    this.types,
    required this.focus,
    required this.semanticLabel,
  });

  final String title;
  final String semanticLabel;
  final String? hintText;
  final ValueChanged<String?> onAdd;
  final ValueChanged<int> onRemove;
  final List<TextEditingController> items;
  final List<String>? types;
  final List<FocusNode> focus;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormTitleBar(
          title: title,
          types: types,
          semanticLabel: semanticLabel,
          onAdd: (value) {
            onAdd(value);
            focus.lastOrNull?.requestFocus();
          },
        ),
        if (items.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: items.length,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                return _FormItem(
                  hintText: hintText,
                  controller: items[index],
                  focusNode: focus.elementAtOrNull(index),
                  onRemove: () => onRemove(index),
                );
              },
            ),
          )
      ],
    );
  }
}

class _FormItem extends StatelessWidget {
  const _FormItem({
    required this.focusNode,
    required this.controller,
    required this.hintText,
    required this.onRemove,
  });

  final String? hintText;
  final FocusNode? focusNode;
  final VoidCallback onRemove;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.circle_outlined, color: colorRed, size: 14),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            onTapOutside: (_) => context.clearFocus(),
            validator: (v) => v!.isEmpty ? 'required' : null,
            style: const TextStyle(fontSize: 13, color: colorWhite),
            decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
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
