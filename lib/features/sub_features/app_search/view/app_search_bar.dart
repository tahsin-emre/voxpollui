import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({required this.onChanged, required this.label, super.key});
  final ValueChanged<String> onChanged;
  final String label;
  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePaddings.allS,
      child: TextField(
        cursorColor: AppColor.primary,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: widget.label.tr(),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintStyle: TextStyle(
              color: const Color.fromARGB(255, 101, 101, 101),
              fontSize: 14,
              fontFamily: FontConstants.gilroyMedium),
        ),
        onSubmitted: (value) {},
      ),
    );
  }
}
