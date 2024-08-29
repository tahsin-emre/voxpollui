import 'package:flutter/material.dart';

class Kvkk extends StatelessWidget {
  const Kvkk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Arka plan rengi
        elevation: 0, // Gölge kaldırıldı
        title: const Align(
          alignment: Alignment.centerLeft, // Başlığı sola yasla
          child: Text(
            'Aydınlatma Metni',
            style: TextStyle(
              color: Colors.black, // Başlık rengi
              fontSize: 18, // Başlık font boyutu
              fontFamily: "Gilroy-medium",
              fontWeight: FontWeight.bold, // Başlık kalınlığı
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black, // İkon rengi
          onPressed: () {
            Navigator.of(context).pop(); // Geri gitme işlemi
          },
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(Colors.white), // Arkaplan rengi
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color.fromARGB(
                      255, 188, 188, 188), // Kenarlık rengi ve kalınlığı
                ),
                borderRadius:
                    BorderRadius.circular(4.0), // Kenarlık yuvarlaklığı
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        color: Colors.white,
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Gilroy-medium',
              height: 1.5,
            ),
            children: [
              TextSpan(
                text: 'VoxPoll App. Aydınlatma Metni\n',
                style: TextStyle(
                  fontFamily: "Gilroy-medium",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                  text:
                      'Hoş geldiniz! VoxPoll kullanmaya başladığınız için teşekkür ederiz. Lütfen aşağıdaki bilgileri dikkatlice okuyunuz.\n\n',
                  style: TextStyle(
                    fontSize: 13,
                  )),
              TextSpan(
                text: '1. Hakkında\n',
                style: TextStyle(
                  fontFamily: "Gilroy-medium",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text:
                    'VoxPoll, kullanıcıların anketlere ve oylamalara aracılığıyla etkileşimli bir deneyim sunan bir mobil uygulamadır. VoxPoll, [Şirket Adı] tarafından geliştirilmiş olup [Uygulama Linki] üzerinden indirilebilir.\n\n',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              TextSpan(
                text: '2. Kullanım Koşulları\n',
                style: TextStyle(
                  fontFamily: "Gilroy-medium",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text:
                    'VoxPoll kullanıcılarının, uygulamayı kullanırken uyması gereken belirli kurallar ve şartlar bulunmaktadır. Lütfen [Kullanım Koşulları Linki] üzerinden bu koşulları okuyunuz.\n\n',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              TextSpan(
                text: '3. Gizlilik Politikası\n',
                style: TextStyle(
                  fontFamily: "Gilroy-medium",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text:
                    'VoxPoll tarafından toplanan ve işlenen kişisel bilgiler hakkında daha fazla bilgi almak için lütfen [Gizlilik Politikası Linki] üzerinden gizlilik politikamızı inceleyiniz.\n\n',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              TextSpan(
                text: '4. Güncellemeler ve Bildirimler\n',
                style: TextStyle(
                  fontFamily: "Gilroy-medium",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text:
                    'VoxPoll, zaman zaman uygulama güncellemeleri ve önemli bildirimler hakkında bilgi sağlamak amacıyla bildirimler kullanabilir. Bildirimleri yönetmek için lütfen cihazınızın bildirim ayarlarını kontrol ediniz.\n\n',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              TextSpan(
                text: '5. İletişim\n',
                style: TextStyle(
                  fontFamily: "Gilroy-medium",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text:
                    'Herhangi bir soru, öneri veya sorunuz varsa, lütfen bize [İletişim Bilgileri] üzerinden ulaşın. Size en iyi hizmeti sunabilmek için buradayız.VoxPoll kullanmaya devam etmek, bu aydınlatma metni ve ilgili belgelerde belirtilen şartları kabul ettiğiniz anlamına gelir.\n\n',
                style: TextStyle(
                  fontSize: 13,
                ),
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
