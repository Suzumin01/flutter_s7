import 'package:flutter/material.dart';
import '../routes.dart';
import '../widgets/text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Пароли не совпадают"))
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Регистрация успешна! Добро пожаловать, ${_nameController.text}!",
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.login,
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Регистрация"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.network(
                'https://img.icons8.com/?size=100&id=119900&format=png&color=000000',
                width: 80,
                height: 80,
                errorBuilder: (_, __, ___) => const Icon(Icons.gamepad, size: 80),
              ),
              const SizedBox(height: 20),
              const Text(
                "Регистрация",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                inputType: InputFieldType.name,
                labelText: "Имя:",
                hintText: "Введите ваше имя",
                prefIcon: const Icon(Icons.person),
                controller: _nameController,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                inputType: InputFieldType.email,
                labelText: "Email:",
                hintText: "example@mail.com",
                prefIcon: const Icon(Icons.email),
                controller: _emailController,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                inputType: InputFieldType.password,
                labelText: "Пароль:",
                hintText: "Пароль не менее 6 символов",
                prefIcon: const Icon(Icons.security),
                controller: _passwordController,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                inputType: InputFieldType.confirmPassword,
                labelText: "Повторите пароль:",
                hintText: "Введите пароль еще раз",
                prefIcon: const Icon(Icons.security),
                controller: _confirmPasswordController,
                passwordController: _passwordController,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _submit(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  "Зарегистрироваться",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Уже есть аккаунт? Войдите.",
                    style: TextStyle(
                      color: Color(0xFF424F7B),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}