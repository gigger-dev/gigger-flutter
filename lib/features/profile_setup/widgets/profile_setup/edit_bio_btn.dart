import 'package:flutter/cupertino.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class EditBioBtn extends StatelessWidget {
  const EditBioBtn({
    super.key,
    required this.isEditBio,
    required this.isLast,
    required this.bio,
    required this.onTap,
  });

  final bool isEditBio;
  final bool isLast;
  final String bio;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isEditBio || isLast ? 1 : .2,
      child: isLast
          ? TextViewWidget(text: bio, textSize: 14, textAlign: TextAlign.left)
          : GestureDetector(
              onTap: !isEditBio ? null : onTap,
              child: const TextViewWidget(
                text: 'Edit your bio',
                color: colorRed,
                textSize: 14,
              ),
            ),
    );
  }
}
