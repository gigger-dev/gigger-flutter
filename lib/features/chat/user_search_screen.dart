import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/chat/providers/chat_search_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class UserSearchScreen extends ConsumerStatefulWidget {
  const UserSearchScreen({super.key});

  @override
  ConsumerState<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends ConsumerState<UserSearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).value!.cdnUrl;

    var profileUuid = ref.watch(profileControllerProvider).value!.uuid;

    var state = ref.watch(chatSearchControllerProvider(profileUuid));

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          onChanged: onSearch,
          controller: _controller,
          style: TextStyle(fontSize: 14.sp),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            // suffixIconConstraints: BoxConstraints(),
            // suffix: IconButton(
            //   onPressed: onSearch,
            //   style: IconButton.styleFrom(
            //     padding: EdgeInsets.zero,
            //     minimumSize: Size.zero,
            //   ),
            //   icon: Icon(CupertinoIcons.search, size: 20),
            // ),
          ),
        ),
      ),
      body: state.when(
        loading: () => CircularLoading(),
        error: (error, stackTrace) => Center(child: Text('$error')),
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: TextViewWidget(text: 'EMPTY', color: colorGrey),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            padding: EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              var e = data[index];
              return ListTile(
                title: Text(e.account.username),
                onTap: () => ChatRoute(uuid: e.uuid).push(context),
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    '$cdnUrl/${e.avatarMedia}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> onSearch(String v) async {
    // context.clearFocus();

    // var query = _controller.text.trim();

    var profileUuid = ref.read(profileControllerProvider).value!.uuid;
    await ref
        .read(chatSearchControllerProvider(profileUuid).notifier)
        .search(v);
  }
}
