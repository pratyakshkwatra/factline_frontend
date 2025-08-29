import 'package:auto_route/auto_route.dart';
import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoadingRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: CreateAccountRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: AddPostRoute.page),
    AutoRoute(page: NewsFullRoute.page),
    AutoRoute(page: RecommendationsFullRoute.page),
    AutoRoute(page: GamePlayRoute.page),
  ];
}
