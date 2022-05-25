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
//   PostgreSQLConnection _connection;

//   static Future<DB> connect(Map<String, dynamic> env) async {
//     int _port = 5432;
//     String _host = env['DB_HOST'];
//     String _user = env['DB_USER'];
//     String _pass = env['DB_PASS'];
//     String _name = env['DB_NAME'];

//     DB db = DB();
//     db._connection = PostgreSQLConnection(_host, _port, _name,
//         username: _user, password: _pass);
//     await db._connection.open();
//     return db;
//   }