import 'package:mobile_gigger_app/features/profile/data/profile_provider.dart';
import 'package:mobile_gigger_app/features/profile/domain/profile_use_case.dart';
import 'package:mobile_gigger_app/models/skill_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'skill_provider.g.dart';

@Riverpod(keepAlive: true)
class Skill extends _$Skill {
  @override
  Future<SkillState> build() async {
    var s = SkillState.init();
    try {
      var repo = ref.read(profileRepoProvider);
      var items = await getApiV1ProfilesSkillsUseCase(repo: repo);
      return s.copyWith(items: items, allItems: items);
    } catch (e) {
      return s;
    }
  }

  Future<void> search(String query) async {
    try {
      var state = await future;
      if (query.isEmpty) {
        this.state = AsyncData(state);
        return;
      }

      var allItems = state.allItems;

      var repo = ref.read(profileRepoProvider);
      var items = await getApiV1ProfilesSkillsUseCase(repo: repo, query: query);

      for (var e in items) {
        if (allItems.contains(e)) continue;
        allItems.add(e);
      }

      this.state = AsyncData(state.copyWith(items: items, allItems: allItems));
    } catch (e) {
      state = AsyncData(state.value!);
    }
  }

  void isSearch(bool value) {
    state = AsyncData(state.value!.copyWith(isSearch: value));
  }

  Future<void> resetSearchData(List<String> value) async {
    var state = await future;

    this.state = AsyncData(
      state.copyWith(isSearch: true, selected: value, items: state.allItems),
    );
  }

  void addSelected(String uuid) {
    var selected = state.value!.selected;
    selected.add(uuid);
    state = AsyncData(state.value!.copyWith(selected: selected));
  }

  void removeSelected(String uuid) {
    var selected = state.value!.selected;
    selected.remove(uuid);
    state = AsyncData(state.value!.copyWith(selected: selected));
  }
}

class SkillState {
  final bool isSearch;
  final List<String> selected;
  final List<SkillOut> items;
  final List<SkillOut> allItems;

  SkillState({
    required this.items,
    required this.allItems,
    required this.isSearch,
    required this.selected,
  });

  factory SkillState.init() {
    return SkillState(items: [], allItems: [], isSearch: true, selected: []);
  }

  SkillState copyWith({
    bool? isSearch,
    List<String>? selected,
    List<SkillOut>? items,
    List<SkillOut>? allItems,
  }) {
    return SkillState(
      isSearch: isSearch ?? this.isSearch,
      selected: selected ?? this.selected,
      items: items ?? this.items,
      allItems: allItems ?? this.allItems,
    );
  }
}
