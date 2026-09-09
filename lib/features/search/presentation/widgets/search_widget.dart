import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 30,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: TextViewWidget(
                text: 'Your saved searches',
                textSize: 12,
                color: colorBtnOrangeRed,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                readOnly: true,
                onTap: () => const SearchFilterRoute().push(context),
                style: const TextStyle(fontSize: 12, color: colorWhite),
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: 'Search ...',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  hintStyle: TextStyle(color: colorWhite, fontSize: 12),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
