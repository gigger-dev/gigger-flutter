// // ignore_for_file: deprecated_member_use

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
// import 'package:mobile_gigger_app/core/utils/color_utils.dart';
// import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
// import 'package:mobile_gigger_app/features/calendar/presentation/widgets/add_artist_dialog.dart';
// import 'package:mobile_gigger_app/features/calendar/presentation/widgets/add_business_dialog.dart';
// import 'package:mobile_gigger_app/features/calendar/presentation/widgets/recurring_event_sheet.dart';
// import 'package:mobile_gigger_app/widgets/text_box_widget.dart';
// import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

// class CreateCalendarScreen extends StatelessWidget {
//   const CreateCalendarScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorRed,
//       appBar: AppBar(
//         backgroundColor: colorRed,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           color: colorWhite,
//           onPressed: () => context.pop(),
//           icon: const Icon(Icons.close),
//         ),
//         actions: [
//           IconButton(
//             color: colorWhite,
//             onPressed: () => context.pop(),
//             icon: const Icon(Icons.more_horiz),
//           ),
//         ],
//         title: const TextViewWidget(text: 'New Calendar event'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           const TextBoxWidget(
//             hintText: 'Calendar event title',
//           ),
//           const SizedBox(height: 20),
//           const TextBoxWidget(hintText: 'Description'),
//           const SizedBox(height: 20),
//           const RadioListTile(value: false, title: 'All Day'),
//           const SizedBox(height: 10),
//           const CustomListTile(
//             title: TextViewWidget(text: 'Pick Date and time'),
//             trailing: Icon(CupertinoIcons.right_chevron, color: colorWhite),
//           ),
//           const _DateTimeRow(label: 'Start'),
//           const _DateTimeRow(label: 'End'),
//           const CustomListTile(
//             title: TextViewWidget(text: 'Central Europe Time'),
//           ),
//           CustomListTile(
//             title: const TextViewWidget(text: 'Recurring event'),
//             trailing:
//                 const Icon(CupertinoIcons.right_chevron, color: colorWhite),
//             onTap: () => SheetUtils.showSheet(
//               height: .68.sh,
//               context: context,
//               isScrollControlled: true,
//               children: [const RecurringEventSheet()],
//             ),
//           ),
//           const TextBoxWidget(hintText: 'Select location ...'),
//           const SizedBox(height: 20),
//           const CustomListTile(
//             title: TextViewWidget(text: 'Travel time'),
//             trailing: Icon(CupertinoIcons.right_chevron, color: colorWhite),
//           ),
//           const CustomListTile(
//             title: TextViewWidget(text: '32 km - 25 mins away'),
//           ),
//           const SizedBox(height: 10),
//           const _AddRow(title: 'Add video Conferencing link'),
//           const SizedBox(height: 10),
//           const CustomListTile(
//             title: TextViewWidget(text: 'Add Reminder'),
//             subtitle: TextViewWidget(text: '1 day before', textSize: 10),
//             trailing: Icon(CupertinoIcons.clear, size: 30, color: colorWhite),
//           ),
//           const SizedBox(height: 10),
//           _AddRow(
//             title: 'Add Artist(s), Band(s), Performer(s)',
//             onTap: () => showDialog(
//               context: context,
//               barrierDismissible: true,
//               builder: (_) => const AddArtistDialog(),
//             ),
//           ),
//           const SizedBox(height: 10),
//           const _AvatorRow(),
//           const SizedBox(height: 10),
//           _AddRow(
//             title: 'Add Business Partner(s), Sponsor(s)',
//             onTap: () => showDialog(
//               context: context,
//               barrierDismissible: true,
//               builder: (_) => const AddBusinessDialog(),
//             ),
//           ),
//           const _AvatorRow(),
//           const SizedBox(height: 10),
//           const CustomListTile(
//             title: TextViewWidget(
//               text: 'Connected account\nGoogle Calendar',
//             ),
//             trailing: Icon(CupertinoIcons.right_chevron, color: colorWhite),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TextButton(
//                 onPressed: () => context.pop(),
//                 child: const TextViewWidget(text: 'Cancel'),
//               ),
//               FilledButton(
//                 onPressed: () => context.pop(),
//                 style: FilledButton.styleFrom(
//                   elevation: 10,
//                   shadowColor: colorBlack,
//                   backgroundColor: colorRed,
//                   side: const BorderSide(color: colorWhite),
//                 ),
//                 child: const TextViewWidget(text: 'Create'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _AddRow extends StatelessWidget {
//   final String title;
//   final VoidCallback? onTap;

