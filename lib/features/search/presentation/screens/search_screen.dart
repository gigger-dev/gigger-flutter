import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/menu_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DismissiblePage(
        onDismissed: context.pop,
        backgroundColor: Colors.black,
        child: MenuWidget(
          onMenuTap: (i) => SearchFilterRoute(index: i).push(context),
        ),
      ),
    );
  }
}
