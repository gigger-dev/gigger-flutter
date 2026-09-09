import 'package:mobile_gigger_app/features/profile/data/profile_provider.dart';
import 'package:mobile_gigger_app/features/profile/domain/profile_use_case.dart';
import 'package:mobile_gigger_app/models/interest_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interest_provider.g.dart';

@Riverpod(keepAlive: true)
class Interest extends _$Interest {
  @override
  Future<InterestState> build() async {
    var s = InterestState.init();

    try {
      var repo = ref.read(profileRepoProvider);
      var r = await getApiV1ProfilesInterestsUseCase(repo: repo);
      s = s.copyWith(interestList: r);
    } catch (_) {}

    return s;
  }

  Future<void> search(String query) async {
    var state = await future;

    var r = await getApiV1ProfilesInterestsUseCase(
      query: query,
      repo: ref.read(profileRepoProvider),
    );

    this.state = AsyncData(state.copyWith(searchResultList: r));
    try {} catch (_) {}
  }

  void removeInterestSelect(InterestOut data) {
    var value = state.value!;
    value.selectedList.remove(data);
    state = AsyncData(value);
  }

  void addInterestSelect(InterestOut data) {
    var value = state.value!;
    value.selectedList.add(data);
    state = AsyncData(value);
  }

  Future<void> setSelectedList(List<InterestOut> data) async {
    var state = await future;
    state.selectedList = data;
    this.state = AsyncData(state);
  }

  void addSearch(InterestOut data) {
    var value = state.value!;
    value.searchList.add(data);
    state = AsyncData(value);
  }

  void removeSearch(InterestOut data) {
    var value = state.value!;
    value.searchList.remove(data);
    state = AsyncData(value);
  }

  void clearSearch() {
    var value = state.value!;
    value.searchList.clear();
    state = AsyncData(value);
  }

  void reset() {
    var value = state.value!;
    state = AsyncData(
      InterestState.init().copyWith(interestList: value.interestList),
    );
  }
}

class InterestState {
  bool loading;
  List<InterestOut> selectedList;
  List<InterestOut> interestList;
  List<InterestOut> searchList;
  List<InterestOut> searchResultList;

  InterestState({
    required this.loading,
    required this.selectedList,
    required this.interestList,
    required this.searchList,
    required this.searchResultList,
  });

  factory InterestState.init() {
    return InterestState(
      loading: false,
      selectedList: [],
      interestList: [],
      searchList: [],
      searchResultList: [],
    );
  }

  InterestState copyWith({
    bool? loading,
    List<InterestOut>? selectedList,
    List<InterestOut>? interestList,
    List<InterestOut>? searchList,
    List<InterestOut>? searchResultList,
  }) {
    return InterestState(
      loading: loading ?? this.loading,
      selectedList: selectedList ?? this.selectedList,
      interestList: interestList ?? this.interestList,
      searchList: searchList ?? this.searchList,
      searchResultList: searchResultList ?? this.searchResultList,
    );
  }
}
