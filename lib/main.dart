import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/boarding/boarding_bir.dart';
import 'package:voxpollui/home_page.dart';
import 'package:voxpollui/idarelik_page.dart';
import 'package:voxpollui/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env.sample");

  // Use the environment variables
  final keyApplicationId = dotenv.env['APPLICATION_ID'];
  final keyClientKey = dotenv.env['CLIENT_KEY'];
  final keyParseServerUrl = dotenv.env['PARSE_SERVER_URL'];

  await Parse().initialize(keyApplicationId!, keyParseServerUrl!,
      clientKey: keyClientKey, autoSendSessionId: true);

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF2355FF),
        ),
        useMaterial3: true,
      ),
      home: FutureBuilder<dynamic>(
        future: ParseUser.currentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError || snapshot.data == null) {
              // Hata durumu veya kullanıcı daha önce giriş yapmamışsa
              return const BoardinBir(); // veya başka bir giriş sayfası
            } else {
              // Kullanıcı daha önce giriş yapmışsa ana sayfaya yönlendir
              return HomePage();
            }
          } else {
            // Veri henüz yüklenmediyse, bir yükleniyor ekranı gösterilebilir
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
