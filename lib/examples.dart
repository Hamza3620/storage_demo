import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:storage_demo/sharedpref_demo.dart';
import 'package:storage_demo/sqflite_demo.dart';

class Examples extends StatelessWidget {
  const Examples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Storage Examples")),
      body: Column(
        children: [
          MyCardWidget(
            tileText: 'Shared Preferences Demo',
            func: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const SharedPreferencesDemo())));
            },
          ),
          MyCardWidget(
            tileText: 'SQFLite Demo',
            func: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const SQFLiteDemo())));
            },
          ),
          MyCardWidget(
            tileText: 'File Storage Demo',
            func: () {},
          ),
        ],
      ),
    );
  }
}

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({super.key, required this.tileText, required this.func});
  final String tileText;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: ListTile(onTap: () => func(), title: Text(tileText)),
    );
  }
}
