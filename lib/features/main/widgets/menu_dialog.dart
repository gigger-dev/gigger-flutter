import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class MenuDialog extends ConsumerStatefulWidget {
  const MenuDialog({super.key});

  @override
  ConsumerState<MenuDialog> createState() => _MenuDialogState();
}

class _MenuDialogState extends ConsumerState<MenuDialog> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(7),
          onTap: () => routeToPostForm(ContentType.sup),
          child: const SizedBox(
            height: 50,
            child: Center(
              child: Text(
                "New S'Up",
                style: TextStyle(color: colorWhite),
              ),
            ),
          ),
        ),
        const Divider(indent: 20, endIndent: 20, height: 0),
        InkWell(
          borderRadius: BorderRadius.circular(7),
          onTap: () => routeToPostForm(ContentType.post),
          child: const SizedBox(
            height: 50,
            child: Center(child: TextViewWidget(text: 'New Post')),
          ),
        ),
        const Divider(indent: 20, endIndent: 20, height: 0),
        InkWell(
          onTap: routeToChat,
          borderRadius: BorderRadius.circular(7),
          child: Container(
            height: 50,
            color: colorTransparent,
            child: const Center(child: TextViewWidget(text: 'New Message')),
          ),
        ),
        const Divider(indent: 20, endIndent: 20, height: 0),
        Container(
          height: 50,
          color: colorTransparent,
          child: const Center(
            child: TextViewWidget(text: 'New Calendar Event'),
          ),
        ),
        const Divider(indent: 20, endIndent: 20, height: 0),
        InkWell(
          onTap: routeToEventForm,
          borderRadius: BorderRadius.circular(7),
          child: Container(
            height: 50,
            color: colorTransparent,
            child: const Center(child: TextViewWidget(text: 'Event Creation')),
          ),
        ),
        const Divider(indent: 20, endIndent: 20, height: 0),
        InkWell(
          borderRadius: BorderRadius.circular(7),
          onTap: () => routeToPostForm(ContentType.giglist),
          child: Container(
            height: 50,
            color: colorTransparent,
            child: const Center(
              child: TextViewWidget(text: 'Giglist Classified'),
            ),
          ),
        ),
        const Divider(indent: 20, endIndent: 20, height: 0),
        Container(
          height: 50,
          color: colorTransparent,
          child: const Center(
            child: TextViewWidget(text: 'New Band \nor Collective'),
          ),
        ),
      ],
    );
  }

  Future<void> routeToPostForm(ContentType type) async {
    context.pop();

    ref.read(postFormControllerProvider.notifier).type(type);

    await PostFormRoute().push(context);
  }

  Future<void> routeToEventForm() async {
    context.pop();
    await EventFormRoute().push(context);
  }

  Future<void> routeToChat() async {
    context.pop();
    await NotiRoute(index: 1).push(context);
  }
}
