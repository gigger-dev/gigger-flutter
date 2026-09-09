import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/notification/data/model/noti_resp_ob.dart';
import 'package:mobile_gigger_app/features/notification/data/model/support_resp_ob.dart';
import 'package:mobile_gigger_app/features/notification/presentation/provider/support_provider.dart';
import 'package:mobile_gigger_app/features/notification/presentation/widgets/update_auto_message_dialog.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SupportDonationWidget extends ConsumerWidget {
  const SupportDonationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(supportProvider);

    return state.when(
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (data) => ListView(
        children: [
          const SizedBox(height: 10),
          Center(
            child: TextButton(
              onPressed: () => onHereTap(context),
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              child: const Text.rich(
                TextSpan(
                  style: TextStyle(color: colorGrey, fontSize: 12),
                  children: [
                    TextSpan(
                      text: 'Set your "Thank you" DM ',
                    ),
                    TextSpan(text: 'here', style: TextStyle(color: colorWhite)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ExpansionCard(title: 'SERVICES', data: supportData),
          const SizedBox(height: 20),
          ExpansionCard(title: 'SUPPORTERS', data: supportData),
          const SizedBox(height: 20),
          ExpansionCard(title: 'CONTRACTS', data: supportData),
          const SizedBox(height: 20),
          ExpansionCard(title: 'MEMBERSHIPS', data: supportData),
          const SizedBox(height: 20),
          ExpansionCard(title: 'CAMPAIGNS', data: supportData),
          const SizedBox(height: 20),
          ExpansionCard(title: 'GIGLIST', data: supportData),
        ],
      ),
    );
  }

  void onHereTap(BuildContext context) {
    // SheetUtils.showSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   children: [const UpdateAutoMessageSheet()],
    // );
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const UpdateAutoMessageDialog(),
    );
  }
}

class ExpansionCard extends StatelessWidget {
  const ExpansionCard({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final SupportData? data;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        dense: true,
        initiallyExpanded: false,
        textColor: colorWhite,
        iconColor: colorWhite,
        collapsedTextColor: colorWhite,
        collapsedIconColor: colorWhite,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextViewWidget(text: title, textSize: 18),
            Container(
              height: .5,
              width: 100,
              margin: const EdgeInsets.only(top: 3),
              color: colorWhite,
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.all(16),
        children: [
          _SupportItem(
            title: 'Recent',
            items: data?.recent ?? [],
          ),
          _SupportItem(
            title: 'This week',
            items: data?.week ?? [],
          ),
          _SupportItem(
            title: 'This month',
            items: data?.month ?? [],
          ),
        ],
      ),
    );
  }
}

class _SupportItem extends StatelessWidget {
  const _SupportItem({
    required this.title,
    required this.items,
  });

  final String title;
  final List<NotiData> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextViewWidget(
          text: title,
          textSize: 12,
          color: items.where((e) => e.isRead).isNotEmpty ? null : colorTextGrey,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var data = items[index];
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: colorRed,
                radius: 14,
              ),
              title: const TextViewWidget(text: 'Username 123'),
              subtitle: Row(
                children: [
                  Expanded(
                    child: TextViewWidget(
                      text:
                          '15\$ - post At invidunt dolores ipsum ut amet, sit ipsum rebum voluptua aliquyam amet takimata tempor ipsum sit, lorem ipsum labore stet.',
                      maxLines: 1,
                      textSize: 12,
                      color: data.isRead ? colorGrey : colorWhite,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (!data.isRead) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: TextButton(
                        onPressed: () {
                          // const ChatRoute().push(context);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const TextViewWidget(
                          text: 'Send DM',
                          color: colorRed,
                        ),
                      ),
                    ),
                    Container(
                      height: 4,
                      width: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorRed,
                      ),
                    ),
                  ] else
                    const SizedBox(width: 20),
                  const TextViewWidget(
                    text: '3h',
                    textSize: 12,
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
