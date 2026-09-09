import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/helpers/dialog_helper.dart';
import 'package:mobile_gigger_app/core/helpers/event_helper.dart';
import 'package:mobile_gigger_app/core/helpers/notification_helper.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/date_format.dart';
import 'package:mobile_gigger_app/core/utils/duration_ago.dart';
import 'package:mobile_gigger_app/core/utils/event_isolate_api.dart';
import 'package:mobile_gigger_app/core/utils/get_location_data.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/core/utils/size_utils.dart';
import 'package:mobile_gigger_app/features/draft/providers/event_draft_controller.dart';
import 'package:mobile_gigger_app/features/event_form/providers/event_form_controller.dart';
import 'package:mobile_gigger_app/features/event_form/providers/line_up_controller.dart';
import 'package:mobile_gigger_app/features/event_form/widgets/call_to_action_btn.dart';
import 'package:mobile_gigger_app/features/event_form/widgets/contact_list_widget.dart';
import 'package:mobile_gigger_app/features/event_form/widgets/line_up_widget.dart';
import 'package:mobile_gigger_app/features/event_form/widgets/select_reminder_sheet.dart';
import 'package:mobile_gigger_app/features/event_form/widgets/thumbnail_info.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/post_form_screen.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/hashtag_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/hashtag_box.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/social_list_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/models/account_fewer_details_out.dart';
import 'package:mobile_gigger_app/models/call_to_action.dart';
import 'package:mobile_gigger_app/models/event_in.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:mobile_gigger_app/models/hash_tag.dart';
import 'package:mobile_gigger_app/models/line_up_and_performer_in.dart';
import 'package:mobile_gigger_app/models/line_up_and_performer_out.dart';
import 'package:mobile_gigger_app/models/location_out.dart';
import 'package:mobile_gigger_app/models/profile_fewer_details_out.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/hashtag/hashtag_regular_expression.dart';
import 'package:mobile_gigger_app/widgets/outlined_btn.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class EventFormScreen extends ConsumerStatefulWidget {
  const EventFormScreen({super.key, this.data});

  final EventOut? data;

  @override
  ConsumerState<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends ConsumerState<EventFormScreen> {
  final formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final genre = TextEditingController();
  final venue = TextEditingController();
  final hashtag = TextEditingController();
  final location = TextEditingController();
  final description = TextEditingController();
  final ticketPrice = TextEditingController();
  final onlineEventLink = TextEditingController();

  @override
  void initState() {
    super.initState();

    var data = widget.data;

    if (data != null) {
      name.text = data.name;
      genre.text = data.genre;
      location.text = data.location;
      description.text = data.description;
      ticketPrice.text = '${data.ticketPrice}';
      onlineEventLink.text = data.onlineEventLink ?? '';

      if (data.hashtags.isNotEmpty) {
        hashtag.text = data.hashtags.map((e) => '#${e.name}').join(' ');
      }

      Future.delayed(Duration.zero, () {
        ref.read(eventFormControllerProvider.notifier).setData(data);
      });
    } else if (kDebugMode) {
      name.text = 'Name';
      genre.text = 'Genre';
      ticketPrice.text = '100';
      description.text = 'Description';
    }

    requestPermission();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> requestPermission() async {
    var hasPermissions = await EventHelper.hasPermissions();
    if (!hasPermissions) EventHelper.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(eventFormControllerProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) showConfirmSheet(state);
      },
      child: Scaffold(
        backgroundColor: colorBlack,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: InkWell(
            onTap: () => showConfirmSheet(state),
            child: Transform.scale(
              scale: 0.3,
              child: SizedBox(
                child: Image.asset(
                  Assets.images.closeIcon.path,
                  color: colorWhite,
                ),
              ),
            ),
          ),
        ),
        body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextViewWidget(
                  text: 'CREATE\nYOUR EVENT',
                  textSize: 30,
                  color: colorWhite,
                  height: 1,
                ),
              ),
              const SizedBox(height: 50),
              ThumbnailInfo(),
              PostTextBox(
                maxLines: 6,
                controller: name,
                hintText: 'Event name ...',
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBox(height: 24),
              PostTextBox(
                maxLines: 6,
                controller: description,
                hintText: 'Describe your event ...',
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBox(height: 24),
              PostTextBox(
                required: false,
                controller: genre,
                hintText: 'Music genre (if needed) ...',
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: PostTextBox(
                      readOnly: true,
                      required: false,
                      controller: location,
                      hintText: 'Location',
                      textCapitalization: TextCapitalization.sentences,
                      onTap: () async {
                        var r = await SheetUtils.placeSheet(
                          context,
                          lat: state.lat,
                          long: state.long,
                          // showSelector: false,
                        );
                        if (r == null) return;

                        ref
                            .read(eventFormControllerProvider.notifier)
                            .latLng(r.latLng);

                        location.text = getLocationData(r.placemark);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextViewWidget(text: 'and/or', textSize: 12.sp),
                  ),
                  Expanded(
                    flex: 2,
                    child: PostTextBox(
                      required: false,
                      controller: onlineEventLink,
                      hintText: 'link for remote ...',
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              HashtagBox(
                controller: hashtag,
                title: '# Add Hashtags (at least one)',
                onSelected:
                    ref.read(eventFormControllerProvider.notifier).hashTag,
              ),
              SizedBox(height: 24),
              PostTextBox(
                required: false,
                controller: venue,
                textCapitalization: TextCapitalization.sentences,
                hintText: 'Tag a @Venue (eg. who hosts the event) ...',
              ),
              SizedBox(height: 24),
              PostTextBox(
                readOnly: true,
                hintText: 'Date and time',
                controller: TextEditingController(
                  text: eventDateFormat(state.startTime, state.endTime),
                ),
                textCapitalization: TextCapitalization.sentences,
                onTap: () async {
                  var result = await DateTimePickerRoute(
                    endTime: state.endTime,
                    firstDay: DateTime.now(),
                    startTime: state.startTime,
                    initialSelectedDate: state.startTime ?? DateTime.now(),
                  ).push<List>(context);

                  if (result == null) return;

                  ref.read(eventFormControllerProvider.notifier).setDateData(
                        result[1] as DateTime,
                        result[2] as DateTime,
                      );
                },
              ),
              SizedBox(height: 24),
              PostTextBox(
                required: false,
                controller: ticketPrice,
                keyboardType: TextInputType.number,
                hintText: 'Ticket price (if needed) ...',
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBox(height: 34),
              CallToActionBtn(),
              SizedBox(height: 24),
              PostListTile(
                isDisable: true,
                title: 'Membership Content',
                value: state.isMembershipContent,
                subtitle: 'Select or create a new one',
                onChanged: (v) {
                  ref
                      .read(eventFormControllerProvider.notifier)
                      .isMembershipContent(v);
                },
              ),
              SizedBox(height: 24),
              PostListTile(
                title: 'Add Reminder',
                subtitle: state.reminder == null
                    ? 'Add a reminder for your event'
                    : '"${durationAgo(state.reminder!)} before" added.',
                onTap: () async {
                  var reminder = await SheetUtils.showSimpleSheet<Duration>(
                    context: context,
                    isScrollControlled: true,
                    child: SelectReminderSheet(duration: state.reminder),
                  );

                  if (reminder == null) return;

                  ref
                      .read(eventFormControllerProvider.notifier)
                      .reminder(reminder);
                },
              ),
              SizedBox(height: 24),
              LineUpWidget(),
              SizedBox(height: 28),
              PostListTile(
                isDisable: true,
                title: 'Payments',
                subtitle: 'Set up payment for the lineup',
              ),
              SizedBox(height: 28),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.edit),
                title: TextViewWidget(
                  text: 'Add Business partner(s) / Sponsor(s)',
                  textSize: SizeUtils.textSizeExtraSmall,
                  color: colorTextGrey,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: TextViewWidget(
                  text: 'Show contacts',
                  textSize: SizeUtils.textSizeExtraSmall,
                  color: Colors.white,
                ),
                subtitle: TextViewWidget(
                  text: 'Tap and select (the ones inserted on Gigger)',
                  color: Colors.grey,
                  textSize: 11,
                ),
              ),
              const SizedBox(height: 15),
              const ContactListWidget(),
              SizedBox(height: 20),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: TextViewWidget(
                  text: 'Social links related to this event',
                  textSize: SizeUtils.textSizeExtraSmall,
                  color: Colors.white,
                ),
                subtitle: TextViewWidget(
                  text: 'Tap and insert related link to any selected',
                  color: Colors.grey,
                  textSize: 11,
                ),
              ),
              const SizedBox(height: 15),
              const SocialListWidget(),
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.data != null
                        ? SizedBox()
                        : TextButton(
                            onPressed: () => onSaveAsDraft(state),
                            child: const Text(
                              'Save as Draft',
                              style: TextStyle(
                                color: colorTextRed,
                                fontSize: SizeUtils.textSizeExtraSmall,
                              ),
                            ),
                          ),
                    GradientFilledButton(
                      title: 'Publish',
                      onPressed: () => onPublish(state),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showConfirmSheet(EventFormState state) async {
    var result = await SheetUtils.showSimpleSheet<bool>(
      context: context,
      child: ConfirmSheet(
        isUpdate: widget.data != null,
        onSaveDraft: () => onSaveAsDraft(state),
      ),
    );

    if (result != true) return;
    if (!mounted) return;

    ref.read(eventFormControllerProvider.notifier).clear();

    context.pop();
  }

  bool validate(EventFormState state) {
    if (!formKey.currentState!.validate()) return false;

    if (state.thumbnailFile == null && state.thumbnailUrl == null) {
      Toast.error('Select Media');
      return false;
    }

    return true;
  }

  List<HashTag> getHashTags(List<HashTag> hashTags) {
    var hashtagAll = ref.read(hashtagAllControllerProvider);

    var tags = List<HashTag>.from(hashTags);

    var rawTags = extractHashTags(hashtag.text.trim());

    for (var e in rawTags) {
      var d = e.replaceFirst('#', '').trim();
      if (tags.any((t) => t.name == d)) continue;

      var uuid = hashtagAll.where((e) => e.name == d).firstOrNull?.uuid;
      tags.add(HashTag(name: d, uuid: uuid));
    }

    return tags;
  }

  Future<void> onPublish(EventFormState state) async {
    var isValidate = validate(state);
    if (!isValidate) return;

    var tags = getHashTags(state.hashtags);

    if (mounted) DialogHelper.showOverlay(context);

    var profileUuid = ref.read(profileControllerProvider).value!.uuid;

    try {
      var model = EventIn(
        hashtags: tags,
        currency: 'EUR',
        locationLat: state.lat,
        locationLon: state.long,
        name: name.text.trim(),
        genre: genre.text.trim(),
        profileUuid: profileUuid,
        contacts: state.contacts,
        location: location.text.trim(),
        socialLinks: state.socialLinks,
        endTime: state.endTime!.toUtc(),
        startTime: state.startTime!.toUtc(),
        description: description.text.trim(),
        videoOrImageUrl: state.videoUrl ?? '',
        thumbnailUrl: state.thumbnailUrl ?? '',
        lineUpNPerformers: state.lineUpNPerformers,
        onlineEventLink: onlineEventLink.text.trim(),
        isMembershipContent: state.isMembershipContent,
        ticketPrice: double.tryParse(ticketPrice.text.trim()) ?? 0,
        callToAction:
            state.callToAction ?? CallToAction(name: 'None', value: ''),
      );

      var data = model.toJson();
      if (widget.data != null) {
        data[state.isDraft ? 'draft_uuid' : 'uuid'] = widget.data!.uuid;
      }

      data['thumbnailFile'] = state.thumbnailFile;
      data['pickVideoFile'] = state.pickVideoFile?.path;
      data['call_to_action'] = model.callToAction.toJson();

      data['line_up_n_performers'] =
          model.lineUpNPerformers.map((e) => e.toJson()).toList();
      data['hashtags'] = tags.map((e) => e.toJson()).toList();

      var add = <LineUpAndPerformerIn>[];
      var remove = <LineUpAndPerformerIn>[];

      for (var e in model.lineUpNPerformers) {
        if (state.dataLineUpNPerformers
            .any((m) => m.profileUuid == e.profileUuid)) {
          continue;
        }

        add.add(e);
      }

      for (var e in state.dataLineUpNPerformers) {
        if (model.lineUpNPerformers
            .any((m) => m.profileUuid == e.profileUuid)) {
          continue;
        }

        remove.add(e);
      }

      data['line_up_n_performers_to_add'] = add;
      data['line_up_n_performers_to_remove'] = remove;

      // log('model: ${model.lineUpNPerformers.map((e) => e.profileUuid).toList()}');
      // log('data: ${state.dataLineUpNPerformers.map((e) => e.profileUuid).toList()}');
      // log('add: ${add.length}');
      // log('remove: ${remove.length}');

      // return;

      await isolateCallBack(data);

      if (state.isDraft) {
        ref
            .read(eventDraftControllerProvider.notifier)
            .delete(data['draft_uuid']);
      }

      // if (isGranted) {
      //   var calendarId = await getCalendar();
      //   await createEvent(calendarId, state);
      // }

      if (!mounted) return;
      DialogHelper.hideLoading(context);

      ref.read(eventFormControllerProvider.notifier).clear();

      Toast.warning(
        'Event ${widget.data != null && !state.isDraft ? 'Updating' : 'Publishing'}',
      );

      context.pop();
    } catch (e, _) {
      DialogHelper.hideLoading(context);
      Toast.error(e.toString());
    }
  }

  Future<void> onSaveAsDraft(EventFormState state) async {
    try {
      var isValidate = validate(state);
      if (!isValidate) {
        await Toast.error(
          'Please fill all required fields',
          gravity: ToastGravity.CENTER,
        );
        return;
      }

      var profileUuid = ref.read(profileControllerProvider).value!.uuid;

      var linups = ref.read(lineUpControllerProvider);

      await ref.read(eventDraftControllerProvider.notifier).save(
            EventOut(
              locationLat: 0,
              locationLon: 0,
              currency: 'EUR',
              name: name.text.trim(),
              genre: genre.text.trim(),
              profileUuid: profileUuid,
              contacts: state.contacts,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              location: location.text.trim(),
              socialLinks: state.socialLinks,
              endTime: state.endTime!.toUtc(),
              startTime: state.startTime!.toUtc(),
              description: description.text.trim(),
              hashtags: getHashTags(state.hashtags),
              uuid: widget.data?.uuid ?? Uuid().v1(),
              thumbnailUrl: state.thumbnailFile ?? '',
              onlineEventLink: onlineEventLink.text.trim(),
              isMembershipContent: state.isMembershipContent,
              videoOrImageUrl: state.pickVideoFile?.path ?? '',
              ticketPrice: double.tryParse(ticketPrice.text.trim()) ?? 0,
              callToAction:
                  state.callToAction ?? CallToAction(name: 'None', value: ''),
              lineUpNPerformersOut: linups.map((e) {
                return LineUpAndPerformerOut(
                  id: 0,
                  eventUuid: '',
                  isAccepted: false,
                  endTime: e.to!,
                  startTime: e.from!,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  profileUuid: e.uuid,
                  profile: ProfileFewerDetailsOut(
                    uuid: '',
                    coverMedia: '',
                    accountUuid: '',
                    avatarMedia: e.profile,
                    isPrivateProfile: false,
                    account:
                        AccountFewerDetailsOut(username: e.title, uuid: ''),
                    location: LocationOut(
                      city: '',
                      uuid: '',
                      state: '',
                      country: '',
                      address: e.address,
                    ),
                  ),
                );
              }).toList(),
            ),
          );

      ref.read(eventFormControllerProvider.notifier).clear();

      Toast.success('Event Saved as Draft Successfully');

      if (!mounted) return;

      context.pop(true);
    } catch (e) {
      Toast.error('Something went wrong');
    }
  }
}

Future<void> isolateCallBack(Map<String, dynamic> data, [int? id]) async {
  final receivePort = ReceivePort();
  data['sendPort'] = receivePort.sendPort;
  data['rootIsolateToken'] = RootIsolateToken.instance!;

  await Isolate.spawn(eventIsolateAPI, data);

  final sendPort = await receivePort.first as SendPort;
  final responsePort = ReceivePort();

  var _id = id ?? Uuid().v4().hashCode;

  var body = data['name'];

  try {
    sendPort.send({'responsePort': responsePort.sendPort});

    bool isClosed = false;

    await NotificationHelper.showProgress(
      id: _id,
      title: 'Gigger',
      progress: 0,
      body: '$body uploading...',
    );

    responsePort.listen(
      (progress) async {
        if (isClosed) return;

        if (progress is double) {
          if (progress == 1.0) {
            await NotificationHelper.showDone(
              id: _id,
              title: 'Gigger',
              body: '$body upload successfully',
            );

            isClosed = true;
            responsePort.close();
            return;
          }

          if (progress == -1.0) {
            await NotificationHelper.showError(
              id: _id,
              title: 'Gigger',
              body: '$body upload failed',
              payload: jsonEncode(data
                ..remove('sendPort')
                ..remove('rootIsolateToken')),
            );

            isClosed = true;
            responsePort.close();
            return;
          }

          await NotificationHelper.showProgress(
            id: _id,
            title: 'Gigger',
            progress: progress,
            body: '$body uploading...',
          );
        }

        // if (progress == 'done') {
        //   await NotificationHelper.showDone(
        //     id: _id,
        //     title: 'Gigger',
        //     body: '$body upload successfully',
        //   );

        //   responsePort.close();
        // }

        // if (progress == 'error') {
        //   await NotificationHelper.showError(
        //     id: _id,
        //     title: 'Gigger',
        //     body: '$body upload failed',
        //     payload: jsonEncode(data
        //       ..remove('sendPort')
        //       ..remove('rootIsolateToken')),
        //   );

        //   responsePort.close();
        // }
      },
      // onDone: () => NotificationHelper.showDone(
      //   id: _id,
      //   title: 'Gigger',
      //   body: '$body upload successfully',
      // ),
      // onError: (e) async {
      //   await NotificationHelper.showError(
      //     id: _id,
      //     title: 'Gigger',
      //     body: '$body upload failed',
      //     payload: jsonEncode(data
      //       ..remove('sendPort')
      //       ..remove('rootIsolateToken')),
      //   );
      // },
    );
  } catch (e) {
    await NotificationHelper.showError(
      id: _id,
      title: 'Gigger',
      body: '$body upload failed',
      payload: jsonEncode(data
        ..remove('sendPort')
        ..remove('rootIsolateToken')),
    );
    responsePort.close();
  }
}

class ConfirmSheet extends StatelessWidget {
  const ConfirmSheet({
    super.key,
    required this.onSaveDraft,
    required this.isUpdate,
  });

  final bool isUpdate;
  final VoidCallback onSaveDraft;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextViewWidget(
            text: 'YOU ARE EXITING THE EDITOR',
            textSize: 28.sp,
            height: 1,
          ),
          const SizedBox(height: 14),
          TextViewWidget(
            text:
                'You will lose all the information entered.\nPlease complete it or save a draft.',
            textSize: 14.sp,
          ),
          const SizedBox(height: 40),
          if (isUpdate) ...[
            OutlinedBtn(
              onPressed: () => context.pop(true),
              text: 'Exit the editor',
            ),
            const SizedBox(height: 4),
            GradientFilledButton(
              title: 'Continue to edit',
              onPressed: () => context.pop(false),
            ),
          ] else ...[
            OutlinedBtn(onPressed: onSaveDraft, text: 'Save Draft & Exit'),
            const SizedBox(height: 8),
            GradientFilledButton(
              title: 'Continue editing',
              onPressed: () => context.pop(false),
            ),
            const SizedBox(height: 18),
            CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.zero,
              onPressed: () => context.pop(true),
              child: Center(
                child: TextViewWidget(text: 'Exit & Discard', textSize: 12.sp),
              ),
            )
          ],
        ],
      ),
    );
  }
}
