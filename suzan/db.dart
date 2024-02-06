import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
// import 'package:sqflitedb/main.dart';
import 'package:path_provider/path_provider.dart';
class Mydb
{
  late Database db;
  Future open()async
  {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath,'abc.db');
    print(path);
    db = await openDatabase(path,version: 1,onCreate:(Database db, int version) async
    {
      // name,surname,email,course,address,pincode,city,totalFees,contact,marks
      await db.execute('''
                    CREATE TABLE student_data(
                     ID INTEGER PRIMARY KEY AUTOINCREMENT,
                     FirstName VARCHAR(50) NOT NULL,
                     LastName VARCHAR(50) NOT NULL,
                     Email VARCHAR(100) NOT NULL,
                     Course VARCHAR(50) NOT NULL,
                     Address VARCHAR(255) NOT NULL,
                     Pincode VARCHAR(10) NOT NULL,
                     City VARCHAR(50) NOT NULL,
                     TotalFees DECIMAL(10, 2) NOT NULL,
                     ContactNumber VARCHAR(15) NOT NULL,
                     Marks INTEGER NOT NULL
                      );
                  ''');
      print("Table Created");
    });
  }
  Future<Map<dynamic,dynamic>?> getsinglerecord(String email)async
  {
    List<Map> maps = await db.query('students', where: 'id = ?',whereArgs: [db.toString()]);
    if (maps.length > 0)
    {
      return maps.first;
    }
    return null;
  }
}
