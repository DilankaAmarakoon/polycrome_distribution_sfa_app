import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReusableTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final bool obscureText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final bool autofocus;

  const ReusableTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.fillColor,
    this.contentPadding,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
  });

  @override
  State<ReusableTextField> createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    if (_isFocused) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            enabled: widget.enabled,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            textCapitalization: widget.textCapitalization,
            autofocus: widget.autofocus,
            style: widget.textStyle ??
                theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,

              labelStyle: widget.labelStyle ??
                  theme.textTheme.bodyMedium?.copyWith(
                    color: _isFocused
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: 0.3,
                  ),

              hintStyle: widget.hintStyle ??
                  theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.4),
                    fontSize: 14,
                    letterSpacing: 0.2,
                  ),

              filled: true,
              fillColor: widget.fillColor ??
                  (widget.enabled ? Colors.white : Colors.grey.shade50),

              contentPadding: widget.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: Icon(
                  widget.prefixIcon,
                  color: _isFocused
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withOpacity(0.5),
                  size: 22,
                ),
              )
                  : null,

              suffixIcon: widget.suffixIcon != null
                  ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: widget.onSuffixIconTap,
                  child: Icon(
                    widget.suffixIcon,
                    color: _isFocused
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface.withOpacity(0.5),
                    size: 22,
                  ),
                ),
              )
                  : null,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.5,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.5,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2.0,
                ),
              ),

              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFE57373),
                  width: 1.5,
                ),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFE57373),
                  width: 2.0,
                ),
              ),

              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1.5,
                ),
              ),

              errorStyle: theme.textTheme.bodySmall?.copyWith(
                color: const Color(0xFFE57373),
                fontSize: 12,
                letterSpacing: 0.3,
              ),
            ),
          );
        },
      ),
    );
  }
}