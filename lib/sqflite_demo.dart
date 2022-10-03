import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteDemo extends StatefulWidget {
  const SQFLiteDemo({super.key});

  @override
  State<SQFLiteDemo> createState() => _SQFLiteDemoState();
}

class _SQFLiteDemoState extends State<SQFLiteDemo> {
  String localDBPathValue = '';
  getLocalDBPath() async {
    var path = await getDatabasesPath();
    setState(() {
      localDBPathValue = path;
    });
  }

  String myDatabasePath = '';
  late Database db;
  createDatabase() async {
    db = await openDatabase('flutter.db');

    setState(() {
      myDatabasePath = db.path;
    });
  }

  String tableCreation = '';
  createTable() async {
    try {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS FLUTTERDEMO (ID INTEGER PRIMARY KEY, NAME TEXT)');
      int version = await db.getVersion();
      debugPrint(version.toString());
    } catch (e) {
      tableCreation = e.toString();
    } finally {
      setState(() {});
    }
  }

  String dataInsertion = '';
  insertDataIntoTable() async {
    String table = 'FLUTTERDEMO';
    try {
      await db.execute('INSERT INTO $table(id, name) VALUES(1, "Student A")');
      await db.execute('INSERT INTO $table(id, name) VALUES(2, "Student B")');
      await db.execute('INSERT INTO $table(id, name) VALUES(3, "Student C")');
      await db.execute('INSERT INTO $table(id, name) VALUES(4, "Student D")');
      await db.execute('INSERT INTO $table(id, name) VALUES(5, "Student D")');
      await db.execute('INSERT INTO $table(id, name) VALUES(6, "Student D")');
      await db.execute('INSERT INTO $table(id, name) VALUES(7, "Student D")');
      dataInsertion = 'Successfully entered data';
    } catch (e) {
      dataInsertion = e.toString();
    } finally {
      setState(() {});
    }
  }

  fetchDataFromTable() async {}

  String dropTabletext = '';

  dropTable() async {
    try {
      await db.execute('DROP TABLE IF EXISTS FLUTTERDEMO');
      dropTabletext = 'Table dropped';
    } catch (e) {
      dropTabletext = e.toString();
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SQFLite Demo")),
      body: Column(
        children: [
          Card(
            elevation: 6,
            child: ListTile(
              onTap: getLocalDBPath,
              title: Text("Get Local Databases Path"),
              subtitle: Text(localDBPathValue),
            ),
          ),
          Card(
            elevation: 6,
            child: ListTile(
              onTap: createDatabase,
              title: Text("Create Database"),
              subtitle: Text(myDatabasePath),
            ),
          ),
          Card(
            elevation: 6,
            child: ListTile(
              onTap: createTable,
              title: Text("Create Table"),
              subtitle: Text(tableCreation),
            ),
          ),
          Card(
            elevation: 6,
            child: ListTile(
              onTap: insertDataIntoTable,
              title: Text("Insert Data into Table"),
              subtitle: Text(dataInsertion),
            ),
          ),
          Card(
            elevation: 6,
            child: ListTile(
              onTap: dropTable,
              title: Text("Drop Table"),
              subtitle: Text(dropTabletext),
            ),
          ),
        ],
      ),
    );
  }
}
