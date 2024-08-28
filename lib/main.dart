import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voxpollui/boarding/boarding_bir.dart';
import 'package:voxpollui/class/custom/custom_loading_screen.dart';
import 'package:voxpollui/pages/home_page.dart';
import 'package:voxpollui/notifier/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env.sample");

  final keyApplicationId = dotenv.env['APPLICATION_ID'];
  final keyClientKey = dotenv.env['CLIENT_KEY'];
  final keyParseServerUrl = dotenv.env['PARSE_SERVER_URL'];

  await Parse().initialize(keyApplicationId!, keyParseServerUrl!,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(await initializeApp());
}

Future<Widget> initializeApp() async {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) =>
              ThemeNotifier()),
    ],
    child: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<ParseUser?> getCurrentUser() async {
    return await ParseUser.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier =
        Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vox Poll',
      theme: themeNotifier.currentTheme,
      home: FutureBuilder<dynamic>(
        future: getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final currentUser = snapshot.data;
            if (snapshot.hasError || currentUser == null) {
              return const BoardinBir();
            } else {
              return const HomePage();
            }
          } else {
            return LoadingScreen.loadingScreen(text: "Yükleniyor");
          }
        },
      ),
    );
  }
}
