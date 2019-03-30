import 'package:fluro/fluro.dart';
import 'handler.dart';

class Routers {
  static String _root = '/';
  static String _details = '/details';

  static void configureRouters(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (_, params) {
      print('not found');
    });

    router.define(_root, handler: rootHandler);

    router.define(_details, handler: detailHandler);
  }

  static String generateDetailsRouterPath(String id) => '$_details?id=$id';
}
