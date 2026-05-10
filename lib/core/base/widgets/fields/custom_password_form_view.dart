import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../utils/constansts/dimentions.dart';
import '../../../../utils/manager/extensions/font_utils_extensions.dart';

class CustomPasswordFormView extends StatefulWidget {
  const CustomPasswordFormView({
    super.key,
    this.controller,
    this.hintText,
    this.title = "",
    this.readOnly = false,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.fillColor,
    this.maxLines = 1,
    this.minLines,
  });

  final String title;
  final TextEditingController? controller;
  final String? hintText;
  final bool readOnly;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final int? maxLines;
  final int? minLines;

  @override
  State<CustomPasswordFormView> createState() => _CustomPasswordFormViewState();
}

class _CustomPasswordFormViewState extends State<CustomPasswordFormView> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: defaultPadding / 2,
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        if (widget.title.isNotEmpty) ...[
          Text(
            widget.title,
            style: context.labelLarge,
          ),
        ],
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          readOnly: widget.readOnly,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          obscureText: isVisible,
          decoration: InputDecoration(
            fillColor: widget.fillColor,
            hintText: widget.hintText,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
      ],
    );
  }
}
