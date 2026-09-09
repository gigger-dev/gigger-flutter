import 'package:mobile_gigger_app/models/gig_list_media.dart';

String getGiglistThumbnailUrl({
  String? cdnUrl,
  required String thumbnailUrl,
  required Map<String, GigListMedia> gigListMedia,
}) {
  if (thumbnailUrl.isEmpty) {
    var url =
        gigListMedia.values.where((e) => !e.isVideo).firstOrNull?.mediaUrl;
    if (cdnUrl == null) return url ?? '';
    return '$cdnUrl/$url';
  }

  if (cdnUrl == null) return thumbnailUrl;
  return '$cdnUrl/$thumbnailUrl';
}
