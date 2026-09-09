import 'package:mobile_gigger_app/features/events/data/events_provider.dart';
import 'package:mobile_gigger_app/features/events/domain/events_use_case.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:mobile_gigger_app/models/paginated_response_event_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_controller.g.dart';

@Riverpod(keepAlive: true)
class EventController extends _$EventController {
  @override
  Future<PaginatedResponseEventOut> build() {
    return getApiV1EventsUseCase(repo: ref.read(eventsRepoProvider));
  }

  void refresh() {
    ref.invalidateSelf();
  }

  Future<void> updateData(EventOut r) async {
    var state = await future;

    var items = List<EventOut>.from(state.items);
    var index = items.indexWhere((e) => e.uuid == r.uuid);
    items[index] = r;
    this.state = AsyncData(state.copyWith(items: items));
  }

  Future<int?> getById(String uuid) async {
    try {
      var state = await future;
      var items = List<EventOut>.from(state.items);
      var index = items.indexWhere((e) => e.uuid == uuid);
      if (index != -1) return index;

      var r = await getApiV1EventsEventUuidUseCase(
        eventUuid: uuid,
        repo: ref.read(eventsRepoProvider),
      );
      this.state = AsyncData(state.copyWith(items: [r, ...items]));

      return 0;
    } catch (_) {
      return null;
    }
  }

  Future<void> insertItem(EventOut data) async {
    try {
      var state = await future;
      var items = List<EventOut>.from(state.items);
      var isExist = items.any((e) => e.uuid == data.uuid);
      if (isExist) return;

      this.state = AsyncData(state.copyWith(items: [data, ...items]));
    } catch (_) {
      return;
    }
  }

  Future<void> addItem(EventOut data) async {
    try {
      var state = await future;
      var items = List<EventOut>.from(state.items);
      var isExist = items.any((e) => e.uuid == data.uuid);
      if (isExist) return;

      this.state = AsyncData(state.copyWith(items: [...items, data]));
    } catch (_) {
      return;
    }
  }

  Future<void> accept({
    required String eventUuid,
    required String creatorUuid,
    required String performerUuid,
  }) async {
    try {
      var state = await future;
      var items = List<EventOut>.from(state.items);
      var index = items.indexWhere((e) => e.uuid == eventUuid);

      var r = await postApiV1EventsEventAcceptPerformerUuidUseCase(
        eventUuid: eventUuid,
        creatorUuid: creatorUuid,
        performerUuid: performerUuid,
        repo: ref.read(eventsRepoProvider),
      );
      items[index] = r;
      this.state = AsyncData(state.copyWith(items: items));
    } catch (_) {}
  }

  Future<void> reject({
    required String eventUuid,
    required String creatorUuid,
    required String performerUuid,
  }) async {
    try {
      var state = await future;
      var items = List<EventOut>.from(state.items);
      var index = items.indexWhere((e) => e.uuid == eventUuid);

      var r = await postApiV1EventsEventRejectPerformerUuidUseCase(
        eventUuid: eventUuid,
        creatorUuid: creatorUuid,
        performerUuid: performerUuid,
        repo: ref.read(eventsRepoProvider),
      );
      items[index] = r;
      this.state = AsyncData(state.copyWith(items: items));
    } catch (_) {}
  }
}
