import 'package:flutter/material.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';

class Kvkk extends StatelessWidget {
  const Kvkk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Aydınlatma Metni',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: FontConstants.gilroyBold,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color.fromARGB(255, 188, 188, 188),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        color: Colors.white,
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: 'VoxPoll App. Aydınlatma Metni\n',
                style: TitleStyle.titleStyle(),
              ),
              TextSpan(
                text:
                    'Hoş geldiniz! VoxPoll kullanmaya başladığınız için teşekkür ederiz. Lütfen aşağıdaki bilgileri dikkatlice okuyunuz.\n\n',
                style: TitleStyle.contentStyle(),
              ),
              TextSpan(
                text: '1. Hakkında\n',
                style: TitleStyle.titleStyle(),
              ),
              TextSpan(
                text:
                    'VoxPoll, kullanıcıların anketlere ve oylamalara aracılığıyla etkileşimli bir deneyim sunan bir mobil uygulamadır. VoxPoll, [Şirket Adı] tarafından geliştirilmiş olup [Uygulama Linki] üzerinden indirilebilir.\n\n',
                style: TitleStyle.contentStyle(),
              ),
              TextSpan(
                text: '2. Kullanım Koşulları\n',
                style: TitleStyle.titleStyle(),
              ),
              TextSpan(
                text:
                    'VoxPoll kullanıcılarının, uygulamayı kullanırken uyması gereken belirli kurallar ve şartlar bulunmaktadır. Lütfen [Kullanım Koşulları Linki] üzerinden bu koşulları okuyunuz.\n\n',
                style: TitleStyle.contentStyle(),
              ),
              TextSpan(
                text: '3. Gizlilik Politikası\n',
                style: TitleStyle.titleStyle(),
              ),
              TextSpan(
                text:
                    'VoxPoll tarafından toplanan ve işlenen kişisel bilgiler hakkında daha fazla bilgi almak için lütfen [Gizlilik Politikası Linki] üzerinden gizlilik politikamızı inceleyiniz.\n\n',
                style: TitleStyle.contentStyle(),
              ),
              TextSpan(
                text: '4. Güncellemeler ve Bildirimler\n',
                style: TitleStyle.titleStyle(),
              ),
              TextSpan(
                text:
                    'VoxPoll, zaman zaman uygulama güncellemeleri ve önemli bildirimler hakkında bilgi sağlamak amacıyla bildirimler kullanabilir. Bildirimleri yönetmek için lütfen cihazınızın bildirim ayarlarını kontrol ediniz.\n\n',
                style: TitleStyle.contentStyle(),
              ),
              TextSpan(
                text: '5. İletişim\n',
                style: TitleStyle.titleStyle(),
              ),
              TextSpan(
                text:
                    'Herhangi bir soru, öneri veya sorunuz varsa, lütfen bize [İletişim Bilgileri] üzerinden ulaşın. Size en iyi hizmeti sunabilmek için buradayız.VoxPoll kullanmaya devam etmek, bu aydınlatma metni ve ilgili belgelerde belirtilen şartları kabul ettiğiniz anlamına gelir.\n\n',
                style: TitleStyle.contentStyle(),
              ),
              TextSpan(
                text: 'Teşekkür ederiz!\n',
                style: TitleStyle.contentStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleStyle {
  static TextStyle titleStyle() {
    return TextStyle(
      fontFamily: FontConstants.gilroyMedium,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
      height: 1.3,
    );
  }

  static TextStyle contentStyle() {
    return TextStyle(
      fontFamily: FontConstants.gilroyMedium,
      fontSize: 13,
      letterSpacing: 0.7,
    );
  }
}
