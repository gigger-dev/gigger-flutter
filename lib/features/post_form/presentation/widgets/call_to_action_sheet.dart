import 'package:flutter/material.dart' hide RadioListTile;
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/post_form_screen.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/radio_list_tile.dart';
import 'package:mobile_gigger_app/models/call_to_action.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';

class CallToActionSheet extends StatefulWidget {
  const CallToActionSheet(this.addCallToAction, this.callToAction, {super.key});

  final bool addCallToAction;
  final CallToAction? callToAction;

  @override
  State<CallToActionSheet> createState() => _CallToActionSheetState();
}

class _CallToActionSheetState extends State<CallToActionSheet> {
  int groupValue = 0;

  final formKey = GlobalKey<FormState>();

  final url = TextEditingController();
  final title = TextEditingController();
  final desc = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.callToAction != null) {
      var name = widget.callToAction!.name;
      var value = widget.callToAction!.value;

      groupValue = !widget.addCallToAction ? 0 : getValue(name);

      if (groupValue == 6) url.text = value;

      if (groupValue == 7) {
        title.text = name;
        desc.text = value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    value: 0,
                    title: 'None',
                    groupValue: groupValue,
                    onChanged: (value) {
                      groupValue = value;
                      setState(() {});
                    },
                  ),
                  RadioListTile(
                    value: 1,
                    title: 'Send me a DM!',
                    groupValue: groupValue,
                    onChanged: (value) {
                      groupValue = value;
                      setState(() {});
                    },
                  ),
                  RadioListTile(
                    value: 2,
                    title: 'Suport me!',
                    groupValue: groupValue,
                    onChanged: (value) {
                      groupValue = value;
                      setState(() {});
                    },
                  ),
                  RadioListTile(
                    value: 3,
                    title: 'Check my availability!',
                    groupValue: groupValue,
                    onChanged: (value) {
                      groupValue = value;
                      setState(() {});
                    },
                  ),
                  RadioListTile(
                    value: 4,
                    title: 'See my Fab9!',
                    groupValue: groupValue,
                    onChanged: (value) {
                      groupValue = value;
                      setState(() {});
                    },
                  ),
                  RadioListTile(
                    value: 5,
                    title: 'Call Me (your phone on Gigger)!',
                    groupValue: groupValue,
                    onChanged: (value) {
                      groupValue = value;
                      setState(() {});
                    },
                  ),
                  RadioListTile(
                    value: 6,
                    title: 'Visit my website!',
                    groupValue: groupValue,
                    onChanged: (value) {
                      groupValue = value;
                      setState(() {});
                    },
                  ),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return SizeTransition(
                        sizeFactor: animation,
                        axisAlignment: 0,
                        child: child,
                      );
                    },
                    child: groupValue != 6
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: PostTextBox(
                              controller: url,
                              hintText: 'Type url here ...',
                            ),
                          ),
                  ),
                  RadioListTile(
                    value: 7,
                    title: 'Custom',
                    groupValue: groupValue,
                    onChanged: (value) {
                      groupValue = value;
                      setState(() {});
                    },
                  ),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return SizeTransition(
                        sizeFactor: animation,
                        axisAlignment: 0,
                        child: child,
                      );
                    },
                    child: groupValue != 7
                        ? SizedBox()
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: PostTextBox(
                                  controller: title,
                                  hintText: 'Type title here ...',
                                ),
                              ),
                              PostTextBox(
                                controller: desc,
                                hintText: 'Type url here ...',
                              )
                            ],
                          ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GradientFilledButton(title: 'Done', onPressed: onDone),
          )
        ],
      ),
    );
  }

  void onDone() {
    if (!formKey.currentState!.validate()) return;

    context.pop({
      'name': getName(),
      'url': url.text.trim(),
      'groupValue': groupValue,
      'title': title.text.trim(),
      'desc': desc.text.trim()
    });
  }

  String getName() {
    return switch (groupValue) {
      0 => 'None',
      1 => 'Send me a DM!',
      2 => 'Suport me!',
      3 => 'Check my availability!',
      4 => 'See my Fab9!',
      5 => 'Call Me (your phone on Gigger)!',
      6 => 'Visit my website!',
      7 => 'Custom',
      int() => 'None',
    };
  }

  int getValue(String name) {
    return switch (name) {
      'None' => 0,
      'Send me a DM!' => 1,
      'Suport me!' => 2,
      'Check my availability!' => 3,
      'See my Fab9!' => 4,
      'Call Me (your phone on Gigger)!' => 5,
      'Visit my website!' => 6,
      'Custom' => 7,
      String() => 0,
    };
  }
}
