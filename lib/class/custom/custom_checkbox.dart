import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomCheckbox extends StatefulWidget {
  Widget? child;
  CustomCheckbox({super.key, this.child});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox>
    with SingleTickerProviderStateMixin {
  bool _isChecked = false;
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _sizeAnimation =
        Tween<double>(begin: 20.0, end: 21.0).animate(_animationController);
    _colorAnimation = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
      if (_isChecked) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _toggleCheckbox,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                width: _sizeAnimation.value,
                height: _sizeAnimation.value,
                decoration: BoxDecoration(
                  color: _isChecked
                      ? const Color.fromARGB(255, 35, 86, 255)
                      : Colors.transparent,
                  borderRadius: _isChecked
                      ? BorderRadius.circular(4.0)
                      : BorderRadius.circular(0.0),
                  border: Border.all(
                    color: _isChecked
                        ? const Color.fromARGB(255, 35, 86, 255)
                        : Colors.black,
                    width: 0.9,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: _colorAnimation.value,
                    size: 16,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: _toggleCheckbox,
            child: widget.child,
          ),
        ),
      ],
    );
  }
}



/*

const Text.rich(
              TextSpan(
                  text: 'Aydınlatma Metni',
                  style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 13,
                      fontFamily: 'Gilroy-medium',
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: '’ni okudum,',
                      style: TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: 'Açık Rıza Metni',
                      style: TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontSize: 13,
                          fontFamily: 'Gilroy-medium',
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '’ni okudum ve onaylıyorum.',
                      style: TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),





 const Text.rich(
                        TextSpan(
                            text: 'Açık Rıza Metni ve ',
                            style: TextStyle(
                                color: Color(0xFF0C0C0C),
                                fontSize: 13,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w400),
                            children: [
                              TextSpan(
                                text:
                                    'Ticari Elektronik İleti Aydınlatma Metni ',
                                style: TextStyle(
                                    color: Color(0xFF0C0C0C),
                                    fontFamily: 'Gilroy-medium',
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    'Kapsamında SMS, e-posta ve arama almak istiyorum.',
                                style: TextStyle(
                                    color: Color(0xFF0C0C0C),
                                    fontSize: 13,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w400),
                              ),
                            ]),
                      ),
*/