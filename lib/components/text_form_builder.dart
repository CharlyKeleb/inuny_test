import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TextFormBuilder extends StatefulWidget {
  final String? initialValue;
  final bool? enabled;
  final String? hintText;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final FocusNode? focusNode, nextFocusNode;
  final VoidCallback? submitAction;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String)? onSaved, onChange;
  final BorderRadius? borderRadius;
  final Widget? prefix;
  final Widget? suffix;
  final bool? hasSuffix;

  const TextFormBuilder({
    Key? key,
    this.prefix,
    this.suffix,
    this.initialValue,
    this.enabled,
    this.hintText,
    this.textInputType,
    this.controller,
    this.textInputAction,
    this.nextFocusNode,
    this.focusNode,
    this.submitAction,
    this.obscureText = false,
    this.validateFunction,
    this.onSaved,
    required this.borderRadius,
    this.onChange,
    this.hasSuffix = false,
  }) : super(key: key);

  @override
  State<TextFormBuilder> createState() => _TextFormBuilderState();
}

class _TextFormBuilderState extends State<TextFormBuilder> {
  String? error;
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 70,
          color: const Color(0xffFAFAFA),
          child: Theme(
            data: ThemeData(
              primaryColor: Theme.of(context).colorScheme.secondary,
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: Theme.of(context).colorScheme.secondary),
            ),
            child: Center(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                initialValue: widget.initialValue,
                enabled: widget.enabled,
                onChanged: (val) {
                  error = widget.validateFunction!(val);
                  setState(() {});
                  widget.onSaved!(val);
                },
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                key: widget.key,
                cursorColor: Theme.of(context).colorScheme.secondary,
                controller: widget.controller,
                obscureText: obscureText,
                keyboardType: widget.textInputType,
                validator: widget.validateFunction,
                onSaved: (val) {
                  error = widget.validateFunction!(val);
                  setState(() {});
                  widget.onSaved!(val!);
                },
                textInputAction: widget.textInputAction,
                focusNode: widget.focusNode,
                onFieldSubmitted: (String term) {
                  if (widget.nextFocusNode != null) {
                    widget.focusNode!.unfocus();
                    FocusScope.of(context).requestFocus(widget.nextFocusNode);
                  } else {
                    widget.submitAction!();
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: widget.prefix,
                  suffixIcon: widget.hasSuffix!
                      ? GestureDetector(
                          onTap: () {
                            setState(() => obscureText = !obscureText);
                          },
                          child: Icon(
                            obscureText
                                ? Ionicons.eye
                                : Ionicons.eye_off_outline,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 15.0,
                          ),
                        )
                      : const SizedBox(),
                  fillColor: const Color(0xffFAFAFA),
                  filled: true,
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: Color(0xff8C8C8C),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorStyle: const TextStyle(height: 0.0, fontSize: 0.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        Visibility(
          visible: error != null,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '$error',
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
