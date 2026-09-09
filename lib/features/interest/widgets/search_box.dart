import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/features/interest/widgets/search_textbox.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextViewWidget(text: 'Search your own interests:'),
          SizedBox(height: 16.h),
          SearchTextBox(readOnly: true, onTap: onTap),
        ],
      ),
    );
  }
}
