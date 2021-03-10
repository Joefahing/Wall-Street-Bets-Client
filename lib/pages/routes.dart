import 'main_screen.dart';

class Routes {
  final index = '/index';
  final trending = '/trending';
  final algo = '/algo';
  final subscription = '/subscription';
  final about = '/about';
  final setting = '/setting';
  final error = '/error';

  final indexPage = MainScreen(pageName: 'index');
  final trendingPage = MainScreen(pageName: 'trending');
  final algoPage = MainScreen(pageName: 'algo');
  final subscriptionPage = MainScreen(pageName: 'subscription');
  final aboutPage = MainScreen(pageName: 'about');
  final settingPage = MainScreen(pageName: 'setting');
}
