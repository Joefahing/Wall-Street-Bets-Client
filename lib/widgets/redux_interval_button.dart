import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../redux/states/appState.dart';
import '../../redux/thunks/indexThunk.dart';
import '../../redux/actions/viewAction.dart';

import '../../components/theme_data.dart' as theme;


/// As for now, this widget is being used by index view to allow users to 
/// select different intervals
class ReduxIntervalButton extends StatelessWidget {
  final String interval;
  final String title;
  final String currentInterval;

  ReduxIntervalButton({
    @required this.interval,
    @required this.title,
    @required this.currentInterval,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (store) {
        return () {
          store.dispatch(ViewIntervalPickerPressAction(interval: interval));
          store.dispatch(getIndexByIntervalThunk());
        };
      },
      builder: (context, callback) {
        return IntervalFlatButton(
            title: title,
            color: interval == currentInterval ? Colors.white : theme.lightGray,
            onPressed: callback);
      },
    );
  }
}

class IntervalFlatButton extends StatelessWidget {
  final String title;
  final Color color;
  final void Function() onPressed;

  IntervalFlatButton({@required this.title, this.color, @required this.onPressed});

  @override
  build(BuildContext context) {
    return FlatButton(
        child: Text(title, style: theme.headline4),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(theme.borderRadius / 2)),
        onPressed: onPressed,
        hoverColor: theme.lightSilver);
  }
}
