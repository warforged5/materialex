// lib/wavy_progress_indicators.dart

import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Material Design 3 wavy progress indicators implementation
/// Mimics the Jetpack Compose ExpressiveApi progress indicators

// Animation specifications matching Compose implementation
class _MotionTokens {
  static const Duration durationLong2 = Duration(milliseconds: 500);
  static const Cubic easingLinear = Cubic(0.0, 0.0, 1.0, 1.0);
  static const Cubic easingStandard = Cubic(0.2, 0.0, 0.0, 1.0);
  static const Cubic easingEmphasizedAccelerate = Cubic(0.3, 0.0, 0.8, 0.15);
}

/// Default values for wavy progress indicators
class WavyProgressIndicatorDefaults {
  // Colors
  static const Color indicatorColor = Color(0xFF6750A4); // Primary color
  static const Color trackColor = Color(0xFFE7E0EC); // Surface variant

  // Stroke configurations
  static const double linearActiveThickness = 4.0;
  static const double linearTrackThickness = 4.0;
  static const double circularActiveThickness = 4.0;
  static const double circularTrackThickness = 4.0;

  // Container sizes
  static const double linearContainerHeight = 16.0;
  static const double linearContainerWidth = 240.0;
  static const double circularContainerSize = 48.0;

  // Wave properties
  static const double linearDeterminateWavelength = 24.0;
  static const double circularWavelength = 24.0;

  // Gap sizes - exactly 4dp as per Material Design
  static const double indicatorTrackGapSize = 4.0;

  // Stop indicator - should scale with track thickness
 

  /// Default stop indicator size that scales with track stroke width
  static double getStopSize(double trackStrokeWidth) {
    return math.max(trackStrokeWidth, 4.0); // At least 4dp, but scales with track
  }

  /// Default amplitude function for determinate indicators
  /// Smoothly transitions from flat to wavy and back to flat
  static double indicatorAmplitude(double progress, {
    double startWaveAt = 0.05, // Start waves at 5%
    double maxWaveAt = 0.15,   // Max amplitude at 15%
    double endWaveAt = 0.85,   // Keep max until 85%
    double flatAt = 0.95,      // Back to flat at 95%
  }) {
    if (progress <= startWaveAt) {
      return 0.0;
    } else if (progress <= maxWaveAt) {
      // Smooth transition from 0 to 1
      final t = (progress - startWaveAt) / (maxWaveAt - startWaveAt);
      return _smoothStep(t);
    } else if (progress <= endWaveAt) {
      return 1.0;
    } else if (progress <= flatAt) {
      // Smooth transition from 1 to 0
      final t = (progress - endWaveAt) / (flatAt - endWaveAt);
      return 1.0 - _smoothStep(t);
    } else {
      return 0.0;
    }
  }

  /// Smooth step function for smooth amplitude transitions
  static double _smoothStep(double t) {
    return t * t * (3.0 - 2.0 * t);
  }
}

