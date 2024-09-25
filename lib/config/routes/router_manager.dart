import 'package:go_router/go_router.dart';
import 'package:meme_factory/config/routes/navigator_observer.dart';
import 'package:meme_factory/features/memes/presentation/page/meme_list_page.dart';
import 'package:meme_factory/features/splash/presentation/splash_page.dart';

class RouterManager {
  static final config = GoRouter(
      observers: [
        CustomNavigatorObserver(),
      ],
      initialLocation: SplashPage.path,
      routes: [
        GoRoute(
          path: SplashPage.path,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: MemeListPage.path,
          builder: (context, state) => const MemeListPage(),
        ),
      ]);
}
