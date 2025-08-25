import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool enabled;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Function(DateTime?)? onDateSelected;
  final FocusNode? focusNode;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateFormat? dateFormat;

  const MyDatePicker({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.onTap,
    this.enabled = true,
    this.fillColor,
    this.contentPadding,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.onDateSelected,
    this.focusNode,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
  });

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isFocused = false;
  late FocusNode _focusNode;
  DateTime? _selectedDate;
  late DateFormat _dateFormatter;

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

    // Initialize date formatter
    _dateFormatter = widget.dateFormat ?? DateFormat('yyyy-MM-dd');

    // Initialize selected date from controller text if available
    if (widget.controller.text.isNotEmpty) {
      try {
        _selectedDate = _dateFormatter.parse(widget.controller.text);
      } catch (e) {
        // If parsing fails, keep _selectedDate as null
      }
    }
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

  Future<void> _selectDate(BuildContext context) async {
    // Call custom onTap if provided
    if (widget.onTap != null) {
      widget.onTap!();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.controller.text = _dateFormatter.format(picked);
      });

      // Call the callback if provided
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(picked);
      }
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
            validator: widget.validator,
            readOnly: true, // Always read-only for date picker
            enabled: widget.enabled,
            onTap: widget.enabled ? () => _selectDate(context) : null,
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

              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.calendar_today,
                  color: _isFocused
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withOpacity(0.5),
                  size: 22,
                ),
              ),

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

// Example usage widget
class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key});

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Picker Field Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date Picker Examples',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Basic date picker
            MyDatePicker(
              controller: _dateController,
              labelText: 'Select Date',
              hintText: 'Choose a date',
              prefixIcon: Icons.event,
              onDateSelected: (DateTime? date) {
                if (date != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected: ${DateFormat('MMM dd, yyyy').format(date)}'),
                    ),
                  );
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a date';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Birth date picker with custom format
            MyDatePicker(
              controller: _birthDateController,
              labelText: 'Birth Date',
              hintText: 'Select your birth date',
              prefixIcon: Icons.cake,
              dateFormat: DateFormat('dd/MM/yyyy'),
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
              onDateSelected: (DateTime? date) {
                print('Birth date selected: $date');
              },
            ),

            const SizedBox(height: 32),

            // Display selected values
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selected Values:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Date: ${_dateController.text.isEmpty ? 'Not selected' : _dateController.text}'),
                    Text('Birth Date: ${_birthDateController.text.isEmpty ? 'Not selected' : _birthDateController.text}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
