import 'package:flutter/material.dart';

class OnboardContinue extends StatelessWidget {
  const OnboardContinue({required this.onContinue, super.key});
  final VoidCallback onContinue;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 270,
      top: 493,
      child: SizedBox(
        width: 260,
        height: 260,
        child: Stack(
          children: [
            Positioned(
              left: 130,
              top: 0,
              child: Transform(
                transform: Matrix4.identity()
                  ..translate(0.0)
                  ..rotateZ(0.79),
                child: Container(
                  width: 183.85,
                  height: 183.85,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF2355FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(47),
                    ),
                  ),
                ),
              ),
            ),
            // Sağa bakan ok
            Positioned(
              left: 80,
              top: 115,
              child: GestureDetector(
                onTap: onContinue,
                child: const Icon(
                  Icons.arrow_forward,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ), //@
      ),
    );
  }
}
