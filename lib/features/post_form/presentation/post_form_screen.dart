import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/extension/content_type_extension.dart';
import 'package:mobile_gigger_app/core/helpers/dialog_helper.dart';
import 'package:mobile_gigger_app/core/helpers/notification_helper.dart';
import 'package:mobile_gigger_app/core/utils/post_isolate_api.dart';
import 'package:mobile_gigger_app/features/post_form/domain/utils/post_form_util.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/hashtag_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/user_tag_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/giglist_media_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/call_to_action.dart';
import 'package:mobile_gigger_app/models/gig_list_media.dart';
import 'package:mobile_gigger_app/models/hash_tag.dart';
import 'package:mobile_gigger_app/models/sup_created_from_enum.dart';
import 'package:multi_trigger_autocomplete/multi_trigger_autocomplete.dart';

import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/category_tab_widget.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/confirm_sheet.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/giglist_form_data.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/post_form_data.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/social_list_widget.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/sup_form_data.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/thumbnail_widget.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/video_thumbnail_picker_dialog.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/video_trim_dialog.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/hashtag/hashtag_regular_expression.dart';
import 'package:mobile_gigger_app/widgets/loading.dart';
import 'package:mobile_gigger_app/widgets/select_media_sheet.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../../../core/consts/color.dart';
import '../../../../../core/utils/sheet_utils.dart';
import '../../../../../core/utils/size_utils.dart';

class PostFormScreen extends ConsumerStatefulWidget {
  const PostFormScreen({
    super.key,
    this.title,
    this.caption,
    this.musicTitle,
    this.hashtags,
    this.uuid,
    this.payload,
    this.wageRequested,
    this.location,
  });

  final String? uuid;
  final String? title;
  final String? caption;
  final String? musicTitle;
  final String? location;
  final int? wageRequested;
  final List<HashTag>? hashtags;
  final Map<String, dynamic>? payload;

