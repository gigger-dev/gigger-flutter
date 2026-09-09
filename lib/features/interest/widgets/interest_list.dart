import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/interest/providers/interest_provider.dart';
import 'package:mobile_gigger_app/models/interest_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class InterestList extends ConsumerWidget {
  const InterestList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(interestProvider);

    return state.when(
      error: (error, _) => Center(
        child: TextViewWidget(
          text: '$error',
          color: colorWhite,
          textSize: 14.sp,
        ),
      ),
      loading: () => Center(
        child: TextViewWidget(
          text: 'Loading.....',
          color: colorWhite,
          textSize: 14.sp,
        ),
      ),
      data: (data) {
        if (data.interestList.isEmpty) {
          return Center(
            child: TextViewWidget(
              text: 'There is no data Yet',
              color: colorWhite,
              textSize: 14.sp,
            ),
          );
        }

        return Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(right: 16.w, bottom: 20),
            child: Wrap(
              spacing: 4,
              runSpacing: 10,
              children: data.interestList.map((e) {
                var isSelected = data.selectedList.contains(e);

                return InterestItem(
                  data: e,
                  isSelected: isSelected,
                  onTap: () => onTap(
                    e,
                    isSelected,
                    data.selectedList.length + data.searchList.length,
                    ref,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void onTap(
    InterestOut data,
    bool isSelected,
    int length,
    WidgetRef ref,
  ) {
    if (isSelected) {
      return ref.read(interestProvider.notifier).removeInterestSelect(data);
    }

    if (length >= 5) return;

    ref.read(interestProvider.notifier).addInterestSelect(data);
  }
}

class InterestItem extends StatelessWidget {
  const InterestItem({
    super.key,
    required this.isSelected,
    required this.data,
    required this.onTap,
  });

  final InterestOut data;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                begin: Alignment(0, 50),
                end: Alignment(100, 50),
                colors: [
                  colorBtnOrangeRed,
                  colorOrangeRed,
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          isSelected
              ? BoxShadow(
                  color: colorBlack.withOpacity(.4),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(10, 10),
                )
              : const BoxShadow(
                  color: colorTransparent,
                ),
        ],
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            width: 1.0,
            color: isSelected ? colorTransparent : colorWhite,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onTap,
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: TextViewWidget(
            text: data.name,
            textSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
