import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voxpollui/boarding/boarding_bir.dart';
import 'package:voxpollui/pages/home_page.dart';
import 'package:voxpollui/notifier/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env.sample");

  // Use the environment variables
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
      ChangeNotifierProvider(create: (context) => ThemeNotifier()), // Burada ThemeNotifier'ı oluşturuyoruz
    ],
    child: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context); // Tema durumunu al
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vox Poll',
      theme: themeNotifier.currentTheme, // Tema durumunu kullan
      home: FutureBuilder<ParseUser?>(
        // Kullanıcı bilgisini doğrudan çekiyoruz
        future: ParseUser.currentUser(), // Future<ParseUser> olarak güncellendi
        builder: (context, snapshot) {
          final currentUser = snapshot.data;
          // print(currentUser);
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError || currentUser == null) {
              // Hata durumu veya kullanıcı daha önce giriş yapmamışsa
              return const BoardinBir(); // veya başka bir giriş sayfası
            } else {
              // Kullanıcı daha önce giriş yapmışsa ana sayfaya yönlendir
              return const HomePage();
            }
          } else {
            // Veri henüz yüklenmediyse, bir yükleniyor ekranı gösterilebilir
            // print(snapshot.error);
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
