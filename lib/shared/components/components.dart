import 'package:flutter/material.dart';
import '../../styles/colors.dart';

String? Function(String?)? _defileValidator(hint) {
  // inner default validator
  innerDefaultValidator(value) {
    return value?.isEmpty == true ? "Enter your $hint" : null;
  }

  return innerDefaultValidator;
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required String hint,
  required TextInputType type,
  bool obscureText = false,
  bool autofocus = false,
  bool enable = true,
  bool isCustomValidator = false,
  String? Function(String?)? customValidator,
  String? label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  void Function()? onTap,
  void Function(String)? onFieldSubmitted,
}) {
  return TextFormField(
    onTap: onTap,
    decoration: InputDecoration(
      prefixIconColor: Colors.grey.shade500,
      suffixIconColor: Colors.grey.shade500,
      prefixIcon: prefix != null ? Icon(prefix) : null,
      suffixIcon: IconButton(
        icon: Icon(
          suffix,
          size: 20,
        ),
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: suffixPressed,
      ),
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.grey[500],
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ),
      ),
      fillColor: Colors.grey.shade200,
      filled: true,
    ),
    enabled: enable,
    onFieldSubmitted: onFieldSubmitted,
    controller: controller,
    keyboardType: type,
    validator: isCustomValidator ? customValidator : _defileValidator(hint),
    obscureText: obscureText,
    autofocus: autofocus,
    cursorColor: primaryColor,
  );
}

class DefaultButtonDropDownField extends StatelessWidget {
  final void Function(String?)? onChanged_;
  final String hint;
  final String? value;

  final List<String> items;
  const DefaultButtonDropDownField(
      {super.key,
      this.onChanged_,
      required this.hint,
      required this.value,
      required this.items});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: (value) => value == null ? 'Enter your $hint' : null,
      onChanged: onChanged_,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontWeight: FontWeight.normal,
        ),
        /* TODO: extract icon */
        prefixIcon: const Icon(Icons.assignment_ind_outlined),
        prefixIconColor: Colors.grey.shade500,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
      ),
      value: value,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      isExpanded: true,
      dropdownColor: Colors.grey.shade200,
    );
  }
}

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const DefaultButton(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: (const EdgeInsets.all(15)),
      color: const Color.fromRGBO(88, 129, 87, 1),
      child: child is Text
          ? DefaultTextStyle.merge(style: textStyle, child: child)
          : child,
    );
  }
}

enum ToastState { success, warning, error }

Color _stateColorPicker(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    default:
      color = Colors.white;
  }
  return color;
}

toast({
  required BuildContext context,
  required String message,
  required ToastState state,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                offset: Offset(0, 0),
              ),
            ],
            color: _stateColorPicker(state),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              message,
            ),
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 5),
      shape: const StadiumBorder(),
    ),
  );
}
