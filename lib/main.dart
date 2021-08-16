import 'dart:io';

import 'package:backgroud_fetch/test_text.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

const String iOSBackgroundProcessingTask = "workmanager.background.task";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case iOSBackgroundProcessingTask:
        stderr.writeln("The iOS background fetch was triggered");
        break;
      case 'taskName':
        print('Executed');
        break;
    }
    bool success = true;
    return Future.value(success);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );

  try {
    Workmanager().registerPeriodicTask('task', 'taskName',
        initialDelay: Duration(seconds: 15),
        constraints: Constraints(
          networkType: NetworkType.connected,
        ));
  } on Exception catch (e) {
    print(e);
  }

  runApp(MidApp());
}

class MidApp extends StatefulWidget {
  MidApp({Key? key}) : super(key: key);

  @override
  _MidAppState createState() => _MidAppState();
}

class _MidAppState extends State<MidApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: Theme.of(context).copyWith(
        primaryColor: Colors.red,
        accentColor: Colors.cyan,
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Column(
        children: [
          Center(
            child: TestTextView(
              textEditingController: textEditingController,
              inputIcon: Icon(
                Icons.mobile_friendly,
                color: Colors.black,
              ),
              elevation: 5,
              hintText: 'Enter Mobile Number',
              keyboardtype: TextInputType.phone,
              borderSide: BorderSide(style: BorderStyle.none),
              borderRadius: BorderRadius.circular(60),
              cursorColor: Theme.of(context).primaryColor,
            ),
          ),
          ElevatedButton(
            onPressed: () => print(textEditingController.text),
            child: Text('Click'),
          ),
        ],
      ),
    );
  }
}
