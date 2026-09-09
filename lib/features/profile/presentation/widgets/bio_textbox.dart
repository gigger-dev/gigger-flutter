import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';

class BioTextbox extends StatelessWidget {
  const BioTextbox({
    super.key,
    required this.isEditMode,
    required this.bio,
    required this.onTap,
    required this.onReadBio,
  });

  final bool isEditMode;
  final String bio;
  final VoidCallback onReadBio;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (!isEditMode) {
      return RichText(
        text: TextSpan(
          text: bio.length > 90 ? '${bio.substring(0, 90)}...' : bio,
          style: TextStyle(color: colorWhite, fontSize: 16),
          children: [
            TextSpan(
              text: ' Read bio',
              style: TextStyle(color: colorRed, fontSize: 14),
              recognizer: TapGestureRecognizer()..onTap = onReadBio,
            )
          ],
        ),
      );
    }

    return RichText(
      text: TextSpan(
        text: bio.length > 90 ? '${bio.substring(0, 90)}...' : bio,
        style: TextStyle(color: colorWhite, fontSize: 16),
        children: [
          TextSpan(
            text: ' Edit your bio',
            style: TextStyle(color: colorRed, fontSize: 14),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          )
        ],
      ),
    );
  }
}
