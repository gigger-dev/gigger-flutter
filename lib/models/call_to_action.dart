// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_to_action.freezed.dart';
part 'call_to_action.g.dart';

@Freezed()
abstract class CallToAction with _$CallToAction {
  const factory CallToAction({
    required String name,
    required String value,
  }) = _CallToAction;

  factory CallToAction.fromJson(Map<String, Object?> json) =>
      _$CallToActionFromJson(json);
}
