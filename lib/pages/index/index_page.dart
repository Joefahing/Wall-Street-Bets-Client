import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../redux/states/appState.dart';
import '../../redux/viewmodels/indexPageViewModel.dart';
import '../../redux/thunks/indexThunk.dart';
import '../../redux/actions/viewAction.dart';
import '../../components/adaptive.dart';
import '../../components/theme_data.dart' as theme;
import '../../widgets/line_chart.dart';

class WallStreetBetIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adaptive = AdaptiveWindow.fromContext(context: context);
    final screenHeigh = MediaQuery.of(context).size.height;
    final chartHeighFactor = 8.5 / 10;
    final double minChartHeigh = 500;
    final double maxChartHeigh = screenHeigh * chartHeighFactor < minChartHeigh
        ? minChartHeigh
        : screenHeigh * chartHeighFactor;
    final measurements = adaptive.getBreakpoint();

    return StoreConnector<AppState, IndexPageViewModel>(
        onInit: (store) {
          store.dispatch(getIndexByIntervalThunk());
          return null;
        },
        converter: (store) => IndexPageViewModel.fromStore(store),
        builder: (context, viewModel) {
          return Scaffold(
            body: Container(
              margin: EdgeInsets.only(
                right: measurements.leftRightMargin,
                left: measurements.leftRightMargin,
              ),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: measurements.topDownMargin,
                      bottom: measurements.topDownMargin,
                    ),
                    child: Column(
                      children: [
                        SearchBar(),
                        SizedBox(
                          height: measurements.gutter,
                        ),
                        Container(
                          constraints: BoxConstraints(
                            minHeight: minChartHeigh,
                            maxHeight: maxChartHeigh,
                          ),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: theme.lightSilver.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            )
                          ]),
                          child: FlatBackgroundBox(
                            child: Flex(
                              direction: Axis.vertical,
                              children: [
                                LayoutBuilder(
                                  builder: (context, constraint) {
                                    final double minWidth = 750;
                                    int crossAxisCount = adaptive.width < minWidth ? 1 : 2;
                                    double itemWidth = constraint.maxWidth / crossAxisCount;
                                    int widgetHeigh = crossAxisCount == 1 ? 65 : 80;
                                    return GridView.count(
                                      childAspectRatio: itemWidth / widgetHeigh,
                                      crossAxisCount: crossAxisCount,
                                      primary: false,
                                      shrinkWrap: true,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Wall Street Bets',
                                              style: theme.headline2,
                                            ),
                                            Text(
                                              'Dashboard',
                                              style: theme.headline2,
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment: crossAxisCount == 1
                                                ? MainAxisAlignment.center
                                                : MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(width: 1),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: theme.lightGray,
                                                  borderRadius:
                                                      BorderRadius.circular(theme.borderRadius),
                                                ),
                                                child: Row(
                                                  children: [
                                                    StoreConnector<AppState, VoidCallback>(
                                                      converter: (store) {
                                                        return () {
                                                          store.dispatch(
                                                              ViewIntervalPickerPressAction(
                                                                  interval: 'month'));
                                                          store.dispatch(getIndexByIntervalThunk());
                                                        };
                                                      },
                                                      builder: (context, callback) {
                                                        return IntervalFlatButton(
                                                            title: 'Monthly',
                                                            color: viewModel.interval == 'month'
                                                                ? Colors.white
                                                                : theme.lightGray,
                                                            onPressed: callback);
                                                      },
                                                    ),
                                                    StoreConnector<AppState, VoidCallback>(
                                                      converter: (store) {
                                                        return () {
                                                          store.dispatch(
                                                              ViewIntervalPickerPressAction(
                                                                  interval: 'week'));
                                                          store.dispatch(getIndexByIntervalThunk());
                                                        };
                                                      },
                                                      builder: (context, callback) {
                                                        return IntervalFlatButton(
                                                            title: 'Weekly',
                                                            color: viewModel.interval == 'week'
                                                                ? Colors.white
                                                                : theme.lightGray,
                                                            onPressed: callback);
                                                      },
                                                    ),
                                                    StoreConnector<AppState, VoidCallback>(
                                                      converter: (store) {
                                                        return () {
                                                          store.dispatch(
                                                              ViewIntervalPickerPressAction(
                                                                  interval: 'day'));
                                                          store.dispatch(getIndexByIntervalThunk());
                                                        };
                                                      },
                                                      builder: (context, callback) {
                                                        return IntervalFlatButton(
                                                            title: 'Daily',
                                                            color: viewModel.interval == 'day'
                                                                ? Colors.white
                                                                : theme.lightGray,
                                                            onPressed: callback);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${viewModel.intervalTitle} Index',
                                      style: theme.headline3,
                                    ),
                                    SizedBox(width: measurements.gutter),
                                    Icon(
                                      viewModel.indexUpFlag
                                          ? Icons.arrow_drop_up_rounded
                                          : Icons.arrow_drop_down_rounded,
                                      size: 40,
                                      color:
                                          viewModel.indexUpFlag ? theme.leafGreen : theme.fireRed,
                                    ),
                                    Text(
                                      '${viewModel.currentIndex}',
                                      style: theme.headline3.copyWith(
                                          color: viewModel.indexUpFlag
                                              ? theme.leafGreen
                                              : theme.fireRed),
                                    ),
                                    SizedBox(width: measurements.gutter),
                                    Text(
                                      '${viewModel.indexPercentage.toStringAsFixed(2)}%',
                                      style: theme.headline3.copyWith(
                                          color: viewModel.indexUpFlag
                                              ? theme.leafGreen
                                              : theme.fireRed),
                                    ),
                                  ],
                                ),
                                Expanded(
                                    child: viewModel.isFetching
                                        ? Center(
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                  right: measurements.leftRightMargin * 3,
                                                  left: measurements.leftRightMargin * 3,
                                                ),
                                                child: LinearProgressIndicator()),
                                          )
                                        : WallStreetBetTimeSeriesChart(
                                            series: viewModel.indexChartData))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

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

class Circle extends StatelessWidget {
  final double diameter;
  final Color color;

  Circle({@required this.diameter, @required this.color});

  build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
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

class FlatBackgroundBox extends StatelessWidget {
  final Widget child;

  FlatBackgroundBox({@required this.child});

  @override
  build(BuildContext context) {
    final adaptive = AdaptiveWindow.fromContext(context: context);
    final measurements = adaptive.getBreakpoint();
    return Container(
      padding: EdgeInsets.all(measurements.gutter),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.borderRadius),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
