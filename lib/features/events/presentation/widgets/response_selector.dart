import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/helpers/dialog_helper.dart';
import 'package:mobile_gigger_app/features/home/providers/event_metadata_controller.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/filters/service_filter_widget.dart';

class ResponseSelector extends ConsumerWidget {
  final String eventUuid;
  final String viewerUuid;

  const ResponseSelector({
    super.key,
    required this.eventUuid,
    required this.viewerUuid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var metadata = ref
        .watch(eventMetadataControllerProvider(
          eventUuid: eventUuid,
          viewerUuid: viewerUuid,
        ))
        .valueOrNull;

    if (metadata == null) return SizedBox();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SelectorWidget(
        value: getResponseName(metadata.responseType),
        items: const ['Going', 'Maybe', 'Interested'],
        onChanged: (v) => onChanged(v, ref, context),
      ),
    );
  }

  Future<void> onChanged(String v, WidgetRef ref, BuildContext context) async {
    DialogHelper.showOverlay(context);

    var provider = eventMetadataControllerProvider(
      eventUuid: eventUuid,
      viewerUuid: viewerUuid,
    );

    await ref.read(provider.notifier).response(response: getResponseNumber(v));

    if (!context.mounted) return;
    DialogHelper.hideLoading(context);
  }
}

String? getResponseName(int value) {
  return switch (value) {
    1 => 'Going',
    2 => 'Maybe',
    3 => 'Interested',
    int() => null,
  };
}

int getResponseNumber(String value) {
  return switch (value) {
    'Going' => 1,
    'Maybe' => 2,
    'Interested' => 3,
    String() => 2,
  };
}
