import 'package:flutter/material.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';

class AuthCheckBoxTile extends StatefulWidget {
  const AuthCheckBoxTile({
    required this.text,
    required this.onChanged,
    required this.initValue,
    super.key,
  });
  final Widget text;
  final bool initValue;
  final ValueChanged<bool?> onChanged;

  @override
  State<AuthCheckBoxTile> createState() => _AuthCheckBoxTileState();
}

class _AuthCheckBoxTileState extends State<AuthCheckBoxTile>
    with SingleTickerProviderStateMixin {
  bool value = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    value = widget.initValue;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) => CheckboxListTile(
        value: value,
        onChanged: (value) {
          _toggleCheckbox();
          widget.onChanged(value);
        },
        title: widget.text,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: AppColor.primary,
      ),
    );
  }

  void _toggleCheckbox() {
    setState(() {
      value = !value;
      if (value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }
}
