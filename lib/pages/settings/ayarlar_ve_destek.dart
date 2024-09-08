import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:voxpollui/boarding/boarding_bir.dart';
import 'package:voxpollui/class/custom/custom_appbar.dart';
import 'package:voxpollui/class/model/national/get_font.dart';

class AyarlarVeDestek extends StatelessWidget {
  const AyarlarVeDestek({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.customAppBar(context, "Ayarlar ve Destek"),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 20.0), // Dış padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Hesabın',
              description:
                  'Hesap bilgilerini görüntüleyebilir veya hesabını dondurabilirsin.',
            ),
            const Divider(height: 30),
            _buildSection(
              title: 'Destek',
              description:
                  'info@voxpoll.app adresinden veya uygulama üzerinden bizimle iletişim kurabilirsin.',
            ),
            const Divider(height: 30),
            _buildSection(
              title: 'Gizlilik ve Güvenlik',
              description:
                  'Hesabının kimler tarafından görüntülenebileceğini güncelleyebilir ve şifreni değiştirebilirsin.',
            ),
            const Divider(height: 30),
            _buildSection(
              title: 'Bildirimler',
              description: 'Bildirimleri engelle veya bildirimleri aç.',
            ),
            const Divider(height: 30),
            _buildSection(
              title: 'Erişebilirlik, Ekran ve Diller',
              description:
                  'VoxPoll içeriğinin sana nasıl gösterileceğini yönet.',
            ),
            const Divider(height: 30),
            _buildSection(
              title: 'Çıkış Yap',
              description: '',
              onTap: () async {
                await _logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      {required String title, required String description, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap, // onTap ile tıklama olayını ekledik
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontFamily: GetFont.GILROY_BOLD),
          ),
          const SizedBox(height: 8),
          if (description.isNotEmpty)
            Text(
              description,
              style: TextStyle(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 101, 101, 101),
                  height: 1.5,
                  fontFamily: GetFont.GILROY_MEDIUM),
            ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    try {
      final user = await ParseUser.currentUser() as ParseUser?;
      var response = await user?.logout();
      if (response?.success == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BoardinBir()),
        );
      } else {
        _showErrorDialog(context, 'Çıkış yapılamadı. Lütfen tekrar deneyin.');
      }
    } catch (e) {
      _showErrorDialog(context, 'Bir hata oluştu: $e');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hata'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
}
