import 'package:flutter/material.dart';

enum InputFieldType { name, email, password, confirmPassword }

class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String labelText;
  final String hintText;
  final Icon prefIcon;
  final TextEditingController controller;
  final TextEditingController? passwordController;
  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.labelText,
    required this.hintText,
    required this.prefIcon,
    required this.controller,
    this.passwordController,
  });
  @override
  State<CustomTextFormField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFormField> {
  bool _hidePassword = true;

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Поле не может быть пустым";
    }

    switch (widget.inputType) {
      case InputFieldType.name:
        final reg = RegExp(r'^[A-Za-zА-Яа-я\s]+$'); // только буквы и пробелы
        if (!reg.hasMatch(value)) {
          return "Имя должно содержать только буквы";
        }
        break;

      case InputFieldType.email:
        final reg1 = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
        if (!reg1.hasMatch(value)) {
          return "Введите корректный email";
        }
        break;

      case InputFieldType.password:
        final reg2 = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[+_-])[A-Za-z\d+_-]{6,}$');
        if (!reg2.hasMatch(value)) {
          return "Пароль ≥6 символов, с буквами, цифрами и символами (+, _, -)";
        }
        break;

      case InputFieldType.confirmPassword:
        if (widget.passwordController != null && value != widget.passwordController!.text) {
          return "Пароли не совпадают";
        }
        final reg3 = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[+_-])[A-Za-z\d+_-]{6,}$');
        if (!reg3.hasMatch(value)) {
          return "Пароль ≥6 символов, с буквами, цифрами и символами (+, _, -)";
        }
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.inputType == InputFieldType.password ||
        widget.inputType == InputFieldType.confirmPassword;

    return TextFormField(
      controller: widget.controller,
      obscureText: isPassword && _hidePassword,
      keyboardType: widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      textInputAction: widget.inputType == InputFieldType.confirmPassword
          ? TextInputAction.done
          : TextInputAction.next,
      onFieldSubmitted: (_) {
        if (widget.inputType != InputFieldType.confirmPassword) {
          FocusScope.of(context).nextFocus();
        }
      },
      style: const TextStyle(
        color: Color(0xFF192252),
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: const Color(0xFF424F7B), fontSize: 16),
        hintText: widget.hintText,
        prefixIcon: widget.prefIcon,
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _hidePassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() => _hidePassword = !_hidePassword);
          },
        )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFF424F7B), width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFF424F7B), width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: _validator,
    );
  }
}