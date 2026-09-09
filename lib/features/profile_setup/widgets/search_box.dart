import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
    required this.isSearch,
    required this.onSearch,
    required this.onChanged,
    required this.onClear,
  });

  final bool isSearch;
  final VoidCallback onSearch;
  final VoidCallback onClear;
  final ValueChanged<String> onChanged;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSearch) {
      return Padding(
        padding: EdgeInsets.all(20),
        child: TextField(
          autofocus: true,
          style: TextStyle(fontSize: 13),
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Search ...',
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            suffixIconConstraints: BoxConstraints(),
            suffixIcon: CupertinoButton(
              minSize: 0,
              onPressed: widget.onClear,
              padding: EdgeInsets.zero,
              child: Icon(Icons.clear),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextViewWidget(text: 'Select'),
          IconButton(onPressed: widget.onSearch, icon: Icon(Icons.search)),
        ],
      ),
    );
  }

  void onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onChanged(value);
    });
  }
}
