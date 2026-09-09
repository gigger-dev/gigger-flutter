import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    this.color,
    this.onTap,
    this.isRequiredPro = false,
    this.haveArrow = false,
    this.value,
    this.onChanged,
    this.description,
    this.horizontal = 14,
    this.spacing = 20,
    this.fontSize = 14,
    this.trailing,
    this.leading,
    this.autoResize = false,
    this.subtitle,
    this.disable = false,
    this.contentPadding,
    this.proColor,
  });

  final double horizontal;
  final double spacing;

  final String title;
  final String? subtitle;
  final double fontSize;
  final String? description;
  final Color? color;
  final Color? proColor;
  final bool isRequiredPro;
  final bool haveArrow;
  final VoidCallback? onTap;
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final Widget? trailing;
  final Widget? leading;
  final bool autoResize;
  final bool disable;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    var trailing = _trailingWidget();
    var tilte = _titleWidget();

    return Opacity(
      opacity: disable ? .5 : 1,
      child: IgnorePointer(
        ignoring: disable,
        child: Column(
          children: [
            ListTile(
              dense: true,
              title: tilte,
              leading: leading,
              minLeadingWidth: 0,
              contentPadding: contentPadding,
              onTap: disable ? null : onTap,
              subtitle: subtitle == null
                  ? null
                  : TextViewWidget(
                      text: subtitle!,
                      textSize: 12,
                      color: Colors.grey,
                    ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              trailing: trailing,
            ),
            if (description != null)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontal,
                  spacing,
                  horizontal,
                  0,
                ),
                child: TextViewWidget(
                  text: description!,
                  textSize: 11.5,
                  color: colorTextGrey,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget? _trailingWidget() {
    if (trailing != null) return trailing;

    if (haveArrow) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.right_chevron,
            color: colorWhite,
            size: 18,
          ),
        ],
      );
    }

    if (value != null && onChanged != null) {
      return Column(
        children: [
          CustomSwitch(value: value!, onChanged: onChanged!),
        ],
      );
    }

    if (isRequiredPro) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: TextViewWidget(
              text: 'PRO',
              // text: 'Subscribe to Gigger PRO',
              color: colorRed,
              textSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      );
    }

    return null;
  }

  Widget _titleWidget() {
    var child = Row(
      children: [
        TextViewWidget(
          text: title,
          color: color,
          textSize: description == null ? fontSize : 12,
        ),
        if (isRequiredPro && (haveArrow || value != null))
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TextViewWidget(
              text: 'PRO',
              color: proColor ?? colorRed,
              textSize: 12,
            ),
          ),
      ],
    );

    if (!autoResize) return child;

    return FittedBox(
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .7,
      child: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        trackColor: colorGrey,
        activeColor: colorGrey,
        thumbColor: value ? colorRed : null,
      ),
    );
  }
}
