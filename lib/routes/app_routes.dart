import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_new/routes/user_routes.dart';
import 'package:shelf_router/shelf_router.dart';

class AppRoutes {
  Router get router {
    final router = Router();

    router.get('/', (Request request) {
      final aboutApp = {
        'name': 'Aortem',
        'description': 'Welcome to Aortem Shelf.'
      };
      return Response.ok(jsonEncode(aboutApp));
    });

    router.mount('/users', UserRoutes().router);
    router.all(
        '/<ignore|.*>',
        (Request req) =>
            Response.notFound(jsonEncode({'message': 'Route not defined'})));

    return router;
  }
}
