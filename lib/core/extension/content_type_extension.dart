import 'package:mobile_gigger_app/features/post_form/domain/utils/post_form_util.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';

extension ContentTypeExt on ContentType {
  FormUtil getUtil() => switch (this) {
        ContentType.post => PostFormUtil(),
        ContentType.sup => SupFormUtil(),
        ContentType.giglist => GiglistFormUtil(),
      };
}
