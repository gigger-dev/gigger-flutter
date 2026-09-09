import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/profile_setup/providers/profile_setup_controller.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class MottoWidget extends ConsumerStatefulWidget {
  const MottoWidget({super.key});

  @override
  ConsumerState<MottoWidget> createState() => _MottoWidgetState();
}

class _MottoWidgetState extends ConsumerState<MottoWidget> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(profileSetupControllerProvider);

    return Padding(
      padding: EdgeInsets.only(top: 0.2.sh),
      child: Column(
        children: [
          SizedBox(
            height: .3.sh,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextViewWidget(
                    text: 'Edit your motto here or leave empty',
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(height: 20),
                  MottoTextBox(
                    text: state.customPhrase,
                    onTapOutside: onTapOutside,
                    isEdit: state.customPhraseEdit,
                    key: ValueKey(state.customPhraseEdit),
                    onFieldSubmitted: (v) => setMottoData(
                      customPhrase: v,
                      customPhraseEdit: false,
                    ),
                    onChanged: (v) => setMottoData(customPhrase: v),
                  ),
                  const SizedBox(height: 10),
                  CupertinoButton(
                    minSize: 0,
                    padding: EdgeInsets.zero,
                    onPressed: () => setMottoData(customPhraseEdit: true),
                    child: TextViewWidget(text: 'Tap to Edit', color: colorRed),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: .3.sh,
            child: Column(
              children: [
                TextViewWidget(
                  text: 'Edit your closing phrase here or leave empty',
                  color: Colors.grey.shade500,
                ),
                const SizedBox(height: 20),
                MottoTextBox(
                  key: ValueKey(state.closingMessageEdit),
                  isEdit: state.closingMessageEdit,
                  text: state.closingMessage,
                  onTapOutside: onTapOutside,
                  onFieldSubmitted: (v) {
                    setMottoData(closingMessageEdit: false, closingMessage: v);
                  },
                  onChanged: (v) => setMottoData(closingMessage: v),
                ),
                const SizedBox(height: 10),
                CupertinoButton(
                  minSize: 0,
                  padding: EdgeInsets.zero,
                  onPressed: () => setMottoData(closingMessageEdit: true),
                  child: TextViewWidget(text: 'Tap to Edit', color: colorRed),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onTapOutside() {
    setMottoData(closingMessageEdit: false, customPhraseEdit: false);
  }

  void setMottoData({
    bool? closingMessageEdit,
    bool? customPhraseEdit,
    String? customPhrase,
    String? closingMessage,
  }) {
    ref.read(profileSetupControllerProvider.notifier).setMottoData(
          closingMessageEdit: closingMessageEdit,
          customPhraseEdit: customPhraseEdit,
          customPhrase: customPhrase,
          closingMessage: closingMessage,
        );
  }
}

class MottoTextBox extends StatelessWidget {
  const MottoTextBox({
    super.key,
    required this.isEdit,
    required this.text,
    required this.onTapOutside,
    this.autofocus = true,
    required this.onFieldSubmitted,
    required this.onChanged,
    this.focusNode,
  });

  final bool isEdit;
  final String? text;
  final bool autofocus;
  final FocusNode? focusNode;
  final VoidCallback onTapOutside;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    if (!isEdit) {
      if (text?.isEmpty ?? true) return const SizedBox();

      return TextViewWidget(
        text: '"$text"',
        textSize: 34,
        height: 1,
        textAlign: TextAlign.center,
      );
    }

    return TextFormField(
      autofocus: autofocus,
      initialValue: text,
      onChanged: onChanged,
      focusNode: focusNode,
      textAlign: TextAlign.center,
      onTapOutside: (_) => onTapOutside(),
      onFieldSubmitted: onFieldSubmitted,
      style: const TextStyle(fontSize: 20, color: colorWhite),
      decoration: const InputDecoration(
        isDense: true,
        border: InputBorder.none,
        constraints: BoxConstraints(minWidth: 0),
      ),
    );
  }
}
