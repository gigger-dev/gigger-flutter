import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class FormTitleBar extends StatelessWidget {
  const FormTitleBar({
    super.key,
    required this.title,
    required this.onAdd,
    required this.semanticLabel,
    this.types,
  });

  final String title;
  final List<String>? types;
  final String semanticLabel;
  final ValueChanged<String?> onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextViewWidget(text: title, textSize: 14, color: Colors.grey.shade400),
        _ActionBtn(types: types, onAdd: onAdd, semanticLabel: semanticLabel),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.types,
    required this.onAdd,
    required this.semanticLabel,
  });

  final List<String>? types;
  final String semanticLabel;
  final ValueChanged<String?> onAdd;

  @override
  Widget build(BuildContext context) {
    if (types == null) {
      return CupertinoButton(
        minSize: 0,
        onPressed: () {
          context.clearFocus();
          onAdd(null);
        },
        padding: EdgeInsets.zero,
        child: Icon(
          Icons.add,
          color: colorWhite,
          size: 24,
          semanticLabel: semanticLabel,
        ),
      );
    }

    return Semantics(
      identifier: semanticLabel,
      child: PopupMenuButton(
        onSelected: onAdd,
        padding: EdgeInsets.zero,
        child: Icon(
          Icons.add,
          size: 20,
          color: colorWhite,
        ),
        itemBuilder: (context) => types!.map((e) {
          return PopupMenuItem(value: e, child: TextViewWidget(text: e));
        }).toList(),
      ),
    );
  }
}
