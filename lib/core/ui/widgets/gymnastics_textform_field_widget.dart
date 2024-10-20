import 'package:flutter/material.dart';
import 'package:gymnastics_app/core/ui/widgets/gymnastics_input_decoration_widget.dart';

class GymnasticsTextformFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final Icon? icon;

  final bool obscureText;
  final ValueNotifier<bool> _obscureTextVN;

  GymnasticsTextformFieldWidget({
    super.key,
    required this.label,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.icon,
  }) : _obscureTextVN = ValueNotifier<bool>(obscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextVN,
      builder: (_, obscureTextVNValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureTextVNValue,
          decoration: getAuthenticationInputDecorationWidget(label, icon: icon),
        );
      },
    );
  }
}
