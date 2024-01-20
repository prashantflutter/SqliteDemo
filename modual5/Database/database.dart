import 'package:sqflite/sqflite.dart' as sql;


class SQLiteDatabase {

  //// CREATED TABLE ////

  static Future<void>createTable(sql.Database database)async{
    await database.execute(
        """CREATE TABLE userData(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT,
    desc TEXT,
    priority TEXT,
    picDate TEXT,
    picTime TEXT,
    task TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
    )""");
  }

  ////// Created Database ////////
  static Future<sql.Database>db()async{
    return sql.openDatabase('managementByPrashant.db',version: 1,onCreate: (sql.Database database,int version)async{
      await createTable(database);
    });
  }


  // Create Method for store data in database
  static Future<int> createData(String name,String desc,String priority,String picDate,String picTime,String? task)async{

    // SQLiteDatabase class Name where created and all data pass in created object

    final db = await SQLiteDatabase.db();
    final data = {
      'name':name,
      'desc':desc,
      'priority':priority,
      'picDate':picDate,
      'picTime':picTime,
      'task':task,
    };
    final id = await db.insert('userData', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;

  }


  // Get All Data from Database Method Created
  static Future<List<Map<String,dynamic>>>getAllData()async{
    final db = await SQLiteDatabase.db();
    return db.query('userData',orderBy: 'id');
  }


  // Get Single Data from Database Method
  static  Future<List<Map<String,dynamic>>>getSingleData(int id)async{
    final db = await SQLiteDatabase.db();
    return db.query('userData',where: 'id = ?',whereArgs: [id],limit: 1);
  }


  // Update Data in Database using this Method
  static Future<int>updateData(int id,String? name,String? desc,String? priority,String? picDate,String? picTime, {String? task})async{
    final db =  await SQLiteDatabase.db();
    final data = {
      'name':name,
      'desc':desc,
      'priority':priority,
      'picDate':picDate,
      'picTime':picTime,
      'task':task,
      'createdAt':DateTime.now().toString()
    };
    final result = await db.update('userData', data,where: 'id = ?',whereArgs: [id]);
    return result;
  }

// SingleData Update in Database using this Method
  static Future<int>updateSingleData(int id,String? task)async{
    final db =  await SQLiteDatabase.db();
    final data = {
      'task':task,
      'createdAt':DateTime.now().toString()
    };
    final result = await db.update('userData', data,where: 'id = ?',whereArgs: [id]);
    return result;
  }

  // Delete Data from Database Created Method
  static Future<void>deleteData(int id)async{
    final db = await SQLiteDatabase.db();
    try{
      await db.delete('userData',where: 'id = ?',whereArgs: [id]);
    }catch(e){
      print('error $e');
    }
  }

  // Search List by Name in HomePage Screen by This Method
  Future<List<Map<String, dynamic>>> searchDataByName(String name) async {
    final db = await SQLiteDatabase.db();
    return await db.query('userData', where: 'name LIKE ?', whereArgs: ['%$name%']);
  }



}