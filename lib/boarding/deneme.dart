import 'package:flutter/material.dart';

class Deneme extends StatefulWidget {
  const Deneme({super.key});

  @override
  State<Deneme> createState() => _DenemeState();
}

class _DenemeState extends State<Deneme> {
  @override
  Widget build(BuildContext context) {
    TextEditingController tel = TextEditingController();
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0, // İlk Container'ın üst kenarı
              left: 0, // İlk Container'ın sol kenarı
              child: Container(
                width: 227,
                height: 227,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://s3-alpha-sig.figma.com/img/89fc/5928/1b8c7b0d8131fbfc2cb5afb07a3bace5?Expires=1702857600&Signature=HkuBuQpYDSMBpikOfuyWF1~yVsJjjBVB6dO3p~MloJxK8eVnjTJYQVAX~sw4ZPulpVM1bMwZBlegY6zEPW38P2y1M16ZDn6roJ153yjAKeGuPpMKKFo-BDjDVCgGbT4qfnQkZMzOmwYgg~PUAtJmjg08isOhAnyYm~EiLYMZflyuKlgnByVJBSDzwHFzosfDAJvMiRDnezQQXmwmg-HJHUSHCmn6l~6P6VlgSbajrnkKuWo6A0M7cZDdUOqOR-~Hx3L4HSpkz~uPVtUvd6aOLjnREWcMSh8M2TnFESpgkXP9GAab4Do8Jy-7suBoF9ZnCknzeyaM65G-zl4tvJFIxg__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 227, // İlk Container'ın yüksekliği
              left: 0, // İlk Container'ın sol kenarı
              child: Container(
                child: Text(
                  'Telefon \n Numaranız',
                  style: TextStyle(
                    color: Color(0xFF0C0C0C),
                    fontSize: 40,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 456, // İkinci Container'ın yüksekliği
              left: 0, // İkinci Container'ın sol kenarı
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Color(0xFF0C0C0C),
                    fontSize: 24,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                  keyboardType: TextInputType.phone,
                  controller: tel, // Controller'ınızı eklemeyi unutmayın
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
