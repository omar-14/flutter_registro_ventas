import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/config/theme/theme_provider.dart';
// import 'package:go_router/go_router.dart';
import 'package:intventory/features/auth/presentation/providers/auth_provider.dart';
import 'package:intventory/features/auth/presentation/providers/login_form_provider.dart';
import 'package:intventory/features/shared/shared.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: GeometricalBackground(
              child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            // Icon Banner
            const Icon(
              Icons.inventory_2_outlined,
              color: Color.fromARGB(255, 224, 216, 216),
              size: 100,
            ),
            const SizedBox(height: 80),

            Container(
              height: size.height - 260, // 80 los dos sizebox y 100 el ícono
              width: double.infinity,
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(100)),
              ),
              child: const _LoginForm(),
            )
          ],
        ),
      ))),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    final isDarkmode = ref.watch(themeNotifierProvider).isDarkmode;

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackbar(context, next.errorMessage);
    });

    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text('Login', style: textStyles.titleLarge),
              const SizedBox(height: 90),
              CustomTextFormField(
                label: 'Username',
                // keyboardType: TextInputType.,
                onChanged:
                    ref.read(loginFormProvider.notifier).onUsernameChange,
                errorMessage: loginForm.isFormPosted
                    ? loginForm.username.errorMessage
                    : null,
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                label: 'Contraseña',
                obscureText: true,
                onFieldSubmitted: (_) =>
                    ref.read(loginFormProvider.notifier).onFormSubmit(),
                onChanged:
                    ref.read(loginFormProvider.notifier).onPasswordChange,
                errorMessage: loginForm.isFormPosted
                    ? loginForm.password.errorMessage
                    : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomFilledButton(
                    text: 'Ingresar',
                    buttonColor: isDarkmode ? Colors.white70 : Colors.black,
                    onPressed: loginForm.isPosting
                        ? null
                        : ref.read(loginFormProvider.notifier).onFormSubmit,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  void showSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(errorMessage)));
  }
}
