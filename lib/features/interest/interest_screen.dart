import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/auth_bg.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/img_crd_text.dart';
import 'package:mobile_gigger_app/features/interest/providers/interest_provider.dart';
import 'package:mobile_gigger_app/features/interest/widgets/interest_list.dart';
import 'package:mobile_gigger_app/features/interest/widgets/interest_save_btn.dart';
import 'package:mobile_gigger_app/features/interest/widgets/interest_sheet.dart';
import 'package:mobile_gigger_app/features/interest/widgets/interest_title.dart';
import 'package:mobile_gigger_app/features/interest/widgets/search_box.dart';
import 'package:mobile_gigger_app/features/interest/widgets/search_item_list.dart';
import 'package:mobile_gigger_app/features/interest/widgets/submit_popup.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

import '../../../../core/consts/color.dart';

class InterestScreen extends ConsumerStatefulWidget {
  const InterestScreen({super.key});

  @override
  ConsumerState<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends ConsumerState<InterestScreen> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(interestProvider);
    var data = state.whenData((v) => v).valueOrNull;

    return AuthBg(
      colorFilter: false,
      padding: EdgeInsets.zero,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorTransparent,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: colorOrangeRed.withOpacity(.8),
        ),
        body: Container(
          color: colorOrangeRed.withOpacity(.8),
          padding: EdgeInsets.only(left: 16.w, right: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Image.asset(
                Assets.images.giGiggerLogoWhiteSmall.path,
                width: 70.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70.h),
                    InterestTitle(),
                    SizedBox(height: 20.h),
                    Expanded(child: InterestList()),
                    SizedBox(height: .02.sh),
                    if (data?.searchList.isNotEmpty ?? false)
                      SearchItemList(
                        data: data!.searchList,
                        onRemove: (v) {
                          ref.read(interestProvider.notifier).removeSearch(v);
                        },
                      ),
                  ],
                ),
              ),
              SizedBox(height: .03.sh),
              SearchBox(onTap: onSearchTap),
              AnimatedPadding(
                padding: EdgeInsets.only(
                  top: data?.searchList.isNotEmpty ?? false ? .02.sh : .08.sh,
                ),
                duration: Duration(milliseconds: 400),
                child: InterestSaveBtn(data: data, onTap: onLetGoTap),
              ),
              SizedBox(height: 13.h),
              Center(child: ImgCrdText()),
              SizedBox(height: 30.h)
            ],
          ),
        ),
      ),
    );
  }

  void onSearchTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(.68),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (_) => const InterestSheet(),
    );
  }

  Future<void> onLetGoTap() async {
    var isConfirm = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => SubmitPopup(),
    );

    if (isConfirm != true) return;

    if (!mounted) return;

    ref.read(authControllerProvider.notifier).isInterestFinish(true);
  }
}
