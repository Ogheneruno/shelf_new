import 'package:shelf/shelf.dart';
import 'package:shelf_new/autthControllers/firebase_controller.dart';
import 'package:shelf_router/shelf_router.dart';

class UserRoutes {
  Router get router {
    final router = Router();

    // Firebase Auth User Routes
    router.post('/register', (Request request) => UserController().register(request));
    router.post('/login', (Request request) => UserController().login(request));
    router.post('/loginwithgoogle', (Request request) => UserController().googlelogin(request));
    router.post('/loginwithgithub', (Request request) => UserController().githublogin(request));
    router.post('/logout', (Request request) => UserController().logout(request));

    // AuthO Auth User Routes

    // AWS Cognito Auth User Routes

    // Google Identity Auth User Routes

    // Okta Auth User Routes

    return router;
  }
}
