import 'main_screen.dart';

class Routes {
  static final index = '/index';
  static final trending = '/trending';
  static final algo = '/algo';
  static final subscription = '/subscription';
  static final about = '/about';
  static final setting = '/setting';
  static final error = '/error';

  static final indexPage = MainScreen(pageName: 'index');
  static final trendingPage = MainScreen(pageName: 'trending');
  static final algoPage = MainScreen(pageName: 'algo');
  static final subscriptionPage = MainScreen(pageName: 'subscription');
  static final aboutPage = MainScreen(pageName: 'about');
  static final settingPage = MainScreen(pageName: 'setting');
}
