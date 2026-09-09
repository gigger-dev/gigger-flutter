import 'package:mobile_gigger_app/features/event_form/providers/event_form_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/line_up_and_performer_in.dart';
import 'package:mobile_gigger_app/models/line_up_and_performer_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'line_up_controller.g.dart';

@riverpod
class LineUpErrorController extends _$LineUpErrorController {
  @override
  String? build() => null;

  void update(String error) {
    state = error;
    ref.notifyListeners();
  }

  void clear() {
    state = null;
    ref.notifyListeners();
  }
}

@Riverpod(keepAlive: true)
class LineUpController extends _$LineUpController {
  @override
  List<TileItem> build() => [];

  void add(TileItem data) {
    var item = state.lastOrNull;
    if (item != null) {
      data.min = item.to;
      data.from = item.to;
    }

    state.add(data);
    ref.notifyListeners();
  }

  void remove(String uuid) {
    state.removeWhere((e) => e.uuid == uuid);
    ref.notifyListeners();
  }

  void clean() {
    state.removeWhere((e) => !e.isDone);
    ref.notifyListeners();
  }

  void from(String uuid, DateTime time) {
    var i = state.indexWhere((e) => e.uuid == uuid);

    state[i].from = time;
    state[i].to ??= time.add(Duration(minutes: 5));
    ref.notifyListeners();
  }

  void to(String uuid, DateTime time) {
    var i = state.indexWhere((e) => e.uuid == uuid);

    state[i].to = time;
    ref.notifyListeners();
  }

  void done() {
    for (var e in state) {
      e.isDone = true;
    }

    ref.notifyListeners();
  }

  void saveToEventForm() {
    var items = <LineUpAndPerformerIn>[];

    for (var e in state) {
      e.isSave = true;

      items.add(
        LineUpAndPerformerIn(
          profileUuid: e.uuid,
          startTime: e.from!,
          endTime: e.to!,
        ),
      );
    }

    ref.notifyListeners();

    ref.read(eventFormControllerProvider.notifier).lineUpNPerformers(items);
  }

  void reset() {
    state.removeWhere((e) => !e.isSave);
    ref.notifyListeners();
  }

  Future<void> items(List<LineUpAndPerformerOut> items) async {
    var config = await ref.read(configProvider.future);

    state = items.map((e) {
      return TileItem(
        isDone: true,
        isSave: true,
        uuid: e.profile.uuid,
        to: e.endTime.toLocal(),
        from: e.startTime.toLocal(),
        address: e.profile.location.city,
        title: e.profile.account.username,
        profile: '${config!.cdnUrl}/${e.profile.avatarMedia}',
      );
    }).toList();

    ref.notifyListeners();
  }

  void clear() {
    ref.invalidateSelf();
  }

  void checkMinMax(String uuid) {
    var i = state.indexWhere((e) => e.uuid == uuid);

    if (i != 0) {
      var prev = state[i - 1];
      state[i].min = prev.to;
    }

    if (i != state.length - 1) {
      var next = state[i + 1];
      state[i].max = next.from;
    }

    ref.notifyListeners();
  }
}

class TileItem {
  final String uuid;
  final String profile;
  final String title;
  final String address;
  bool isDone;
  bool isSave;
  DateTime? to;
  DateTime? min;
  DateTime? max;
  DateTime? from;

  TileItem({
    required this.uuid,
    required this.profile,
    required this.title,
    required this.address,
    this.isDone = false,
    this.isSave = false,
    this.min,
    this.max,
    this.from,
    this.to,
  });
}
