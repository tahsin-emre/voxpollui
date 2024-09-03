import 'package:flutter/material.dart';

class VoxpollProIki extends StatelessWidget {
  const VoxpollProIki({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Geri Dönüş Butonu
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFBCBCBC),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // Ödeme Yöntemleri ve Fatura Adresleri Başlıkları
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Ödeme Yöntemleri',
                        style: TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontSize: 24,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Fatura Adresleri',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontSize: 14,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Kart 1
                cardWidget(
                  context,
                  color: const Color(0xFF2355FF),
                  cardNumber: '3947',
                  cardHolder: 'İbrahim Yük',
                  expiryDate: '06/14',
                  isSelected: true,
                ),

                // Varsayılan ödeme yöntemi ayarla - Checkbox ve Yazı
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2355FF),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Varsayılan ödeme yöntemi olarak ayarla.',
                        style: TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontSize: 12,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Kart 2
                cardWidget(
                  context,
                  color: const Color(0xFF0C0C0C),
                  cardNumber: '1907',
                  cardHolder: 'İbrahim Yük',
                  expiryDate: '10/03',
                  isSelected: false,
                ),

                // Varsayılan ödeme yöntemi ayarla - Checkbox ve Yazı
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF2355FF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Varsayılan ödeme yöntemi olarak ayarla.',
                        style: TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontSize: 12,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Spacer to push buttons to the bottom
                const Spacer(),

                // Kart Ekle Butonu
                SizedBox(
                  width: double.infinity,
                  height: 49,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2355FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Kart Ekle',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16.0),

                // Ödeme İşlemine Devam Et Butonu
                SizedBox(
                  width: double.infinity,
                  height: 49,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2355FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Ödeme İşlemine Devam Et',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardWidget(
    BuildContext context, {
    required Color color,
    required String cardNumber,
    required String cardHolder,
    required String expiryDate,
    required bool isSelected,
  }) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      margin: const EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 25,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              '* * * *  * * * *  * * * *  $cardNumber',
              style: const TextStyle(
                color: Color(0xFFF6F6F6),
                fontSize: 24,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w500,
                letterSpacing: -0.41,
              ),
            ),
            const SizedBox(height: 24.0),
            Opacity(
              opacity: 0.80,
              child: Text(
                'Kart Sahibi',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              cardHolder,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w500,
                letterSpacing: -0.41,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(
                  opacity: 0.80,
                  child: Text(
                    'SKT',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  expiryDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.41,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
