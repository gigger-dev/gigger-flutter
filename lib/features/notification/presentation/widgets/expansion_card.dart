import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/notification/data/model/noti_resp_ob.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ExpansionCard extends StatefulWidget {
  const ExpansionCard({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<NotiData> items;

  @override
  State<ExpansionCard> createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        dense: true,
        textColor: colorWhite,
        iconColor: colorWhite,
        collapsedTextColor: colorWhite,
        collapsedIconColor: colorWhite,
        onExpansionChanged: (value) {
          isExpanded = value;
          setState(() {});
        },
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextViewWidget(text: widget.title, textSize: 18),
                Container(
                  height: .5,
                  width: 90,
                  margin: const EdgeInsets.only(top: 3),
                  color: colorWhite,
                ),
              ],
            ),
            const Spacer(),
            if (!isExpanded && widget.items.where((e) => e.isRead).isNotEmpty)
              const CircleAvatar(radius: 2, backgroundColor: colorRed)
          ],
        ),
        childrenPadding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              TextViewWidget(
                text:
                    '${widget.items.length} message${widget.items.length > 1 ? 's' : ''}',
                color: colorGrey,
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.items.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var data = widget.items[index];

              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: colorRed,
                  radius: 14,
                ),
                title: TextViewWidget(text: data.name),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: TextViewWidget(
                        maxLines: 1,
                        textSize: 12,
                        text: data.message,
                        color: data.isRead ? colorGrey : null,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    data.isRead
                        ? const SizedBox(width: 14)
                        : Container(
                            height: 4,
                            width: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorRed,
                            ),
                          ),
                    TextViewWidget(
                      text: data.hourAgo,
                      textSize: 12,
                      color: data.isRead ? colorGrey : null,
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
