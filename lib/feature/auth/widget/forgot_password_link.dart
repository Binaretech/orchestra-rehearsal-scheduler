import 'package:flutter/material.dart';
import 'package:orchestra_rehearsal_scheduler/feature/auth/screen/forgot_password.dart';

class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ForgotPassword(),
        ));
      },
      child: Text(
        "¿Olvidaste tu contraseña?",
        style: TextStyle(
          color: theme.primaryColor,
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
