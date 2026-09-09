import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/chat/providers/chat_search_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  late final _listController = StreamChannelListController(
    client: StreamChat.of(context).client,
    filter: Filter.in_(
      'members',
      [StreamChat.of(context).currentUser!.id],
    ),
    channelStateSort: const [SortOption('last_message_at')],
    limit: 20,
  );

  @override
  void initState() {
    super.initState();

    var profileUuid = ref.read(profileControllerProvider).value!.uuid;
    ref.read(chatSearchControllerProvider(profileUuid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextViewWidget(text: 'Messages')),
      body: StreamChannelListView(
        controller: _listController,
        // emptyBuilder: (context) => Center(child: Text('data')),
        separatorBuilder: (_, __, ___) => Divider(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        loadingBuilder: (context) => Center(
          child: Transform.scale(
            scale: .6,
            child: CircularProgressIndicator(),
          ),
        ),
        onChannelTap: (c) => ChatRoute($extra: c).push(context),
      ),
    );
  }
}
