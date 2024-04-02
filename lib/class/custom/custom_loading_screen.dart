import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingScreen {
  static Widget loadingScreen({
    required String text,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // Shimmer efektinin temel rengi
      highlightColor: Colors.grey[100]!, // Shimmer efektinin parıldayan rengi
      child: Card(
        color: Colors.white,
        elevation: 0.0,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white, // Arka plan rengini beyaz yaparak simgeyi gizleyin
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100, // Metin yerine geçici bir kutu
                        height: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5.0),
                      Container(
                        width: 60, // Metin yerine geçici bir kutu
                        height: 15,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(height: 5.0),
              Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
              ),
              const SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                height: 40, // Yüksekliği buton yüksekliğine ayarlayın
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
