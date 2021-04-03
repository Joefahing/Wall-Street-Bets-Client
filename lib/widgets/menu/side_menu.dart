import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'side_menu_button.dart';
import 'side_menu_footer.dart';

import '../../redux/states/appState.dart';
import '../../redux/viewmodels/navigationViewModel.dart';
import '../../redux/actions/navigationAction.dart';
import '../../components/theme_data.dart' as theme;
import '../../pages/routes.dart';

class SideMenu extends StatelessWidget {
  final horizontalPadding = 10.0;
  final verticalPadding = 25.0;
  final iconSize = 40.0;
  final backgroundColor = Colors.white;

  final logo = 'assets/images/crayon_logo.png';
  final algoIcon = 'assets/images/algorithmn_menu.svg';
  final indexMenuIcon = 'assets/images/index_menu.svg';
  final aboutMeIcon = 'assets/images/man_menu.svg';
  final subscriptionIcon = 'assets/images/subscription_menu.svg';
  final settingIcon = 'assets/images/settings_menu.svg';
  final trendingIcon = 'assets/images/trending.svg';

  build(BuildContext context) {
    return StoreConnector<AppState, NavigationViewModel>(

        //Converter here will extract all the data returned from NavigationView.fromStore to pass to builder function
        //Therefore the build function will now have access to view model and we would not have to worry about logics
        onWillChange: (prevViewModel, currentViewModel) {
          Navigator.pushReplacementNamed(context, currentViewModel.tab);
        },
        converter: (store) => NavigationViewModel.fromStore(store),
        builder: (BuildContext context, viewModel) {
          return Container(
            padding: EdgeInsets.only(
              top: horizontalPadding,
            ),
            height: double.infinity,
            decoration: BoxDecoration(color: backgroundColor),
            child: Column(
              children: [
                //This row will be come the header of the side menu
                Padding(
                  padding: EdgeInsets.only(left: verticalPadding),
                  child: Row(
                    children: [
                      Container(
                        width: iconSize + 10,
                        height: iconSize + 10,
                        decoration: BoxDecoration(
                          color: theme.darkGrey,
                          borderRadius: BorderRadius.circular(theme.borderRadius),
                        ),
                        child: Center(
                          child: SizedBox(
                            height: iconSize,
                            width: iconSize,
                            child: Image.asset(logo),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          style: theme.headline2,
                          children: [
                            TextSpan(text: 'CRA', style: TextStyle(color: theme.fireRed)),
                            TextSpan(text: 'Y', style: TextStyle(color: theme.sunsetYellow)),
                            TextSpan(text: 'ONS', style: TextStyle(color: theme.leafGreen)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      StoreConnector<AppState, VoidCallback>(
                          converter: (store) =>
                              () => store.dispatch(NavigationTabPressedAction(tab: Routes.index)),
                          builder: (context, callback) {
                            return SideMenuButton(
                              text: 'Wall Street Bet Index',
                              label: Routes.index,
                              iconName: indexMenuIcon,
                              color: viewModel.tab == Routes.index
                                  ? theme.darkGreen
                                  : theme.mediumGrey,
                              isSelected: viewModel.tab == Routes.index,
                              verticalPaddings: verticalPadding,
                              onPress: callback,
                            );
                          }),
                      StoreConnector<AppState, VoidCallback>(converter: (store) {
                        return () =>
                            store.dispatch(NavigationTabPressedAction(tab: Routes.trending));
                      }, builder: (context, callback) {
                        return SideMenuButton(
                          text: 'Trending Symbols',
                          label: Routes.trending,
                          iconName: trendingIcon,
                          color:
                              viewModel.tab == Routes.trending ? theme.darkGreen : theme.mediumGrey,
                          isSelected: viewModel.tab == Routes.trending,
                          verticalPaddings: verticalPadding,
                          onPress: callback,
                        );
                      }),
                      StoreConnector<AppState, VoidCallback>(converter: (store) {
                        return () => store.dispatch(NavigationTabPressedAction(tab: Routes.algo));
                      }, builder: (context, callback) {
                        return SideMenuButton(
                          text: 'Algorithm Trading',
                          label: Routes.algo,
                          iconName: algoIcon,
                          color: viewModel.tab == Routes.algo ? theme.darkGreen : theme.mediumGrey,
                          isSelected: viewModel.tab == Routes.algo,
                          verticalPaddings: verticalPadding,
                          onPress: callback,
                        );
                      }),
                      StoreConnector<AppState, VoidCallback>(converter: (store) {
                        return () =>
                            store.dispatch(NavigationTabPressedAction(tab: Routes.subscription));
                      }, builder: (context, callback) {
                        return SideMenuButton(
                          text: 'Subscription',
                          label: Routes.subscription,
                          iconName: subscriptionIcon,
                          color: viewModel.tab == Routes.subscription
                              ? theme.darkGreen
                              : theme.mediumGrey,
                          isSelected: viewModel.tab == Routes.subscription,
                          verticalPaddings: verticalPadding,
                          onPress: callback,
                        );
                      }),
                      StoreConnector<AppState, VoidCallback>(converter: (store) {
                        return () =>
                            store.dispatch(NavigationTabPressedAction(tab: Routes.setting));
                      }, builder: (context, callback) {
                        return SideMenuButton(
                          text: 'Settings',
                          label: Routes.setting,
                          iconName: settingIcon,
                          color:
                              viewModel.tab == Routes.setting ? theme.darkGreen : theme.mediumGrey,
                          isSelected: viewModel.tab == Routes.setting,
                          verticalPaddings: verticalPadding,
                          onPress: callback,
                        );
                      }),
                    ],
                  ),
                ),
                StoreConnector<AppState, VoidCallback>(converter: (store) {
                  return () => store.dispatch(NavigationTabPressedAction(tab: Routes.about));
                }, builder: (context, callback) {
                  return SideMenuButton(
                    text: 'About Me',
                    label: Routes.about,
                    iconName: aboutMeIcon,
                    color: viewModel.tab == Routes.about ? theme.darkGreen : theme.mediumGrey,
                    isSelected: viewModel.tab == Routes.about,
                    verticalPaddings: verticalPadding,
                    onPress: callback,
                  );
                }),

                SideMenuFooter()
              ],
            ),
          );
        });
  }
}