/// Linear wavy progress indicator (determinate)
class LinearWavyProgressIndicator extends StatefulWidget {
  const LinearWavyProgressIndicator({
    super.key,
    required this.progress,
    this.color = WavyProgressIndicatorDefaults.indicatorColor,
    this.trackColor = WavyProgressIndicatorDefaults.trackColor,
    this.strokeWidth = WavyProgressIndicatorDefaults.linearActiveThickness,
    this.trackStrokeWidth = WavyProgressIndicatorDefaults.linearTrackThickness,
    this.gapSize = WavyProgressIndicatorDefaults.indicatorTrackGapSize,
    this.stopSize, // Will default to scaling with track width if null
    this.amplitude = WavyProgressIndicatorDefaults.indicatorAmplitude,
    this.wavelength = WavyProgressIndicatorDefaults.linearDeterminateWavelength,
    this.waveSpeed = WavyProgressIndicatorDefaults.linearDeterminateWavelength,
    this.width = WavyProgressIndicatorDefaults.linearContainerWidth,
    this.height = WavyProgressIndicatorDefaults.linearContainerHeight,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;
  final double trackStrokeWidth;
  final double gapSize;
  final double? stopSize; // Nullable - will scale with track if null
  final double Function(double progress) amplitude;
  final double wavelength;
  final double waveSpeed; // pixels per second
  final double width;
  final double height;

  @override
  State<LinearWavyProgressIndicator> createState() => _LinearWavyProgressIndicatorState();
}

class _LinearWavyProgressIndicatorState extends State<LinearWavyProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: Duration(milliseconds: (widget.wavelength / widget.waveSpeed * 1000).round()),
      vsync: this,
    )..repeat();
    _waveAnimation = Tween<double>(begin: 0, end: 1).animate(_waveController);
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Semantics(
        value: '${(widget.progress.clamp(0.0, 1.0) * 100).round()}%',
        child: AnimatedBuilder(
          animation: _waveAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: LinearWavyProgressPainter(
                progress: widget.progress.clamp(0.0, 1.0),
                color: widget.color,
                trackColor: widget.trackColor,
                strokeWidth: widget.strokeWidth,
                trackStrokeWidth: widget.trackStrokeWidth,
                gapSize: widget.gapSize,
                stopSize: widget.stopSize ?? WavyProgressIndicatorDefaults.getStopSize(widget.trackStrokeWidth),
                amplitude: widget.amplitude(widget.progress.clamp(0.0, 1.0)),
                wavelength: widget.wavelength,
                waveOffset: _waveAnimation.value * widget.wavelength,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Circular wavy progress indicator (determinate)
class CircularWavyProgressIndicator extends StatefulWidget {
  const CircularWavyProgressIndicator({
    super.key,
    required this.progress,
    this.color = WavyProgressIndicatorDefaults.indicatorColor,
    this.trackColor = WavyProgressIndicatorDefaults.trackColor,
    this.strokeWidth = WavyProgressIndicatorDefaults.circularActiveThickness,
    this.trackStrokeWidth = WavyProgressIndicatorDefaults.circularTrackThickness,
    this.gapSize = WavyProgressIndicatorDefaults.indicatorTrackGapSize,
    this.amplitude = WavyProgressIndicatorDefaults.indicatorAmplitude,
    this.wavelength = WavyProgressIndicatorDefaults.circularWavelength,
    this.waveSpeed = WavyProgressIndicatorDefaults.circularWavelength,
    this.size = WavyProgressIndicatorDefaults.circularContainerSize,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;
  final double trackStrokeWidth;
  final double gapSize;
  final double Function(double progress) amplitude;
  final double wavelength;
  final double waveSpeed;
  final double size;

  @override
  State<CircularWavyProgressIndicator> createState() => _CircularWavyProgressIndicatorState();
}

class _CircularWavyProgressIndicatorState extends State<CircularWavyProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: Duration(milliseconds: (widget.wavelength / widget.waveSpeed * 1000).round()),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Semantics(
        value: '${(widget.progress.clamp(0.0, 1.0) * 100).round()}%',
        child: AnimatedBuilder(
          animation: _waveController,
          builder: (context, child) {
            return CustomPaint(
              painter: CircularWavyProgressPainter(
                progress: widget.progress.clamp(0.0, 1.0),
                color: widget.color,
                trackColor: widget.trackColor,
                strokeWidth: widget.strokeWidth,
                trackStrokeWidth: widget.trackStrokeWidth,
                gapSize: widget.gapSize,
                amplitude: widget.amplitude(widget.progress.clamp(0.0, 1.0)),
                wavelength: widget.wavelength,
                waveOffset: _waveController.value * widget.wavelength,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Custom painter for linear wavy progress (determinate)
class LinearWavyProgressPainter extends CustomPainter {
  LinearWavyProgressPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
    required this.trackStrokeWidth,
    required this.gapSize,
    required this.stopSize,
    required this.amplitude,
    required this.wavelength,
    required this.waveOffset,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;
  final double trackStrokeWidth;
  final double gapSize;
  final double stopSize;
  final double amplitude;
  final double wavelength;
  final double waveOffset;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.height / 2;
    final progressWidth = size.width * progress;
    final stopIndicatorX = size.width - stopSize / 2;

    // Calculate proper gap accounting for stroke widths
    // Gap should be measured from edge to edge of strokes
    final effectiveGap = gapSize + (strokeWidth / 2) + (trackStrokeWidth / 2);

    // Draw track (only the visible portion after gap)
    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = trackStrokeWidth
      ..strokeCap = StrokeCap.round;

    // Calculate track start position (after gap and progress)
    final trackStartX = math.max(progressWidth + effectiveGap, 0.0);
    final trackEndX = stopIndicatorX - stopSize / 2;

    if (trackStartX < trackEndX) {
      canvas.drawLine(
        Offset(trackStartX, center),
        Offset(trackEndX, center),
        trackPaint,
      );
    }

    // Draw stop indicator (small circle at the end) - same color as active indicator
    final stopPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(stopIndicatorX, center),
      stopSize / 2,
      stopPaint,
    );

    // Draw progress indicator with wave
    if (progressWidth > 0) {
      final progressPaint = Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final path = Path();
      const resolution = 1.0; // Higher resolution for smoother curves

      bool pathStarted = false;
      for (double x = 0; x <= progressWidth; x += resolution) {
        final waveY = amplitude > 0
            ? amplitude * (size.height / 4) * math.sin(2 * math.pi * (x + waveOffset) / wavelength)
            : 0.0;
        final y = center + waveY;

        if (!pathStarted) {
          path.moveTo(x, y);
          pathStarted = true;
        } else {
          path.lineTo(x, y);
        }
      }

      // Ensure the path ends exactly at progressWidth
      if (pathStarted && progressWidth > resolution) {
        final finalWaveY = amplitude > 0
            ? amplitude * (size.height / 4) * math.sin(2 * math.pi * (progressWidth + waveOffset) / wavelength)
            : 0.0;
        path.lineTo(progressWidth, center + finalWaveY);
      }

      canvas.drawPath(path, progressPaint);
    }
  }

  @override
  bool shouldRepaint(LinearWavyProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.amplitude != amplitude ||
        oldDelegate.waveOffset != waveOffset ||
        oldDelegate.color != color ||
        oldDelegate.trackColor != trackColor;
  }
}

/// Custom painter for circular wavy progress (determinate)
class CircularWavyProgressPainter extends CustomPainter {
  CircularWavyProgressPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
    required this.trackStrokeWidth,
    required this.gapSize,
    required this.amplitude,
    required this.wavelength,
    required this.waveOffset,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;
  final double trackStrokeWidth;
  final double gapSize;
  final double amplitude;
  final double wavelength;
  final double waveOffset;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - math.max(strokeWidth, trackStrokeWidth)) / 2;
    final circumference = 2 * math.pi * radius;

    // Adjust wavelength to ensure uniform wave distribution
    final adjustedWavelength = _getAdjustedWavelength(circumference, wavelength);
    
    // Calculate effective gap in radians accounting for stroke widths
    final effectiveGapDistance = gapSize + (strokeWidth / 2) + (trackStrokeWidth / 2);
    final gapAngle = effectiveGapDistance / radius;
    
    // Draw progress arc with uniform waves first
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final sweepAngle = 2 * math.pi * progress;
      final path = Path();

      // Calculate number of points for smooth curve (higher resolution for circles)
      final totalArcLength = sweepAngle * radius;
      final resolution = math.max(200, (totalArcLength * 2).round()); // Adaptive resolution
      final angleStep = sweepAngle / resolution;

      bool pathStarted = false;
      for (int i = 0; i <= resolution; i++) {
        final angle = -math.pi / 2 + i * angleStep; // Start from top (-90 degrees)
        final arcLength = i * angleStep * radius;
        
        // Calculate wave amplitude with uniform distribution
        final waveAmplitude = amplitude > 0
            ? amplitude * (strokeWidth * 0.75) * math.sin(2 * math.pi * (arcLength + waveOffset) / adjustedWavelength)
            : 0.0;
        
        final currentRadius = radius + waveAmplitude;
        final x = center.dx + currentRadius * math.cos(angle);
        final y = center.dy + currentRadius * math.sin(angle);

        if (!pathStarted) {
          path.moveTo(x, y);
          pathStarted = true;
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(path, progressPaint);
    }

    // Draw track (arc from progress end + gap to progress start - gap)
    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = trackStrokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    if (progress < 1.0) {
      final progressSweepAngle = 2 * math.pi * progress;
      
      // Track starts after gap from progress end and ends before gap from progress start
      final trackStartAngle = -math.pi / 2 + progressSweepAngle + gapAngle;
      final trackEndAngle = -math.pi / 2 - gapAngle; // Just before progress start
      
      // Calculate track sweep angle (going around the remaining circle)
      var trackSweepAngle = trackEndAngle - trackStartAngle;
      
      // Handle wrap-around case
      if (trackSweepAngle < 0) {
        trackSweepAngle += 2 * math.pi;
      }
      
      // Only draw track if there's space for it (progress + gaps < full circle)
      if (trackSweepAngle > 0 && progressSweepAngle + (2 * gapAngle) < 2 * math.pi) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          trackStartAngle,
          trackSweepAngle,
          false,
          trackPaint,
        );
      }
    }
  }

  /// Adjust wavelength to ensure uniform wave distribution around the circle
  double _getAdjustedWavelength(double circumference, double desiredWavelength) {
    final numberOfWaves = (circumference / desiredWavelength).round();
    if (numberOfWaves == 0) return circumference;
    return circumference / numberOfWaves;
  }

  @override
  bool shouldRepaint(CircularWavyProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.amplitude != amplitude ||
        oldDelegate.waveOffset != waveOffset ||
        oldDelegate.color != color ||
        oldDelegate.trackColor != trackColor;
  }
}