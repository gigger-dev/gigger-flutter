import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/home/widgets/giglist_widget.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/giglist_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ManageGiglistScreen extends ConsumerStatefulWidget {
  const ManageGiglistScreen({super.key});

  @override
  ConsumerState<ManageGiglistScreen> createState() =>
      _ManageGiglistScreenState();
}

class _ManageGiglistScreenState extends ConsumerState<ManageGiglistScreen> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider).whenData((v) => v?.cdnUrl).value;

    var state = ref.watch(giglistControllerProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextViewWidget(text: 'Manage Giglists'),
      ),
      body: EasyRefresh(
        onRefresh: onRefresh,
        header: MaterialHeader(),
        triggerAxis: Axis.vertical,
        child: state.when(
          error: (error, stackTrace) => SizedBox(),
          loading: () => Skeletonizer(child: GiglistGridView(itemCount: 4)),
          data: (r) => ListView(
            children: [
              ListTile(
                title: TextViewWidget(text: 'FAVORITE GIGLIST CLASSIFIEDS'),
                trailing: Icon(Icons.chevron_right),
                onTap: () => const GiglistFavRoute().push(context),
              ),
              ListTile(
                title: TextViewWidget(text: 'MY GIGLIST'),
              ),
              SizedBox(height: 10),
              GiglistGridView(
                cdnUrl: cdnUrl,
                shrinkWrap: true,
                itemCount: r.items.length,
                title: (i) => r.items[i].title,
                gigListMedia: (i) => r.items[i].gigListMedia,
                isLookingFor: (i) => r.items[i].isLookingFor,
                thumbnailUrl: (i) => r.items[i].thumbnailUrl,
                wageRequested: (i) => r.items[i].wageRequested,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onRefresh() {
    ref.read(giglistControllerProvider.notifier).refresh();
  }
}
