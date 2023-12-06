import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/boarding/boarding_bir.dart';
import 'package:voxpollui/boarding/boarding_iki.dart';
import 'package:voxpollui/boarding/boarding_uc.dart';
import 'package:voxpollui/onboarding_page.dart';

import 'register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env.sample");

  // Use the environment variables
  final keyApplicationId = dotenv.env['APPLICATION_ID'];
  final keyClientKey = dotenv.env['CLIENT_KEY'];
  final keyParseServerUrl = dotenv.env['PARSE_SERVER_URL'];

  await Parse().initialize(keyApplicationId!, keyParseServerUrl!,
      clientKey: keyClientKey, autoSendSessionId: true);
  var firstObject = ParseObject('FirstClass')
    ..set(
        'message', 'Hey ! First message from Flutter. Parse is now connected');
  await firstObject.save();

  print('done');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vox Poll',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BoardinBir(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
