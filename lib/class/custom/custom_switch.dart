import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDarkMode = !isDarkMode;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 60,
        height: 30,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Ay simgesi
            if (isDarkMode)
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Icon(
                  Icons.nightlight_round,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            // Boşluk için Expanded widget
            Expanded(
              child: Container(),
            ),
            // Güneş simgesi
            if (!isDarkMode)
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Icon(
                  Icons.wb_sunny,
                  color: Colors.yellow[700],
                  size: 20,
                ),
              ),
            // Kaydırılabilir buton
            AnimatedAlign(
              alignment:
                  isDarkMode ? Alignment.centerLeft : Alignment.centerRight,
              duration: Duration(milliseconds: 300),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