//   const _AddRow({required this.title, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return CustomListTile(
//       onTap: onTap,
//       title: Row(
//         children: [
//           const Icon(CupertinoIcons.add, size: 30, color: colorWhite),
//           const SizedBox(width: 10),
//           TextViewWidget(text: title),
//         ],
//       ),
//     );
//   }
// }

// class _AvatorRow extends StatelessWidget {
//   const _AvatorRow();

//   @override
//   Widget build(BuildContext context) {
//     return CustomListTile(
//       trailing: TextButton(
//         onPressed: () {},
//         child: const TextViewWidget(text: 'Modify', textSize: 12),
//       ),
//       title: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(
//             height: 30,
//             width: 84,
//             child: Stack(
//               children: [
//                 for (var i = 0; i < 4; i++)
//                   Positioned(
//                     left: (18 * i).toDouble(),
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: colorRed,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: colorWhite),
//                         boxShadow: [
//                           BoxShadow(
//                             color: colorBlack.withOpacity(.3),
//                             blurRadius: 1,
//                             offset: const Offset(-1, 0),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           CupertinoButton(
//             onPressed: () {},
//             minSize: 0,
//             padding: EdgeInsets.zero,
//             child: const Icon(
//               Icons.more_horiz,
//               color: colorWhite,
//               size: 28,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DateTimeRow extends StatelessWidget {
//   const _DateTimeRow({required this.label});

//   final String label;

//   @override
//   Widget build(BuildContext context) {
//     return CustomListTile(
//       title: TextViewWidget(text: label),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextButton(
//             onPressed: () {},
//             child: TextViewWidget(
//               text: DateFormat('EEE, dd MMM yyyy').format(DateTime.now()),
//               textSize: 12,
//             ),
//           ),
//           TextButton(
//             onPressed: () {},
//             child: TextViewWidget(
//               text: DateFormat('hh.mm a').format(DateTime.now()),
//               textSize: 12,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class RadioListTile extends StatelessWidget {
//   const RadioListTile({
//     super.key,
//     required this.title,
//     required this.value,
//     this.subtitle,
//   });

//   final String title;
//   final String? subtitle;
//   final bool value;

//   @override
//   Widget build(BuildContext context) {
//     return CustomListTile(
//       title: TextViewWidget(text: title),
//       subtitle: subtitle == null
//           ? null
//           : TextViewWidget(text: subtitle!, textSize: 10),
//       trailing: Transform.scale(
//         scale: .8,
//         child: Theme(
//           data: Theme.of(context).copyWith(useMaterial3: false),
//           child: Switch(
//             value: value,
//             trackOutlineWidth: const WidgetStatePropertyAll(.5),
//             trackOutlineColor: const WidgetStatePropertyAll(colorWhite),
//             activeTrackColor: colorTransparent,
//             onChanged: (value) {},
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomListTile extends StatelessWidget {
//   const CustomListTile({
//     super.key,
//     required this.title,
//     this.trailing,
//     this.subtitle,
//     this.onTap,
//   });

//   final Widget title;
//   final Widget? subtitle;
//   final Widget? trailing;
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       dense: true,
//       onTap: onTap,
//       title: title,
//       subtitle: subtitle,
//       trailing: trailing,
//       contentPadding: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
//     );
//   }
// }
