import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/models/availability_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile_gigger_app/core/extension/date_extension.dart';

part 'availability_controller.g.dart';

@Riverpod(keepAlive: true)
class AvailabilityController extends _$AvailabilityController {
  @override
  AvailabilityState build() => AvailabilityState.init();

  void removeDay(int e) {
    state = state.copyWith(selected: state.selected..remove(e));
  }

  void addDay(int day) {
    var selected = state.selected;
    selected[day] = [];

    var items = state.items.where((e) => e.day == day);
    for (var e in items) {
      var time = TimeRange(
        isNew: false,
        from: DateFormat('HH:mm:00').parse(e.startTime),
        to: DateFormat('HH:mm:00').parse(e.endTime),
      );

      var isContain = selected[day]!.where((e) {
        return e.from!.isAtSameMomentAs(time.from!) &&
            e.to!.isAtSameMomentAs(time.to!);
      }).isNotEmpty;

      if (isContain) continue;

      selected[day]!.add(time);
    }

    state = state.copyWith(selected: selected);
  }

  DateTime? _dateFormat(DateTime? date) {
    if (date == null) return null;

    var format = DateFormat('HH:mm:00');

    return format.parse(format.format(date));
  }

  void setTime({
    required int index,
    DateTime? from,
    DateTime? to,
  }) {
    var selected = state.selected;

    for (var e in selected.entries) {
      var times = selected[e.key] ?? [];

      var index = times.lastIndexWhere((e) {
        return (_dateFormat(from) == _dateFormat(e.from) || from == null) ||
            (_dateFormat(to) == _dateFormat(e.to) || to == null);
      });

      if (index == -1) continue;

      times[index] = times[index].copyWith(from: from, to: to);

      selected[e.key] = times;
    }

    state = state.copyWith(selected: selected);
  }

  void removeTime(TimeRange data) {
    var selected = state.selected;

    for (var e in selected.entries) {
      e.value.remove(data);
    }

    state = state.copyWith(selected: selected);
  }

  void addTime() {
    var selected = state.selected;

    for (var e in selected.entries) {
      selected[e.key] ??= [];
      selected[e.key]!.add(TimeRange());
    }

    state = state.copyWith(selected: selected);
  }

  void clearDays() {
    state = state.copyWith(selected: {});
  }

  void cancel() {
    state = state.copyWith(selected: {});
  }

  void remove(AvailabilityOut data) {
    var items = List<AvailabilityOut>.from(state.items);
    items.remove(data);
    state = state.copyWith(items: items);
  }

  void save() {
    var items = [...state.items];

    for (var e in state.selected.entries) {
      for (var t in state.selectedTimes) {
        var data = AvailabilityOut(
          day: e.key,
          startTime: DateFormat('HH:mm:00').tryFormat(t.from) ?? '',
          endTime: DateFormat('HH:mm:00').tryFormat(t.to) ?? '',
        );

        if (items.any((e) =>
            e.day == data.day &&
            e.startTime == data.startTime &&
            e.endTime == data.endTime)) {
          continue;
        }

        items.add(data);
      }
    }

    state = state.copyWith(items: items, selected: {});

    // var days = <int>{...state.days, ...state.selectedDays}.toList();

    // state = state.copyWith(items: items, days: days, selectedDays: []);
  }

  void addItem(List<AvailabilityOut> availability) {
    if (state.items.isEmpty) state = state.copyWith(items: availability);
  }

  void addData(List<AvailabilityOut>? items) {
    if (items == null) {
      state = state.copyWith(selected: {});
      return;
    }

    state = state.copyWith(items: items);
  }

  void resetData(List<AvailabilityOut> availability) {
    state = state.copyWith(items: availability, selected: {});
  }

  void setItemData() => addData(state.items);
}

class AvailabilityState {
  final Map<int, List<TimeRange>> selected;
  final List<AvailabilityOut> items;

  AvailabilityState({
    required this.items,
    required this.selected,
  });

  List<TimeRange> get selectedTimes {
    var d = selected.values.expand((e) => e).toSet().toList();
    d.sort((a, b) {
      if (a.from == null || a.to == null) return 1;
      if (b.from == null || b.to == null) return 0;
      return a.from!.compareTo(b.from!);
    });
    return d;
  }

  factory AvailabilityState.init() {
    return AvailabilityState(items: [], selected: {});
  }

  AvailabilityState copyWith({
    Map<int, List<TimeRange>>? selected,
    List<AvailabilityOut>? items,
  }) {
    return AvailabilityState(
      selected: selected ?? this.selected,
      items: items ?? this.items,
    );
  }
}

class TimeRange {
  final DateTime? from;
  final DateTime? to;
  final bool isNew;

  TimeRange({
    this.from,
    this.to,
    this.isNew = true,
  });

  TimeRange copyWith({
    DateTime? from,
    DateTime? to,
    bool? isNew,
  }) {
    return TimeRange(
      from: from ?? this.from,
      to: to ?? this.to,
      isNew: isNew ?? this.isNew,
    );
  }

  @override
  int get hashCode => from.hashCode ^ to.hashCode ^ isNew.hashCode;

  @override
  bool operator ==(covariant TimeRange other) {
    if (identical(this, other)) return true;

    return other.from == from && other.to == to && other.isNew == isNew;
  }
}
