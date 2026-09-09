import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/event_form/providers/line_up_controller.dart';
import 'package:mobile_gigger_app/features/event_form/widgets/line_up_sheet.dart';
import 'package:mobile_gigger_app/features/home/providers/artist_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/search/controllers/gigger_search_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class LineUpListScreen extends ConsumerStatefulWidget {
  const LineUpListScreen({super.key});

  @override
  ConsumerState<LineUpListScreen> createState() => _LineUpListScreenState();
}

class _LineUpListScreenState extends ConsumerState<LineUpListScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).value!.cdnUrl;

    var selected = ref.watch(lineUpControllerProvider);
    var profileUuid = ref.watch(profileControllerProvider).value!.uuid;

    var artists = List<ProfileOut>.from(
      query.isEmpty
          ? ref.watch(artistControllerProvider).valueOrNull?.items ?? []
          : ref
                  .watch(giggerSearchControllerProvider(
                    username: query,
                    profileUuid: profileUuid,
                  ))
                  .valueOrNull
                  ?.items ??
              [],
    );

    artists.removeWhere((e) {
      return selected.any((s) => s.uuid == e.uuid && s.isDone) ||
          e.uuid == profileUuid;
    });

    return PopScope(
      onPopInvokedWithResult: (_, __) => Future.delayed(Duration.zero, () {
        ref.read(lineUpControllerProvider.notifier).reset();
      }),
      child: Scaffold(
        backgroundColor: colorBlack,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: colorBlack,
          title: TextViewWidget(text: 'Add Lineup and Performers'),
        ),
        body: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 20),
              children: [
                CustomExpansionTile(
                  title: 'Selected',
                  isPending: true,
                  items: selected.where((e) => e.isDone).toList(),
                  onRemove: ref.read(lineUpControllerProvider.notifier).remove,
                  onDateChanged: (uuid) async {
                    ref
                        .read(lineUpControllerProvider.notifier)
                        .checkMinMax(uuid);

                    await SheetUtils.showSimpleSheet(
                      context: context,
                      isScrollControlled: true,
                      child: LineUpSheet(uuid: uuid),
                    );
                  },
                ),
                SizedBox(height: 20),
                CustomExpansionTile(
                  title: 'Suggested for you',
                  items: artists.map((e) {
                    return TileItem(
                      profile: '$cdnUrl/${e.avatarMedia}',
                      title: e.account.username,
                      address: e.location.country,
                      uuid: e.uuid,
                    );
                  }).toList(),
                  onAdd: (value) async {
                    ref.read(lineUpControllerProvider.notifier).add(value);

                    await SheetUtils.showSimpleSheet(
                      context: context,
                      isScrollControlled: true,
                      child: LineUpSheet(uuid: value.uuid),
                    );

                    ref.read(lineUpControllerProvider.notifier).clean();
                  },
                ),
                SizedBox(height: .18.sh),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    stops: [.7, 1],
                    colors: [colorBlack, colorTransparent],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        onChanged: (value) {
                          query = value;
                          setState(() {});
                        },
                        onTapOutside: (_) => context.clearFocus(),
                        style: const TextStyle(fontSize: 12, color: colorWhite),
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Search user / band ...',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          hintStyle: TextStyle(color: colorWhite, fontSize: 12),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: colorWhite),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    GradientFilledButton(
                      title: 'Done',
                      onPressed: () {
                        ref
                            .read(lineUpControllerProvider.notifier)
                            .saveToEventForm();
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomExpansionTile<T> extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.title,
    this.isPending = false,
    required this.items,
    this.onAdd,
    this.onRemove,
    this.onDateChanged,
  });

  final String title;
  final bool isPending;
  final List<TileItem> items;
  final ValueChanged<TileItem>? onAdd;
  final ValueChanged<String>? onRemove;
  final ValueChanged<String>? onDateChanged;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        dense: true,
        initiallyExpanded: true,
        textColor: colorWhite,
        iconColor: colorWhite,
        collapsedTextColor: colorWhite,
        collapsedIconColor: colorWhite,
        title: TextViewWidget(text: title),
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var data = items[index];

              return ListTile(
                dense: true,
                leading: CircleAvatar(
                  radius: 16,
                  backgroundColor: colorGrey,
                  backgroundImage: CachedNetworkImageProvider(data.profile),
                ),
                title: TextViewWidget(text: data.title),
                subtitle: TextViewWidget(
                  text: data.address,
                  textSize: 12,
                  color: colorTextGrey,
                ),
                trailing: isPending
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CupertinoButton(
                            minSize: 30,
                            padding: EdgeInsets.zero,
                            onPressed: () => onDateChanged?.call(data.uuid),
                            child: Icon(
                              CupertinoIcons.clock,
                              color: colorWhite,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 10),
                          CupertinoButton(
                            minSize: 30,
                            padding: EdgeInsets.zero,
                            onPressed: () => onRemove?.call(data.uuid),
                            child: Icon(
                              CupertinoIcons.clear,
                              size: 20,
                              color: colorWhite,
                            ),
                          ),
                        ],
                      )
                    : CupertinoButton(
                        minSize: 0,
                        padding: EdgeInsets.zero,
                        onPressed: () => onAdd?.call(data),
                        child: TextViewWidget(
                          text: 'Add',
                          textSize: 13,
                          color: colorRed,
                        ),
                      ),
              );
            },
          )
        ],
      ),
    );
  }
}
