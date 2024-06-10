import 'package:postgres/postgres.dart';
// import 'package:shelf/shelf.dart';

class DBConfig {
  // Future operation() async {
  var dbConnection = PostgreSQLConnection(
      "34.123.219.95", // hostURL
      5432, // port
      "postgres", // databaseName
      username: "postgres",
      password: ";iKJ0H<P(;Y4g/3?",
      useSSL: true,
      isUnixSocket: false);

  // await dbConnection.open();
  // print("Connected to postgreSQL database...");
  // return dbConnection;

  // await dbConnection.close();
}
// }

// class DB {
//   late PostgreSQLConnection _connection;

//   static Future<DB> connect(Map<String, dynamic> env) async {
//     int port = 5430;
//     String host = 'localhost';
//     String user = 'postgres';
//     String pass = ';iKJ0H<P(;Y4g/3?';
//     String name = 'postgres';

//     DB db = DB();
//     db._connection = PostgreSQLConnection(host, port, name,
//         username: user, password: pass);
//     await db._connection.open();
//     return db;
//   }
// }
