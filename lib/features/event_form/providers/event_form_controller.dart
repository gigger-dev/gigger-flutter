import 'dart:io';

// ignore: depend_on_referenced_packages, implementation_imports
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:mobile_gigger_app/core/extension/call_to_action_extension.dart';
import 'package:mobile_gigger_app/features/event_form/providers/line_up_controller.dart';
import 'package:mobile_gigger_app/features/events/data/events_provider.dart';
import 'package:mobile_gigger_app/features/events/domain/events_use_case.dart';
import 'package:mobile_gigger_app/features/home/providers/event_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/self_event_controller.dart';
import 'package:mobile_gigger_app/models/call_to_action.dart';
import 'package:mobile_gigger_app/models/contact_out.dart';
import 'package:mobile_gigger_app/models/event_in.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:mobile_gigger_app/models/event_update.dart';
import 'package:mobile_gigger_app/models/hash_tag.dart';
import 'package:mobile_gigger_app/models/line_up_and_performer_in.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_form_controller.g.dart';

@Riverpod(keepAlive: true)
class EventFormController extends _$EventFormController {
  @override
  EventFormState build() => EventFormState();

  void thumbnailFile(String path) {
    state.thumbnailFile = path;
    ref.notifyListeners();
  }

  void isMembershipContent(bool v) {
    state.isMembershipContent = v;
    ref.notifyListeners();
  }

  void lineUpNPerformers(List<LineUpAndPerformerIn> v) {
    state.lineUpNPerformers = v;
    ref.notifyListeners();
  }

  void callToAction(
    String name,
    String url,
    String title,
    String desc,
    int groupValue,
  ) {
    CallToAction callToAction;

    if (groupValue == 0) {
      callToAction = CallToAction(name: 'None', value: '');
    } else if (groupValue == 7) {
      callToAction = CallToAction(name: title, value: desc);
    } else {
      callToAction = CallToAction(name: name, value: url);
    }

    state.callToAction = callToAction;
    ref.notifyListeners();
  }

  void setDateData(DateTime start, DateTime end) {
    state.startTime = start;
    state.endTime = end;
    ref.notifyListeners();
  }

  void clear() {
    ref.read(lineUpControllerProvider.notifier).clear();
    ref.invalidateSelf();
  }

  void videoData({
    required File video,
    required bool isHori,
    required File thumbnailImg,
  }) {
    state.isHori = isHori;
    state.pickVideoFile = video;
    state.thumbnailFile = thumbnailImg.path;
    ref.notifyListeners();
  }

  void selectSocial(String key) {
    var socialLinks = Map<String, String>.from(state.socialLinks);

    socialLinks.removeWhere((key, value) => value.isEmpty);

    if (!socialLinks.containsKey(key)) socialLinks[key] = '';

    state.socialLinks = socialLinks;
    state.selectSocial = key;

    ref.notifyListeners();
  }

  void socialLink(String key, String value) {
    var socialLinks = Map<String, String>.from(state.socialLinks);

    socialLinks[key] = value;

    state.socialLinks = socialLinks;
    ref.notifyListeners();
  }

  void hashtags(List<HashTag> hashtags) {
    state.hashtags = hashtags;
    ref.notifyListeners();
  }

  void setData(EventOut data) {
    state.contacts = data.contacts;
    state.hashtags = data.hashtags;
    state.socialLinks = data.socialLinks;
    state.thumbnailUrl = data.thumbnailUrl;
    state.endTime = data.endTime.toLocal();
    state.startTime = data.startTime.toLocal();
    state.isMembershipContent = data.isMembershipContent;

    if (data.callToAction.index != 0) {
      state.callToAction = data.callToAction;
    }

    if (data.thumbnailUrl != data.videoOrImageUrl) {
      state.videoUrl = data.videoOrImageUrl;
    }

    state.lineUpNPerformers = data.lineUpNPerformersOut.map((e) {
      return LineUpAndPerformerIn(
        profileUuid: e.profileUuid,
        endTime: e.endTime.toLocal(),
        startTime: e.startTime.toLocal(),
      );
    }).toList();
    state.dataLineUpNPerformers = state.lineUpNPerformers;

    ref
        .read(lineUpControllerProvider.notifier)
        .items(data.lineUpNPerformersOut);

    ref.notifyListeners();
  }

