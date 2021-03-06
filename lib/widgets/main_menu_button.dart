import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/theme_data.dart' as theme;

class MainMenuButton extends StatelessWidget {
  final String text;
  final String iconName;
  final String label;
  final double verticalPaddings;
  final Color color;
  final bool isSelected;
  final void Function(String) onPress;

  final boxHeigh = 45.0;
  final iconSize = 25.0;

  MainMenuButton(
      {@required this.text,
      @required this.iconName,
      @required this.color,
      @required this.label,
      @required this.onPress,
      @required this.isSelected,
      this.verticalPaddings = 30});

  @override
  build(BuildContext context) {
    return SizedBox(
      height: boxHeigh,
      child: Material(
        color: Colors.white,
        child: InkWell(
          focusColor: theme.darkSilver,
          hoverColor: theme.lightSilver,
          child: Padding(
            padding: EdgeInsets.only(left: verticalPaddings),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  iconName,
                  semanticsLabel: label,
                  color: color,
                  height: iconSize,
                  width: iconSize,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(color: color),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 3,
                    color: isSelected ? color : Colors.white,
                  ),
                )
              ],
            ),
          ),
          onTap: () => {onPress(this.label)},
        ),
      ),
    );
  }
}

//