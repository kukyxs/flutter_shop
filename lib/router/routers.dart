import 'package:fluro/fluro.dart';

import 'handler.dart';

class Routers {
  static String root = '/';
  static String details = '/details';
  static String map = '/map';
  static String settings = '/settings';

  static void configureRouters(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (_, params) {
      print('not found');
    });

    router.define(root, handler: rootHandler);

    router.define(details, handler: detailHandler);

    router.define(map, handler: mapHandler);

    router.define(settings, handler: settingHandler);
  }

  static String generateDetailsRouterPath(String id) => '$details?id=$id';
}
