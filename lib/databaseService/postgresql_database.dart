import 'package:shelf_new/databaseService/configurations.dart';
import 'package:shelf_new/databaseService/database_user_model.dart';

Future createDbTable(UserData user) async {
  await DBConfig().dbConnection.query('''
  CREATE TABLE users(
    user.id serial primary key not null,
    user.email text not null,
    message text not null
  )
''');
}
