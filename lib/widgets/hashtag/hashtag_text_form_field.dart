import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_gigger_app/widgets/hashtag/hashtag_text_field.dart';

class HashtagTextFormField extends FormField<String> {
  final bool isMultiple;
  final FocusNode? focusNode;
  final TextStyle? decoratedStyle;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final String trigger;

  HashtagTextFormField({
    super.key,
    super.onSaved,
    super.validator,
    this.decoratedStyle,
    InputDecoration? decoration,
    this.onChanged,
    this.controller,
    this.onSubmitted,
    this.focusNode,
    this.trigger = '#',
    this.isMultiple = true,
    AutovalidateMode? autovalidateMode,
  }) : super(
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (field) {
            final state = field as _HashtagTextFormFieldState;

            final effectiveDecoration = (decoration ?? const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);
            void onChangedHandler(String value) {
              field.didChange(value);
              onChanged?.call(value);
            }

            return UnmanagedRestorationScope(
              bucket: field.bucket,
              child: HashTagTextField(
                focusNode: focusNode,
                onSubmitted: onSubmitted,
                decoratedStyle: decoratedStyle,
                controller: state._effectiveController,
                inputFormatters: [
                  HashtagFormatter(trigger),
                  if (!isMultiple) FilteringTextInputFormatter.deny(' ')
                ],
                onChanged: onChangedHandler,
                decoration:
                    effectiveDecoration.copyWith(errorText: field.errorText),
              ),
            );
          },
        );

  @override
  FormFieldState<String> createState() => _HashtagTextFormFieldState();
}

class _HashtagTextFormFieldState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController =>
      _textFormField.controller ?? _controller!.value;

  HashtagTextFormField get _textFormField =>
      super.widget as HashtagTextFormField;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    // Make sure to update the internal [FormFieldState] value to sync up with
    // text editing controller value.
    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    if (_textFormField.controller == null) {
      _createLocalController(widget.initialValue != null
          ? TextEditingValue(text: widget.initialValue!)
          : null);
    } else {
      _textFormField.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(HashtagTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_textFormField.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _textFormField.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _textFormField.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (_textFormField.controller != null) {
        setValue(_textFormField.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _textFormField.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let
    // _handleControllerChanged suppress the change.
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
    _textFormField.onChanged?.call(_effectiveController.text);
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}

class HashtagFormatter extends TextInputFormatter {
  HashtagFormatter(this.trigger);

  final String trigger;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final words = newValue.text.split(' ');
    final formattedWords = words.map((word) {
      if (word.isNotEmpty && !word.startsWith('#') && !word.startsWith('@')) {
        return '$trigger$word';
      }
      return word;
    }).join(' ');

    return TextEditingValue(
      text: formattedWords,
      selection: TextSelection.fromPosition(
        TextPosition(offset: formattedWords.length),
      ),
    );
  }
}