  @override
  ConsumerState<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends ConsumerState<PostFormScreen> {
  var loading = Loading();
  final _formKey = GlobalKey<FormState>();

  final title = TextEditingController();
  final caption = TextEditingController();
  final musicTitle = TextEditingController();
  final hashtag = TextEditingController();
  final wageRequested = TextEditingController();
  final availability = TextEditingController();
  final userTag = TextEditingController();
  final place = TextEditingController();

  late FormUtil formUtil;

  @override
  void initState() {
    super.initState();

    title.text = widget.title ?? '';
    caption.text = widget.caption ?? '';
    musicTitle.text = widget.musicTitle ?? '';
    place.text = widget.location ?? '';
    wageRequested.text = '${widget.wageRequested ?? ''}';

    formUtil = ref.read(postFormControllerProvider).type.getUtil();

    Future.delayed(Duration.zero, () => setPayloadData());

    if (widget.hashtags != null) {
      hashtag.text = widget.hashtags!.map((e) => '#${e.name}').join(' ');

      Future.delayed(
        Duration.zero,
        () => ref
            .read(postFormControllerProvider.notifier)
            .hashTags(widget.hashtags!),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(postFormControllerProvider);

    var cdnUrl = ref.watch(configProvider.select((v) => v.value?.cdnUrl));

    return Portal(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) showConfirmSheet();
        },
        child: Scaffold(
          backgroundColor: colorBlack,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: InkWell(
              onTap: showConfirmSheet,
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
            centerTitle: true,
            title: const TextViewWidget(
              text: 'New Content',
              textSize: SizeUtils.textSizeExtraNormal,
            ),
            actions: [
              Image.asset(Assets.images.giDot.path, width: 20),
              const SizedBox(width: 15),
            ],
          ),
          body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                state.type.isGiglist
                    ? GiglistMediaWidget(cdnUrl: cdnUrl)
                    : ThumbnailWidget(
                        cdnUrl: cdnUrl,
                        thumbnailImageUrl: state.thumbnailImageUrl,
                        thumbnailImageFile: state.thumbnailImageFile,
                        onTap: () => showSelectMediaSheet(state.type),
                      ),
                CategoryTabWidget(
                  type: state.type,
                  onSelected: (v) => onTabSelected(v),
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.images.giInformation.path,
                      width: 20,
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: .6.sw,
                      child: TextViewWidget(
                        text: state.type.isGiglist
                            ? 'Your Giglist classifieds are saved in your Fab Nine. With the Pro account you can move them to the archive at any time.'
                            : 'New posts 9:16 are included in your Fab Nine, the last of those will be moved to the archive.',
                        textSize: 10,
                        color: colorTextGrey,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                if (state.pickVideoFile == null &&
                    state.videoUrl == null &&
                    state.gigListMedia.isEmpty &&
                    state.thumbnailImageFile == null) ...[
                  InkWell(
                    onTap: () => showSelectMediaSheet(state.type),
                    child: Image.asset(
                      Assets.images.giUpload.path,
                      height: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 50),
                    child: const Center(
                      child: TextViewWidget(text: 'Upload media', textSize: 12),
                    ),
                  ),
                ],
                switch (state.type) {
                  ContentType.post => PostFormData(
                      title: title,
                      place: place,
                      userTag: userTag,
                      caption: caption,
                      hashtag: hashtag,
                      musicTitle: musicTitle,
                    ),
                  ContentType.sup => SupFormData(
                      place: place,
                      caption: caption,
                      hashtag: hashtag,
                      userTag: userTag,
                    ),
                  ContentType.giglist => GiglistFormData(
                      title: title,
                      place: place,
                      hashtag: hashtag,
                      caption: caption,
                      availability: availability,
                      wageRequested: wageRequested,
                    ),
                },
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Share to',
                    style: TextStyle(
                      color: colorWhite,
                      fontSize: SizeUtils.textSizeExtraSmall,
                    ),
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
                      widget.uuid != null
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
                        onPressed: () => onPublishWithIsolate(state),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showConfirmSheet() async {
    var result = await SheetUtils.showSimpleSheet<bool>(
      context: context,
      child: const ConfirmSheet(),
    );

    if (result != true) return;
    if (!mounted) return;

    ref.read(postFormControllerProvider.notifier).clear();

    context.pop();
  }

  Future<void> showSelectMediaSheet(ContentType type) async {
    var isGiglist = type.isGiglist;
    var isSUp = type.isSUp;
    var isPost = type.isPost;

    var xfile = await SheetUtils.showSimpleSheet(
      context: context,
      child: isPost ? SelectMediaSheet.video() : SelectMediaSheet.both(),
    );

    if (isPost) {
      if (xfile == null || !mounted) return;

      await videoTrim(File(xfile as String));

      return;
    }

    var file = xfile as AssetEntity?;

    if (file == null) return;

    if (isGiglist) {
      ref.read(postFormControllerProvider.notifier).gigListAssets([file]);
    }

    var f = await file.file;
    if (f == null) return;

    if (file.mimeType!.startsWith('image')) {
      if (isGiglist) {
        ref.read(postFormControllerProvider.notifier).gigListMedia(f.path);
      } else {
        ref.read(postFormControllerProvider.notifier).thumbnailImageFile(f);
      }
    } else {
      await videoTrim(f, isGiglist: isGiglist, isSUp: isSUp);
    }
  }

  Future<void> videoTrim(
    File f, {
    bool isGiglist = false,
    bool isSUp = false,
  }) async {
    var file = await showDialog<File>(
      context: context,
      builder: (_) => VideoTrimDialog(f),
    );

    if (file == null || !mounted) return;

    List? r;

    if (isSUp) {
      var thumbnailImageFile = await getThumbnail(file.path, 0);

      if (thumbnailImageFile != null) {
        final bytes = await thumbnailImageFile.readAsBytes();
        final image = await decodeImageFromList(bytes);

        r = [thumbnailImageFile, image.height < image.width];
      }
    } else {
      r = await showDialog<List<dynamic>>(
        context: context,
        builder: (_) => VideoThumbnailPickerDialog(file),
      );
    }

    if (r == null) return;

    if (isGiglist) {
      ref
          .read(postFormControllerProvider.notifier)
          .thumbnailImageFile(r[0] as File);
      ref
          .read(postFormControllerProvider.notifier)
          .gigListMedia(file.path, true);
    } else {
      ref.read(postFormControllerProvider.notifier).videoData(
            video: file,
            isHori: r[1] as bool,
            thumbnailImg: r[0] as File,
          );
    }
  }

  void onTabSelected(ContentType v) {
    formUtil = v.getUtil();
    setState(() {});

    ref.read(postFormControllerProvider.notifier).type(v);

    title.clear();
    caption.clear();
    musicTitle.clear();
    hashtag.clear();
    wageRequested.clear();
    place.clear();
  }

  bool validate(PostFormState state) {
    if (!_formKey.currentState!.validate()) return false;

    if (state.type.isGiglist) {
      if (state.gigListMedia.isEmpty) {
        Toast.error('Select Media');
        return false;
      }
    } else {
      if (state.pickVideoFile == null &&
          state.thumbnailImageFile == null &&
          state.videoUrl == null &&
          state.thumbnailImageUrl == null) {
        Toast.error('Select Media');
        return false;
      }
    }

    return true;
  }

  List<HashTag> getHashTags(List<HashTag> hashTags) {
    var tags = List<HashTag>.from(hashTags);

    var hashtagAll = ref.read(hashtagAllControllerProvider);

    var rawTags = extractHashTags(hashtag.text.trim());

    for (var e in rawTags) {
      var d = e.replaceFirst('#', '');
      if (tags.any((t) => t.name == d)) continue;

      var uuid = hashtagAll.where((e) => e.name == d).firstOrNull?.uuid;
      tags.add(HashTag(name: d, uuid: uuid));
    }

    return tags;
  }

  List<String> getProfileTags(List<String> profileTags) {
    var tags = List<String>.from(profileTags);

    var all = ref.read(userTagAllControllerProvider);

    var rawTags = extractHashTags(userTag.text.trim());

    for (var e in rawTags) {
      var name = e.replaceFirst('@', '');
      var uuid = all
          .where((e) => e.account.username.replaceAll(' ', '') == name)
          .firstOrNull
          ?.uuid;
      if (uuid == null || tags.any((t) => t == uuid)) continue;

      tags.add(uuid);
    }

    return tags;
  }

  Map<String, Object?>? validateAndGetData(PostFormState state) {
    var isValidate = validate(state);
    if (isValidate == false) return null;

    DialogHelper.showOverlay(context);

    var tags = getHashTags(state.hashtags);
    var taggedProfiles = getProfileTags(state.taggedProfiles);

    var profileUuid = ref.read(profileControllerProvider).value!.uuid;

    var title = this.title.text.trim();
    var caption = this.caption.text.trim();
    var musicTitle = this.musicTitle.text.trim();
    var wageRequested = int.tryParse(this.wageRequested.text.trim()) ?? 0;

    return {
      'title': title,
      'lat': state.lat,
      'long': state.long,
      'caption': caption,
      'type': state.type.index,
      'isDraft': state.isDraft,
      'musicTitle': musicTitle,
      'videoUrl': state.videoUrl,
      'location': place.text.trim(),
      'profileUuid': profileUuid,
      'isPrivate': state.isPrivate,
      'wageRequested': wageRequested,
      'isPerformer': state.isPerformer,
      'taggedProfiles': taggedProfiles,
      'isLookingFor': state.isLookingFor,
      'createdFrom': state.createdFrom.index,
      'addCallToAction': state.addCallToAction,
      'pickVideoFile': state.pickVideoFile?.path,
      'isMembershipOnly': state.isMembershipOnly,
      'callToAction': state.callToAction.toJson(),
      'tags': tags.map((e) => e.toJson()).toList(),
      'thumbnailImageUrl': state.thumbnailImageUrl,
      'isOnlyForFollowers': state.isOnlyForFollowers,
      state.isDraft ? 'draft_uuid' : 'uuid': widget.uuid,
      'thumbnailImageFile': state.thumbnailImageFile?.path,
      'gigListMedia': Map<String, Map<String, dynamic>>.fromEntries(state
          .gigListMedia.entries
          .map((e) => MapEntry(e.key, e.value.toJson()))),
    };
  }

  Future<void> onPublishWithIsolate(PostFormState state) async {
    var data = validateAndGetData(state);
    if (data == null) return;

    await isolateCallBack(data);

    ref.read(postFormControllerProvider.notifier).clear();

    Toast.warning(
      '${state.type.value} ${widget.uuid != null && !state.isDraft ? 'Updating' : 'Publishing'}',
    );

    if (state.isDraft && widget.uuid != null) {
      await formUtil.deleteDraft(ref: ref, uuid: widget.uuid!);
    }
    if (!mounted) return;

    context.pop();
    context.pop();
  }

  void setPayloadData() {
    var data = widget.payload;
    if (data == null) return;

    var videoUrl = data['videoUrl'] as String?;
    var type = ContentType.values[data['type'] as int];
    var tags = List<HashTag>.from(
        (data['tags'] as List).map((e) => HashTag.fromJson(e)));
    var pickVideoFile = data['pickVideoFile'] as String?;
    var thumbnailImageFile = data['thumbnailImageFile'] as String?;
    var thumbnailImageUrl = data['thumbnailImageUrl'] as String?;
    var gigListMedia = Map.fromEntries(
      (data['gigListMedia'] as Map<String, dynamic>)
          .entries
          .map((e) => MapEntry(e.key, GigListMedia.fromJson(e.value))),
    );
    var isPerformer = data['isPerformer'] as bool;
    var isLookingFor = data['isLookingFor'] as bool;
    var addCallToAction = data['addCallToAction'] as bool;
    var isMembershipOnly = data['isMembershipOnly'] as bool;
    var isOnlyForFollowers = data['isOnlyForFollowers'] as bool;
    var taggedProfiles = data['taggedProfiles'] as List<String>;
    var isDraft = data['isDraft'] as bool;
    var isPrivate = data['isPrivate'] as bool;

    var lat = data['lat'] as num?;
    var long = data['long'] as num?;
    var callToAction = data['callToAction'] == null
        ? CallToAction(name: 'None', value: '')
        : CallToAction.fromJson(data['callToAction'] as Map<String, dynamic>);
    var createdFrom = SupCreatedFromEnum.values[data['createdFrom'] as int];

    ref.read(postFormControllerProvider.notifier).copy(
          lat: lat,
          type: type,
          long: long,
          isHori: false,
          hashtags: tags,
          isDraft: isDraft,
          gigListAssets: [],
          videoUrl: videoUrl,
          isPrivate: isPrivate,
          isPerformer: isPerformer,
          createdFrom: createdFrom,
          isLookingFor: isLookingFor,
          callToAction: callToAction,
          gigListMedia: gigListMedia,
          taggedProfiles: taggedProfiles,
          addCallToAction: addCallToAction,
          isMembershipOnly: isMembershipOnly,
          thumbnailImageUrl: thumbnailImageUrl,
          isOnlyForFollowers: isOnlyForFollowers,
          pickVideoFile: pickVideoFile == null ? null : File(pickVideoFile),
          thumbnailImageFile:
              thumbnailImageFile == null ? null : File(thumbnailImageFile),
        );
  }

  Future<void> onSaveAsDraft(PostFormState state) async {
    var isValidate = validate(state);
    if (!isValidate) {
      await Toast.error('Please fill all the required fields');
      return;
    }

    var profileUuid = ref.read(profileControllerProvider).value!.uuid;

    await formUtil.saveDraft(
      ref: ref,
      state: state,
      profileUuid: profileUuid,
      title: title.text.trim(),
      place: place.text.trim(),
      caption: caption.text.trim(),
      uuid: widget.uuid ?? Uuid().v1(),
      musicTitle: musicTitle.text.trim(),
      hashtags: getHashTags(state.hashtags),
      wageRequested: int.tryParse(wageRequested.text.trim()),
    );

    ref.read(postFormControllerProvider.notifier).clear();

    Toast.success('${state.type.value} Saved as Draft Successfully');

    if (!mounted) return;

    context.pop();
  }
}

class PostTextBox extends StatelessWidget {
  const PostTextBox({
    super.key,
    this.controller,
    this.hintText,
    this.readOnly = false,
    this.onTap,
    this.required = true,
    this.keyboardType,
    this.textCapitalization,
    this.validator,
    this.prefix,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
  });

  final bool readOnly;
  final bool required;
  final String? hintText;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextCapitalization? textCapitalization;
  final Widget? prefix;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      minLines: minLines,
      maxLength: maxLength,
      maxLines: maxLines,
      readOnly: readOnly,
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      style: const TextStyle(color: colorWhite, fontSize: 12),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        prefixIcon: prefix,
        fillColor: colorWhite,
        counterStyle: TextStyle(fontSize: 10),
        prefixIconConstraints: BoxConstraints(),
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorWhite),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorWhite),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorWhite),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorWhite),
        ),
      ),
      validator: !required
          ? null
          : (v) => v!.isEmpty ? 'required' : validator?.call(v),
    );
  }
}

