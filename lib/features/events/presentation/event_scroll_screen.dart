import 'dart:async';

import 'package:flutter/material.dart' hide PageScrollPhysics;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/features/events/presentation/event_screen.dart';
import 'package:mobile_gigger_app/features/home/providers/event_controller.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:preload_page_view/preload_page_view.dart';

class EventScrollScreen extends ConsumerStatefulWidget {
  const EventScrollScreen({
    super.key,
    required this.index,
    this.items,
    this.uuid,
  });

  final int index;
  final String? uuid;
  final List<EventOut>? items;

  @override
  ConsumerState<EventScrollScreen> createState() => _EventScrollScreenState();
}

class _EventScrollScreenState extends ConsumerState<EventScrollScreen> {
  PreloadPageController? controller;

  @override
  void initState() {
    super.initState();
    if (widget.uuid == null) {
      controller = PreloadPageController(initialPage: widget.index);
    } else {
      Future.delayed(Duration.zero, () => setItem(widget.uuid!));
    }
  }

  Future<void> setItem(String uuid) async {
    var index = await ref.read(eventControllerProvider.notifier).getById(uuid);
    if (index == null) return;

    controller = PreloadPageController(initialPage: index);
    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items != null) {
      return Scaffold(body: buildPageView(widget.items!));
    }

    var state = ref.watch(eventControllerProvider);

    return Scaffold(
      body: state.when(
        loading: () => CircularLoading(),
        data: (data) => buildPageView(data.items),
        error: (error, _) => TextViewWidget(text: '$error'),
      ),
    );
  }

  Widget buildPageView(List<EventOut> items) {
    if (controller == null) return CircularLoading();

    return PreloadPageView.builder(
      controller: controller,
      itemCount: items.length,
      physics: PageScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return EventScreen(data: items[index]);
      },
    );
  }
}
