import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/config/theme/theme_provider.dart';

class CustomProductField extends ConsumerWidget {
  final bool isTopField; // La idea es que tenga bordes redondeados arriba
  final bool isBottomField; // La idea es que tenga bordes redondeados abajo
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final String initialValue;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  const CustomProductField({
    super.key,
    this.isTopField = false,
    this.isBottomField = false,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.initialValue = '',
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkmode = ref.watch(themeNotifierProvider).isDarkmode;

    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderSide:
            BorderSide(color: isDarkmode ? Colors.white : Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    const borderRadius = Radius.circular(15);

    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: isDarkmode ? const Color.fromARGB(93, 0, 0, 0) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: isTopField ? borderRadius : Radius.zero,
            topRight: isTopField ? borderRadius : Radius.zero,
            bottomLeft: isBottomField ? borderRadius : Radius.zero,
            bottomRight: isBottomField ? borderRadius : Radius.zero,
          ),
          boxShadow: [
            if (isBottomField)
              BoxShadow(
                  color: isDarkmode
                      ? Colors.white.withOpacity(0.06)
                      : Colors.black.withOpacity(0.06),
                  blurRadius: 5,
                  offset: const Offset(0, 3))
          ]),
      child: TextFormField(
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
            fontSize: 20, color: isDarkmode ? Colors.white : Colors.black54),
        maxLines: maxLines,
        initialValue: initialValue,
        decoration: InputDecoration(
          floatingLabelBehavior: maxLines > 1
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
          floatingLabelStyle: TextStyle(
              color: isDarkmode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedErrorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.transparent)),
          isDense: true,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          errorText: errorMessage,
          focusColor: colors.primary,
          // icon: const Icon(
          //   Icons.qr_code_scanner,

          // )
          // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
        ),
      ),
    );
  }
}
