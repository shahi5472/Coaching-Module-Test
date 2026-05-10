import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../utils/constansts/dimentions.dart';
import '../../../../utils/manager/extensions/build_context_extension.dart';
import '../../../../utils/manager/extensions/font_utils_extensions.dart';

class CustomTextFormView extends StatelessWidget {
  const CustomTextFormView({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.hintText,
    this.title = "",
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.readOnly = false,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.fillColor,
    this.maxLines = 1,
    this.minLines,
    this.customErrorMessage,
  });

  final String title;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool readOnly;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final int? maxLines;
  final int? minLines;
  final String? customErrorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: defaultPadding / 2,
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        if (title.isNotEmpty) ...[
          Text(
            title,
            style: context.labelLarge,
          ),
        ],
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          readOnly: readOnly,
          onChanged: onChanged,
          onSaved: onSaved,
          validator: validator,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          minLines: minLines,
          decoration: InputDecoration(
            fillColor: fillColor,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
        if ((customErrorMessage ?? "").isNotEmpty) ...[
          Text(
            customErrorMessage ?? "",
            style: context.theme.inputDecorationTheme.errorStyle,
          ),
        ],
      ],
    );
  }
}
