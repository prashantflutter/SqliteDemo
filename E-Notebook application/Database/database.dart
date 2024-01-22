import 'package:sqflite/sqflite.dart' as sql;


class SQLiteDatabase {

  //// CREATED TABLE ////

  static Future<void>createTable(sql.Database database)async{
    await database.execute(
        """CREATE TABLE eNotebook(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title TEXT,
    desc TEXT,
    bookLogo TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
    )""");
  }

  ////// Created Database ////////
  static Future<sql.Database>db()async{
    return sql.openDatabase('eNotebookDatabase.db',version: 1,onCreate: (sql.Database database,int version)async{
      await createTable(database);
    });
  }


  // Create Method for store data in database
  static Future<int> createData(String title,String? desc,String bookLogo)async{

    // SQLiteDatabase class Name where created and all data pass in created object
    final db = await SQLiteDatabase.db();
    final data = {
      'title':title,
      'desc':desc,
      'bookLogo':bookLogo,
    };
    final id = await db.insert('eNotebook', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;

  }


  // Get All Data from Database Method Created
  static Future<List<Map<String,dynamic>>>getAllData()async{
    final db = await SQLiteDatabase.db();
    return db.query('eNotebook',orderBy: 'id');
  }


  // Get Single Data from Database Method
  static  Future<List<Map<String,dynamic>>>getSingleData(int id)async{
    final db = await SQLiteDatabase.db();
    return db.query('eNotebook',where: 'id = ?',whereArgs: [id],limit: 1);
  }


  // Update Data in Database using this Method
  static Future<int>updateData(int id,String title,String? desc,String bookLogo)async{
    final db =  await SQLiteDatabase.db();
    final data = {
      'title':title,
      'desc':desc,
      'bookLogo':bookLogo,
      'createdAt':DateTime.now().toString()
    };
    final result = await db.update('eNotebook', data,where: 'id = ?',whereArgs: [id]);
    return result;
  }

  // Delete Data from Database Created Method
  static Future<void>deleteData(int id)async{
    final db = await SQLiteDatabase.db();
    try{
      await db.delete('eNotebook',where: 'id = ?',whereArgs: [id]);
    }catch(e){
      print('error $e');
    }
  }

  static Future<List<Map<String, dynamic>>> searchDataByTitle(String title) async {
    final db = await SQLiteDatabase.db();
    return await db.query('eNotebook', where: 'title LIKE ?', whereArgs: ['%$title%']);
  }




}