import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/profile_setup/empty_card.dart';

class ThreeGrid extends StatelessWidget {
  const ThreeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: .2.sh,
      child: const Row(
        children: [
          Expanded(child: EmptyCard()),
          SizedBox(width: 10),
          Expanded(child: EmptyCard()),
          SizedBox(width: 10),
          Expanded(child: EmptyCard()),
        ],
      ),
    );
  }
}
