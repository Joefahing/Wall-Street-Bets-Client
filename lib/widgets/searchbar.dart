import 'package:flutter/material.dart';
import '../../components/theme_data.dart' as theme;

class SearchBar extends StatelessWidget {
  final double iconSize = 20.0;
  final double width = 250;
  final String hint = 'Search';

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: width,
        child: TextField(
          style: theme.bodyText2.copyWith(color: Colors.black),
          cursorColor: Colors.black,
          cursorWidth: 1,
          onChanged: (value) {},
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
                size: iconSize,
              ),
              isDense: true,
              hintText: hint,
              focusColor: Colors.white,
              hoverColor: Colors.white,
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                borderSide: BorderSide.none,
              )),
        ),
      ),
    );
  }
}