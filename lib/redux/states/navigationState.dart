class NavigationState {
  final String tab;

  NavigationState({this.tab});

  factory NavigationState.init() {
    return NavigationState(tab: 'index');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigationState && runtimeType == other.runtimeType && other.tab == tab;

  @override
  int get hashCode => tab.hashCode;

  NavigationState copyWith({String tab}) {
    return NavigationState(tab: tab ?? this.tab);
  }
}
