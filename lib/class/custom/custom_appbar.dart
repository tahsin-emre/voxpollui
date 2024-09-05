import 'package:flutter/material.dart';

class CustomAppBar {
  static AppBar customAppBar(BuildContext context, String title,) {
    return AppBar(
        backgroundColor: Colors.white, // Arka plan rengi
        elevation: 0, // Gölge kaldırıldı
        title: Align(
          alignment: Alignment.centerLeft, // Başlığı sola yasla
          child: Text(
            title,
            style: const TextStyle(
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
      );
  }
}