  Future<void> delete(String uuid) async {
    var r = await deleteApiV1EventsEventUuidUseCase(
      eventUuid: uuid,
      repo: ref.read(eventsRepoProvider),
    );

    Toast.success(r.message);
  }

  Future<void> create(EventIn body) async {
    await postApiV1EventsUseCase(
      body: body,
      repo: ref.read(eventsRepoProvider),
    );

    ref.read(selfEventControllerProvider.notifier).refresh();
    ref.read(eventControllerProvider.notifier).refresh();

    // await EventHelper.createEvent(
    //   name: body.name,
    //   eventId: r.uuid,
    //   location: body.location,
    //   endTime: state.endTime!,
    //   reminder: state.reminder,
    //   startTime: state.startTime!,
    //   description: body.description,
    // );

    // Toast.success('Event reminder added');
  }

  Future<void> update({
    required String uuid,
    String? videoUrl,
    String? thumbnailUrl,
    required EventIn data,
    required List<LineUpAndPerformerIn> lineUpNPerformersToAdd,
    required List<LineUpAndPerformerIn> lineUpNPerformersToRemove,
  }) async {
    var body = EventUpdate(
      name: data.name,
      genre: data.genre,
      endTime: data.endTime,
      contacts: data.contacts,
      currency: data.currency,
      location: data.location,
      hashtags: data.hashtags,
      startTime: data.startTime,
      description: data.description,
      locationLat: data.locationLat,
      locationLon: data.locationLon,
      socialLinks: data.socialLinks,
      ticketPrice: data.ticketPrice,
      callToAction: data.callToAction,
      onlineEventLink: data.onlineEventLink,
      isMembershipContent: data.isMembershipContent,
      lineUpNPerformersToAdd: lineUpNPerformersToAdd,
      thumbnailUrl: thumbnailUrl ?? data.thumbnailUrl,
      videoOrImageUrl: videoUrl ?? data.videoOrImageUrl,
      lineUpNPerformersToRemove: lineUpNPerformersToRemove,
    );

    var r = await patchApiV1EventsEventUuidUseCase(
      body: body,
      eventUuid: uuid,
      repo: ref.read(eventsRepoProvider),
    );

    ref.read(eventControllerProvider.notifier).updateData(r);
  }

  void reminder(Duration? duration) {
    state.reminder = duration;
    ref.notifyListeners();
  }

  void hashTag(HashTag hashTag) {
    if (state.hashtags
        .any((e) => e.uuid == hashTag.uuid || e.name == hashTag.name)) {
      return;
    }

    state.hashtags = [...state.hashtags, hashTag];
    ref.notifyListeners();
  }

  void contact(ContactOut data, bool isAdd) {
    if (isAdd) {
      state.contacts[data.type] = data.value;
    } else {
      state.contacts.remove(data.type);
    }
    ref.notifyListeners();
  }

  void isDraft(bool value) {
    state.isDraft = value;
    ref.notifyListeners();
  }

  void unSelectSocial() {
    var socialLinks = Map<String, String>.from(state.socialLinks);
    socialLinks.removeWhere((key, value) => value.isEmpty);

    state.selectSocial = null;
    state.socialLinks = socialLinks;

    ref.notifyListeners();
  }

  void latLng(LatLng latLng) {
    state.lat = latLng.latitude;
    state.long = latLng.longitude;
    ref.notifyListeners();
  }
}

class EventFormState {
  EventFormState({
    this.callToAction,
    this.thumbnailFile,
    this.isHori = false,
    this.isDraft = false,
    this.contacts = const {},
    this.hashtags = const [],
    this.socialLinks = const {},
    this.isMembershipContent = false,
    this.lineUpNPerformers = const [],
    this.dataLineUpNPerformers = const [],
  });

  num? lat;
  num? long;
  bool isHori;
  bool isDraft;
  String? videoUrl;
  DateTime? endTime;
  Duration? reminder;
  DateTime? startTime;
  File? pickVideoFile;
  String? thumbnailUrl;
  String? selectSocial;
  String? thumbnailFile;
  List<HashTag> hashtags;
  bool isMembershipContent;
  CallToAction? callToAction;
  Map<String, String> contacts;
  Map<String, String> socialLinks;
  List<LineUpAndPerformerIn> lineUpNPerformers;
  List<LineUpAndPerformerIn> dataLineUpNPerformers;
}