class PostListTile extends StatelessWidget {
  const PostListTile({
    super.key,
    this.value,
    this.onChanged,
    required this.title,
    required this.subtitle,
    this.isDisable = false,
    this.onTap,
  });

  final bool? value;
  final String title;
  final bool isDisable;
  final String subtitle;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisable
          ? null
          : onTap ??
              (onChanged == null ? null : () => onChanged!(!(value ?? false))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextViewWidget(
                  text: title,
                  textSize: SizeUtils.textSizeExtraSmall,
                  color: isDisable ? colorTextGrey : null,
                ),
                TextViewWidget(
                  text: subtitle,
                  color: Colors.grey,
                  textSize: 11,
                ),
              ],
            ),
          ),
          if (value != null)
            Transform.scale(
              scale: 1,
              child: Switch(
                value: value!,
                activeColor: colorRed,
                activeTrackColor: colorTransparent,
                inactiveTrackColor: colorTransparent,
                onChanged: isDisable ? null : onChanged,
                inactiveThumbColor: isDisable ? colorGrey : colorWhite,
                trackOutlineColor:
                    WidgetStateProperty.resolveWith<Color?>((states) {
                  return colorWhite.withOpacity(0.5);
                }),
              ),
            )
          else
            Icon(
              CupertinoIcons.right_chevron,
              size: 20,
            ),
        ],
      ),
    );
  }
}

