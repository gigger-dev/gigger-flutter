import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile_gigger_app/models/interest_out.dart';
import 'package:mobile_gigger_app/models/skill_out.dart';

part 'gigger_filter_controller.g.dart';

@riverpod
class GiggerFilterController extends _$GiggerFilterController {
  @override
  GiggerFilterState build() => GiggerFilterState();

  void interest(InterestOut value) {
    state = state.copyWith(interest: value);
  }

  void skill(SkillOut value) {
    state = state.copyWith(skill: value);
  }
}

class GiggerFilterState {
  final InterestOut? interest;
  final SkillOut? skill;

  GiggerFilterState({
    this.interest,
    this.skill,
  });

  GiggerFilterState copyWith({
    InterestOut? interest,
    SkillOut? skill,
  }) {
    return GiggerFilterState(
      interest: interest ?? this.interest,
      skill: skill ?? this.skill,
    );
  }
}
