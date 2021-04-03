import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'side_menu_button.dart';
import 'side_menu_footer.dart';

import '../../redux/states/appState.dart';
import '../../redux/viewmodels/navigationViewModel.dart';
import '../../redux/actions/navigationAction.dart';
import '../../components/theme_data.dart' as theme;

class SideMenu extends StatefulWidget {
  SideMenu({Key key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
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

  String clickedButton = '/index';

  onButtonClicked(String label) {
    setState(() {
      clickedButton = label;
      Navigator.pushReplacementNamed(context, label);
    });
  }

  build(BuildContext context) {
    return StoreConnector<AppState, NavigationViewModel>(

        //Converter here will extract all the data returned from NavigationView.fromStore to pass to builder function
        //Therefore the build function will now have access to view model and we would not have to worry about logics

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
                              () => store.dispatch(NavigationTabPressedAction(tab: 'index')),
                          builder: (context, callback) {
                            return SideMenuButton(
                              text: 'Wall Street Bet Index',
                              label: '/index',
                              iconName: indexMenuIcon,
                              color: viewModel.tab == 'index' ? theme.darkGreen : theme.mediumGrey,
                              isSelected: viewModel.tab == 'index',
                              verticalPaddings: verticalPadding,
                              onPress: callback,
                            );
                          }),

                      StoreConnector<AppState, VoidCallback>(converter: (store) {
                        //Navigator.pushReplacementNamed(context, 'trending');
                        return () => store.dispatch(NavigationTabPressedAction(tab: 'trending'));
                      }, builder: (context, callback) {
                        return SideMenuButton(
                          text: 'Trending Symbols',
                          label: '/trending',
                          iconName: indexMenuIcon,
                          color: viewModel.tab == 'trending' ? theme.darkGreen : theme.mediumGrey,
                          isSelected: viewModel.tab == 'trending',
                          verticalPaddings: verticalPadding,
                          onPress: callback,
                        );
                      }),

                      // SideMenuButton(
                      //   text: 'Wall Street Bet Index',
                      //   label: '/index',
                      //   iconName: indexMenuIcon,
                      //   color: viewModel.tab == 'index' ? theme.darkGreen : theme.mediumGrey,
                      //   isSelected: viewModel.tab == 'index',
                      //   verticalPaddings: verticalPadding,
                      //   onPress: (){

                      //   },
                      // ),
                      // SideMenuButton(
                      //   text: 'Trending Symbols',
                      //   label: '/trending',
                      //   iconName: trendingIcon,
                      //   color: clickedButton == '/trending' ? theme.darkGreen : theme.mediumGrey,
                      //   isSelected: clickedButton == '/trending',
                      //   verticalPaddings: verticalPadding,
                      //   //onPress: onButtonClicked,
                      // ),
                      SideMenuButton(
                        text: 'Algorithm Trading',
                        label: '/algo',
                        iconName: algoIcon,
                        color: clickedButton == '/algo' ? theme.darkGreen : theme.mediumGrey,
                        isSelected: clickedButton == '/algo',
                        verticalPaddings: verticalPadding,
                        //onPress: onButtonClicked,
                      ),
                      SideMenuButton(
                        text: 'Subscription',
                        label: '/subscription',
                        iconName: subscriptionIcon,
                        color:
                            clickedButton == '/subscription' ? theme.darkGreen : theme.mediumGrey,
                        isSelected: clickedButton == '/subscription',
                        verticalPaddings: verticalPadding,
                        //onPress: onButtonClicked,
                      ),
                      SideMenuButton(
                        text: 'Settings',
                        label: '/setting',
                        iconName: settingIcon,
                        color: clickedButton == '/setting' ? theme.darkGreen : theme.mediumGrey,
                        isSelected: clickedButton == '/setting',
                        verticalPaddings: verticalPadding,
                        //onPress: onButtonClicked,
                      ),
                    ],
                  ),
                ),
                SideMenuButton(
                  text: 'Who Am I?',
                  label: '/about',
                  iconName: aboutMeIcon,
                  color: clickedButton == '/about' ? theme.darkGreen : theme.mediumGrey,
                  isSelected: clickedButton == '/about',
                  verticalPaddings: verticalPadding,
                  //onPress: onButtonClicked,
                ),

                SideMenuFooter()
              ],
            ),
          );
        });
  }
}
