import 'package:flutter/material.dart';

class Kvkk extends StatelessWidget {
  const Kvkk({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aydınlatma Metni'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Gilroy',
              height: 1.5,
            ),
            children: [
              TextSpan(
                text: 'VoxPoll App. Aydınlatma Metni\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Hoş geldiniz! VoxPoll kullanmaya başladığınız için teşekkür ederiz. Lütfen aşağıdaki bilgileri dikkatlice okuyunuz.\n\n',
              ),
              TextSpan(
                text: '1. Hakkında\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'VoxPoll, kullanıcıların anketlere ve oylamalara aracılığıyla etkileşimli bir deneyim sunan bir mobil uygulamadır. VoxPoll, [Şirket Adı] tarafından geliştirilmiş olup [Uygulama Linki] üzerinden indirilebilir.\n\n',
              ),
              TextSpan(
                text: '2. Kullanım Koşulları\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'VoxPoll kullanıcılarının, uygulamayı kullanırken uyması gereken belirli kurallar ve şartlar bulunmaktadır. Lütfen [Kullanım Koşulları Linki] üzerinden bu koşulları okuyunuz.\n\n',
              ),
              TextSpan(
                text: '3. Gizlilik Politikası\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'VoxPoll tarafından toplanan ve işlenen kişisel bilgiler hakkında daha fazla bilgi almak için lütfen [Gizlilik Politikası Linki] üzerinden gizlilik politikamızı inceleyiniz.\n\n',
              ),
              TextSpan(
                text: '4. Güncellemeler ve Bildirimler\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'VoxPoll, zaman zaman uygulama güncellemeleri ve önemli bildirimler hakkında bilgi sağlamak amacıyla bildirimler kullanabilir. Bildirimleri yönetmek için lütfen cihazınızın bildirim ayarlarını kontrol ediniz.\n\n',
              ),
              TextSpan(
                text: '5. İletişim\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Herhangi bir soru, öneri veya sorunuz varsa, lütfen bize [İletişim Bilgileri] üzerinden ulaşın. Size en iyi hizmeti sunabilmek için buradayız.VoxPoll kullanmaya devam etmek, bu aydınlatma metni ve ilgili belgelerde belirtilen şartları kabul ettiğiniz anlamına gelir.\n\n',
              ),
              TextSpan(
                text: 'Teşekkür ederiz!\n',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
