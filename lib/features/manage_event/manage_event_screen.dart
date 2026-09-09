import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/home/providers/self_event_search_controller.dart';
import 'package:mobile_gigger_app/features/manage_event/widgets/manage_event_item.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ManageEventScreen extends ConsumerStatefulWidget {
  const ManageEventScreen({super.key});

  @override
  ConsumerState<ManageEventScreen> createState() => _ManageEventScreenState();
}

class _ManageEventScreenState extends ConsumerState<ManageEventScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(selfEventSearchControllerProvider(query));

    return Scaffold(
      backgroundColor: colorBlack,
      appBar: AppBar(
        backgroundColor: colorBlack,
        title: TextViewWidget(text: 'Manage your events'),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: .2.sh,
                backgroundColor: colorBlack,
                automaticallyImplyLeading: false,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextViewWidget(
                      text: 'MANAGE ALL\nYOUR EVENTS',
                      textSize: 30.sp,
                      height: 1,
                    ),
                    SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        text: 'Manage ',
                        style: TextStyle(fontSize: 13.sp, height: 1.3),
                        children: [
                          TextSpan(
                            text: 'your events',
                            style: TextStyle(color: colorRed),
                          ),
                          TextSpan(
                            text: ' and don\'t miss\nthe upcoming ones!',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              state.when(
                error: (e, _) => SliverFillRemaining(
                  child: Center(child: TextViewWidget(text: '$e')),
                ),
                loading: () => SliverFillRemaining(child: CircularLoading()),
                data: (data) => SliverList.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ManageEventItem(data, index);
                  },
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: [.5, 1],
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: [colorBlack, colorTransparent],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onTapOutside: (_) => context.clearFocus(),
                    style: const TextStyle(fontSize: 14, color: colorWhite),
                    onChanged: (value) {
                      query = value;
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Search ...',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      hintStyle: TextStyle(fontSize: 14, color: colorTextGrey),
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: () => EventFormRoute().push(context),
                  style: FilledButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                  ),
                  child: const Icon(Icons.edit_outlined, size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
