import 'package:flutter/material.dart';
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String description}) {
    return Column(
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
    );
  }
}
