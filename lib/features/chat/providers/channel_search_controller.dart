import 'package:mobile_gigger_app/core/route/router_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'channel_search_controller.g.dart';

@riverpod
class ChannelSearchController extends _$ChannelSearchController {
  @override
  Future<QueryUsersResponse> build() {
    var chat = StreamChat.of(rootNavigatorKey.currentState!.context);

    return chat.client.queryUsers(
      filter: Filter.notEqual('id', chat.currentUser!.id),
    );
  }

  Future<void> search(String query) async {
    var chat = StreamChat.of(rootNavigatorKey.currentState!.context);

    var r = await chat.client.queryUsers(
      filter: Filter.and([
        Filter.notEqual('id', chat.currentUser!.id),
        Filter.autoComplete('name', query),
      ]),
    );

    state = AsyncData(r);

    // var newState =
    //     state.where((e) => e.name?.contains(query) ?? false).toList();

    // this.state = AsyncData(newState);
  }
}
