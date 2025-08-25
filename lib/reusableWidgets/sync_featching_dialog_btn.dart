import 'package:flutter/material.dart';

class SyncDialog extends StatefulWidget {
  final String message;
  final String syncType;
  final bool showProgress;
  final double? progress;

  const SyncDialog({
    super.key,
    required this.message,
    required this.syncType,
    this.showProgress = false,
    this.progress,
  });

  @override
  State<SyncDialog> createState() => _SyncDialogState();
}

class _SyncDialogState extends State<SyncDialog>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _fadeController;

  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    _rotationController.repeat();
    _scaleController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  IconData _getIcon() {
    switch (widget.syncType.toLowerCase()) {
      case 'sync':
        return Icons.sync_rounded;
      case 'download':
        return Icons.cloud_download_rounded;
      case 'upload':
        return Icons.cloud_upload_rounded;
      case 'load':
        return Icons.hourglass_top_rounded;
      case 'processing':
        return Icons.settings_rounded;
      default:
        return Icons.sync_rounded;
    }
  }

  Color _getIconColor() {
    switch (widget.syncType.toLowerCase()) {
      case 'sync':
        return const Color(0xFF2196F3);
      case 'download':
        return const Color(0xFF4CAF50);
      case 'upload':
        return const Color(0xFFFF9800);
      case 'load':
        return const Color(0xFF9C27B0);
      case 'processing':
        return const Color(0xFF607D8B);
      default:
        return const Color(0xFF2196F3);
    }
  }

  String _getTitle() {
    switch (widget.syncType.toLowerCase()) {
      case 'sync':
        return 'Synchronizing...';
      case 'download':
        return 'Downloading...';
      case 'upload':
        return 'Uploading...';
      case 'load':
        return 'Loading...';
      case 'processing':
        return 'Processing...';
      default:
        return 'Please wait...';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 320),
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon and Animation Section
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _getIconColor().withOpacity(0.1),
                        _getIconColor().withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: _getIconColor().withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer rotating ring
                      RotationTransition(
                        turns: _rotationAnimation,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _getIconColor().withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: CustomPaint(
                            painter: _CircularProgressPainter(
                              color: _getIconColor(),
                              progress: 0.3,
                            ),
                          ),
                        ),
                      ),

                      // Center icon
                      Icon(
                        _getIcon(),
                        color: _getIconColor(),
                        size: 32,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Title
                Text(
                  _getTitle(),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                // Message
                Container(
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: SingleChildScrollView(
                    child: Text(
                      widget.message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        height: 1.4,
                        letterSpacing: 0.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // Progress bar (if enabled)
                if (widget.showProgress) ...[
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: widget.progress ?? 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _getIconColor(),
                              _getIconColor().withOpacity(0.7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '${((widget.progress ?? 0.0) * 100).toInt()}%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _getIconColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // Pulsing dots animation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) =>
                      AnimatedBuilder(
                        animation: _rotationController,
                        builder: (context, child) {
                          final delay = index * 0.3;
                          final animationValue = (_rotationController.value + delay) % 1.0;
                          final opacity = (0.3 + (0.7 * (1.0 - (animationValue - 0.5).abs() * 2))).clamp(0.3, 1.0);

                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getIconColor().withOpacity(opacity),
                              shape: BoxShape.circle,
                            ),
                          );
                        },
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final Color color;
  final double progress;

  _CircularProgressPainter({
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * 3.14159 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 1.5),
      -3.14159 / 2,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}