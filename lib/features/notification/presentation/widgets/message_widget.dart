import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/features/notification/presentation/provider/message_provider.dart';
import 'package:mobile_gigger_app/features/notification/presentation/widgets/chat_expansion_card.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MessageWidget extends ConsumerStatefulWidget {
  const MessageWidget({super.key});

  @override
  ConsumerState<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends ConsumerState<MessageWidget> {
  late StreamChannelListController messaging;
  late StreamChannelListController giglist;

  @override
  void initState() {
    super.initState();
    var id = ref.read(profileControllerProvider).valueOrNull?.uuid;
    if (id == null) return;

    messaging = StreamChannelListController(
      client: StreamChat.of(context).client,
      filter: Filter.and([
        Filter.equal('type', 'messaging'),
        Filter.in_('members', [id]),
      ]),
      channelStateSort: const [SortOption('last_message_at')],
      limit: 20,
    );

    giglist = StreamChannelListController(
      client: StreamChat.of(context).client,
      filter: Filter.and([
        Filter.equal('type', 'giglist'),
        Filter.in_('members', [id]),
      ]),
      channelStateSort: const [SortOption('last_message_at')],
      limit: 20,
    );
  }

  @override
  void dispose() {
    messaging.dispose();
    giglist.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var isPro = false;

    var state = ref.watch(messageProvider);

    return state.when(
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => const CircularLoading(),
      data: (data) => ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          const SizedBox(height: 20),
          ChatExpansionCard(
            title: 'GENERAL',
            controller: messaging,
            initiallyExpanded: true,
          ),
          // if (isPro) ...[
          //   Padding(
          //     padding: const EdgeInsets.only(top: 20),
          //     child: ExpansionCard(
          //       title: 'PRO USERS',
          //       items: data?.proUsers ?? [],
          //     ),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.only(top: 20),
          //     child: ExpansionCard(
          //       title: 'CALENDAR',
          //       items: data?.calendar ?? [],
          //     ),
          //   ),
          // ],
          const SizedBox(height: 20),
          ChatExpansionCard(title: 'GIGLIST', controller: giglist),
        ],
      ),
    );
  }
}

// class ExpansionCard extends StatelessWidget {
//   const ExpansionCard({
//     super.key,
//     required this.title,
//     required this.count,
//     this.items = const [],
//   });

//   final String title;
//   final int count;
//   final List items;

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//       child: ExpansionTile(
//         dense: true,
//         textColor: colorWhite,
//         iconColor: colorWhite,
//         collapsedTextColor: colorWhite,
//         collapsedIconColor: colorWhite,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextViewWidget(text: title, textSize: 18),
//             Container(
//               height: .5,
//               width: 90,
//               margin: const EdgeInsets.only(top: 3),
//               color: colorWhite,
//             ),
//           ],
//         ),
//         childrenPadding: const EdgeInsets.all(16),
//         children: [
//           const Row(
//             children: [
//               TextViewWidget(
//                 // text: '$count message${count > 1 ? 's' : ''}',
//                 text: '5 messages',
//                 color: colorGrey,
//               ),
//             ],
//           ),
//           ListView.builder(
//             itemCount: 5,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               var isAlreadyRead = index > 2;

//               return ListTile(
//                 dense: true,
//                 contentPadding: EdgeInsets.zero,
//                 leading: const CircleAvatar(
//                   backgroundColor: colorRed,
//                   radius: 14,
//                 ),
//                 title: const TextViewWidget(text: 'Username 123'),
//                 subtitle: Row(
//                   children: [
//                     Expanded(
//                       child: TextViewWidget(
//                         text:
//                             'Message preview At invidunt dolores ipsum ut amet, sit ipsum rebum voluptua aliquyam amet takimata tempor ipsum sit, lorem ipsum labore stet.',
//                         maxLines: 1,
//                         textSize: 12,
//                         color: isAlreadyRead ? colorTextGrey : null,
//                         textOverflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     isAlreadyRead
//                         ? const SizedBox(width: 14)
//                         : Container(
//                             height: 4,
//                             width: 4,
//                             margin: const EdgeInsets.symmetric(horizontal: 10),
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: colorRed,
//                             ),
//                           ),
//                     TextViewWidget(
//                       text: '3h',
//                       textSize: 12,
//                       color: isAlreadyRead ? colorTextGrey : null,
//                     ),
//                   ],
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
