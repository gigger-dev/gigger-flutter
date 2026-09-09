import 'package:mobile_gigger_app/features/settings/data/settings_provider.dart';
import 'package:mobile_gigger_app/features/settings/domain/settings_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_token_provider.g.dart';

@Riverpod(keepAlive: true)
class ChatTokenProvider extends _$ChatTokenProvider {
  @override
  Future<String> build(String userUuid) {
    return getApiV1ConfigGetStreamChatTokenUseCase(
      userUuid: userUuid,
      repo: ref.read(settingsRepoProvider),
    );
  }
}