Future<void> isolateCallBack(Map<String, dynamic> data, [int? id]) async {
  final receivePort = ReceivePort();
  data['sendPort'] = receivePort.sendPort;
  data['rootIsolateToken'] = RootIsolateToken.instance!;

  await Isolate.spawn(postIsolateAPI, data);

  final sendPort = await receivePort.first as SendPort;
  final responsePort = ReceivePort();

  var _id = id ?? Uuid().v4().hashCode;

  var type = ContentType.values[data['type'] as int];
  var body = type.isSUp ? data['caption'] : data['title'];

  try {
    await NotificationHelper.showProgress(
      id: _id,
      title: 'Gigger',
      progress: 0,
      body: '$body uploading...',
    );

    sendPort.send({'responsePort': responsePort.sendPort});

    bool isClosed = false;

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

        // if (progress is double) {
        //   NotificationHelper.showProgress(
        //     id: _id,
        //     title: 'Gigger',
        //     progress: progress,
        //     body: '$body uploading...',
        //   );
        // }

        // if (progress == 'done') {
        //   await NotificationHelper.showDone(
        //     id: _id,
        //     title: 'Gigger',
        //     body: '$body upload successfully',
        //   );

        //   isClosed = true;
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
      //     body: '$body upload failed $e',
      //     payload: jsonEncode(data
      //       ..remove('sendPort')
      //       ..remove('rootIsolateToken')),
      //   );
      //   responsePort.close();
      // },
    );
  } catch (e) {
    await NotificationHelper.showError(
      id: _id,
      title: 'Gigger',
      body: '$body $e',
      payload: jsonEncode(data
        ..remove('sendPort')
        ..remove('rootIsolateToken')),
    );
    responsePort.close();
  }
}
