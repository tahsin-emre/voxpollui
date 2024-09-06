import 'package:flutter/material.dart';

class CustomTabbar {
  static Widget customTabbar(
      TabController tabController, List<String> tabText) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFFD9D9D9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          borderRadius:
              BorderRadius.circular(10), // Seçili Tab'ın kenarlarını yuvarlatır
          color: Colors.white, // Seçili Tab'ın arka plan rengini beyaz yapar
        ),
        labelColor: Colors.black, // Seçili Tab'ın metin rengini siyah yapar
        unselectedLabelColor:
            Colors.grey, // Seçili olmayan Tab'ların metin rengini gri yapar
        tabs: List<Widget>.generate(tabText.length, (index) {
          return Tab(text: tabText[index]); // TabText'ten gelen yazıyı kullanır
        }),
        indicatorPadding:
            const EdgeInsets.all(5), // Seçili Tab göstergesinin padding'i
        indicatorSize:
            TabBarIndicatorSize.tab, // Gösterge boyutunu tab ile aynı yapar
        indicatorWeight: 3, // Gösterge kalınlığını ayarlar
      ),
    );
  }
}
