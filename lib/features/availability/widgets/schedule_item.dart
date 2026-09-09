import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({
    super.key,
    required this.onTap,
    required this.date,
    required this.times,
    required this.onRemove,
    required this.viewOnly,
  });

  final String date;
  final bool viewOnly;
  final List<List<String>> times;
  final ValueChanged<int> onRemove;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: viewOnly ? null : onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextViewWidget(text: date),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Icon(Icons.circle, size: 4),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: times.length,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(height: 5),
              itemBuilder: (context, index) {
                return ScheduleDateItem(
                  e: times[index],
                  viewOnly: viewOnly,
                  onRemove: () => onRemove(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleDateItem extends StatelessWidget {
  const ScheduleDateItem({
    super.key,
    required this.e,
    required this.onRemove,
    required this.viewOnly,
  });

  final bool viewOnly;
  final List<String> e;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextViewWidget(text: 'From ${e[0]}  to  ${e[1]}'),
        if (!viewOnly)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              style: IconButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: onRemove,
              icon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorGreyLight,
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.clear,
                  color: colorRed,
                  size: 15,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
