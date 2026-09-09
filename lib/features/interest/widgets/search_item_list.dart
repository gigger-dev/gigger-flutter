import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/interest/widgets/search_item.dart';
import 'package:mobile_gigger_app/models/interest_out.dart';

class SearchItemList extends StatelessWidget {
  const SearchItemList({super.key, required this.onRemove, required this.data});

  final List<InterestOut> data;
  final ValueChanged<InterestOut> onRemove;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: data.map((e) {
        return SearchItem(data: e, onTap: () => onRemove(e));
      }).toList(),
    );
  }
}
