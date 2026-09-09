import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/features/interest/providers/interest_provider.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';

class InterestSaveBtn extends StatelessWidget {
  const InterestSaveBtn({super.key, required this.onTap, this.data});

  final InterestState? data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 14.w),
      child: GradientFilledButton(
        onPressed: ((data?.selectedList.isEmpty ?? true) &&
                    (data?.searchList.isEmpty ?? true)) ||
                (data?.loading ?? true)
            ? null
            : onTap,
        title: data?.loading ?? true ? 'Loading...' : "Hey oh! Let's go!",
        boxShadow: const BoxShadow(
          color: Color.fromRGBO(52, 21, 0, 0.75),
          offset: Offset(20, 20),
          blurRadius: 37.5,
          spreadRadius: 0.0,
        ),
      ),
    );
  }
}
