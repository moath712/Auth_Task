import 'package:flutter/material.dart';
import 'package:flutter_auth_task/style/app_styles.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return TextFormField(
      obscureText: !showPassword,
      decoration: AppStyles.formStyle(
        'xxxxxxxxx',
        suffixIcon: InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Icon(
            !showPassword ? Icons.visibility_outlined : Icons.visibility_off,
            color: color.primary,
          ),
          onTap: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        ),
      ),
      controller: widget.passwordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.minLength(8),
        FormBuilderValidators.required()
      ]),
    );
  }
}
