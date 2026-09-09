import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/features/giglist/giglist_screen.dart';
import 'package:mobile_gigger_app/features/giglist/providers/giglist_player_controller.dart';
import 'package:mobile_gigger_app/features/giglist/providers/giglist_scroll_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/recommended_giglist_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';

class GiglistScrollScreen extends ConsumerStatefulWidget {
  const GiglistScrollScreen({
    super.key,
    this.index,
    this.isVisitor,
    this.profileUuid,
    this.uuid,
    this.isFav,
  });

  final int? index;
  final String? uuid;
  final bool? isFav;
  final bool? isVisitor;
  final String? profileUuid;

  @override
  ConsumerState<GiglistScrollScreen> createState() =>
      _GiglistScrollScreenState();
}

class _GiglistScrollScreenState extends ConsumerState<GiglistScrollScreen> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    var index = widget.index ?? 0;
    controller = PageController(initialPage: index);
    if (widget.uuid != null) Future.delayed(Duration.zero, getIndex);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;

    var state = ref.watch(
      giglistScrollControllerProvider(
        profileUuid: widget.profileUuid,
        isVisitor: widget.isVisitor,
        isFav: widget.isFav ?? false,
      ),
    );

    return Scaffold(
      body: state.when(
        loading: () => CircularLoading(),
        error: (error, _) => Text('$error'),
        data: (data) => PageView.builder(
          itemCount: data.length,
          controller: controller,
          physics: PageScrollPhysics(),
          scrollDirection: Axis.vertical,
          onPageChanged: (value) {
            ref.read(giglistPlayerControllerProvider.notifier)
              ..current(0)
              ..isMore(false);
          },
          itemBuilder: (context, index) {
            return GiglistScreen(data[index], cdnUrl);
          },
        ),
      ),
    );
  }

  Future<void> getIndex() async {
    var index = await ref
        .read(recommendedGiglistControllerProvider.notifier)
        .getById(widget.uuid!);

    controller = PageController(initialPage: index);
  }
}
