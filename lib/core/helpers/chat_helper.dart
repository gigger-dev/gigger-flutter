import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_gigger_app/core/helpers/messaging_helper.dart';
import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/chat_token_provider.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatHelper {
  static Future<StreamChatClient> getClient(String uuid) async {
    final client = StreamChatClient('3ptyb3jnvkmu', logLevel: Level.INFO);

    var ref = ProviderContainer(
      overrides: [
        secureStorageProvider.overrideWithValue(
          FlutterSecureStorage(
            aOptions: AndroidOptions(
              keyCipherAlgorithm:
                  KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
              storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
            ),
          ),
        )
      ],
    );

    var token = await ref.read(chatTokenProviderProvider(uuid).future);
    await client.connectUser(User(id: uuid), token.replaceAll('"', ''));
    return client;
  }

  static Future<void> disconnectUser(BuildContext context) async {
    await StreamChat.of(context).client.disconnectUser();
  }

  static Future<void> connectUser(
    BuildContext context,
    ProfileOut r,
    String cdnUrl,
    String token,
  ) async {
    var chat = StreamChat.of(context);
    var client = chat.client;

    if (chat.currentUser != null) {
      await client.disconnectUser();
    }

    if (chat.currentUser == null) {
      await client.disconnectUser();

      await client.connectUser(
        User(
          id: r.uuid,
          online: true,
          name: r.account.username,
          image: '$cdnUrl/${r.avatarMedia}',
        ),
        token.replaceAll('"', ''),
      );

      var deviceToken = await MessagingHelper.getToken();

      if (deviceToken != null &&
          client.wsConnectionStatus == ConnectionStatus.connected) {
        await client.addDevice(
          deviceToken,
          PushProvider.firebase,
          pushProviderName: 'Firebase',
        );
      }
    }
  }
}
