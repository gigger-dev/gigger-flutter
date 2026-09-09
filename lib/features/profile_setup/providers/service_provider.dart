import 'package:mobile_gigger_app/features/profile/data/profile_provider.dart';
import 'package:mobile_gigger_app/features/profile/domain/profile_use_case.dart';
import 'package:mobile_gigger_app/models/my_services_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_provider.g.dart';

@Riverpod(keepAlive: true)
class Service extends _$Service {
  @override
  Future<ServiceState> build() async {
    var s = ServiceState.init();

    try {
      var repo = ref.read(profileRepoProvider);
      var items = await getApiV1ProfilesServicesUseCase(repo: repo);
      return s.copyWith(items: items, allItems: items);
    } catch (_) {
      return s;
    }
  }

  Future<void> search(String query) async {
    try {
      if (query.isEmpty) {
        state = AsyncData(state.value!);
        return;
      }
      // state = const AsyncLoading();

      var allItems = state.value!.allItems;

      var repo = ref.read(profileRepoProvider);
      var items =
          await getApiV1ProfilesServicesUseCase(query: query, repo: repo);

      for (var e in items) {
        if (allItems.contains(e)) continue;
        allItems.add(e);
      }

      state = AsyncData(state.value!.copyWith(
        items: items,
        allItems: allItems,
      ));
    } catch (e) {
      state = AsyncData(state.value!);
    }
  }

  void isSearch(bool value) {
    state = AsyncData(state.value!.copyWith(isSearch: value));
  }

  void resetSearchData(List<String> value) {
    state = AsyncData(state.value!.copyWith(
      isSearch: true,
      selected: value,
      items: state.value?.allItems,
    ));
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

class ServiceState {
  final bool isSearch;
  final List<String> selected;
  final List<MyServicesOut> items;
  final List<MyServicesOut> allItems;

  ServiceState({
    required this.items,
    required this.allItems,
    required this.isSearch,
    required this.selected,
  });

  factory ServiceState.init() {
    return ServiceState(
      items: [],
      allItems: [],
      selected: [],
      isSearch: true,
    );
  }

  ServiceState copyWith({
    bool? isSearch,
    List<String>? selected,
    List<MyServicesOut>? items,
    List<MyServicesOut>? allItems,
  }) {
    return ServiceState(
      isSearch: isSearch ?? this.isSearch,
      selected: selected ?? this.selected,
      items: items ?? this.items,
      allItems: allItems ?? this.allItems,
    );
  }
}
