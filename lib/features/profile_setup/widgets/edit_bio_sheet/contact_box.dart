import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/edit_bio_sheet/form_title_bar.dart';

class ContactBox extends StatefulWidget {
  const ContactBox({
    super.key,
    required this.items,
    required this.onAdd,
    required this.onRemove,
    required this.focus,
  });

  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;
  final Map<String, FocusNode> focus;
  final Map<String, TextEditingController> items;

  @override
  State<ContactBox> createState() => ContactBoxState();
}

class ContactBoxState extends State<ContactBox> {
  @override
  Widget build(BuildContext context) {
    var items = ['Phone', 'Email', 'Other']
      ..removeWhere((e) => widget.items.keys.contains(e));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormTitleBar(
          types: items,
          title: 'Contact me!',
          semanticLabel: 'contact_add_btn',
          onAdd: (v) {
            if (v == null) return;
            widget.onAdd(v);
            widget.focus[v]?.requestFocus();
          },
        ),
        if (widget.items.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: widget.items.length,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                var key = widget.items.keys.elementAt(index);

                return _ContactItem(
                  data: key,
                  focusNode: widget.focus[key],
                  controller: widget.items[key],
                  onRemove: () => widget.onRemove(key),
                );
              },
            ),
          )
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    required this.data,
    required this.focusNode,
    required this.controller,
    required this.onRemove,
  });

  final String data;
  final FocusNode? focusNode;
  final VoidCallback onRemove;
  final TextEditingController? controller;

  IconData get icon {
    if (data == 'Phone') return Icons.phone_outlined;
    if (data == 'Email') return Icons.email_outlined;
    return Icons.circle_outlined;
  }

  TextInputType get keyboardType {
    if (data == 'Phone') return TextInputType.phone;
    if (data == 'Email') return TextInputType.emailAddress;
    return TextInputType.text;
  }

  String get hintText {
    if (data == 'Phone') return 'Type phone number ...';
    if (data == 'Email') return 'Type email ...';
    return 'Type other ...';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: colorRed, size: 14),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            keyboardType: keyboardType,
            onTapOutside: (_) => context.clearFocus(),
            validator: (v) => v!.isEmpty ? 'required' : null,
            style: const TextStyle(fontSize: 13, color: colorWhite),
            decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
          ),
        ),
        const SizedBox(width: 10),
        CupertinoButton(
          minSize: 0,
          onPressed: onRemove,
          padding: EdgeInsets.zero,
          child: Icon(Icons.clear, color: colorWhite, size: 20),
        )
      ],
    );
  }
}
