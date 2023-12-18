import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/boarding/boarding_bir.dart';

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
    // Kullanıcının oturum durumunu kontrol et
    // Future<dynamic> sessionToken = await ParseUser.currentUser()?.sessionToken;
    // print(' UUUUUSSSSSSEEEEEERRRRRR    ${user}');

    // Widget homePage;

    // Eğer oturum açılmışsa home page'e yönlendir
    // if (user != null && user.isAuthenticated) {
    //   homePage =
    //       HomePage(); // Kullanıcının oturumu açıksa yönlendirilecek sayfa
    // } else {
    //   homePage =
    //       BoardinBir(); // Kullanıcı oturum açmamışsa yönlendirilecek sayfa
    // }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vox Poll',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF2355FF),
        ),
        useMaterial3: true,
      ),
      home: const BoardinBir(),
    );
  }
}
