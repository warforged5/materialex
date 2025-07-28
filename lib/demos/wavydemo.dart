import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/wavy_progress_indicators.dart';

class WavyProgressIndicatorDemo extends StatefulWidget {
  const WavyProgressIndicatorDemo({super.key});

  @override
  State<WavyProgressIndicatorDemo> createState() => _WavyProgressIndicatorDemoState();
}

class _WavyProgressIndicatorDemoState extends State<WavyProgressIndicatorDemo>
    with TickerProviderStateMixin {
  double _progress = 0.5;
  bool _isAnimating = false;
  Timer? _progressTimer;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  // Customization parameters
  Color _indicatorColor = WavyProgressIndicatorDefaults.indicatorColor;
  Color _trackColor = WavyProgressIndicatorDefaults.trackColor;
  double _maxAmplitude = 1.0;
  double _wavelength = 24.0;
  double _strokeWidth = 4.0;
  
  // Amplitude transition parameters
  double _startWaveAt = 0.05;
  double _maxWaveAt = 0.15;
  double _endWaveAt = 0.85;
  double _flatAt = 0.95;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    _progressController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    setState(() {
      _isAnimating = true;
    });
    _progressController.repeat(reverse: true);
  }

  void _stopAnimation() {
    setState(() {
      _isAnimating = false;
    });
    _progressController.stop();
  }

  double _customAmplitude(double progress) {
    return WavyProgressIndicatorDefaults.indicatorAmplitude(
      progress,
      startWaveAt: _startWaveAt,
      maxWaveAt: _maxWaveAt,
      endWaveAt: _endWaveAt,
      flatAt: _flatAt,
    ) * _maxAmplitude;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material 3 Wavy Progress Indicators'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Material Design 3 Wavy Progress Indicators',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Flutter implementation of the Material Design 3 expressive wavy progress indicators. '
                      'Features smooth amplitude transitions and proper 4dp gaps between elements.',
                    ),
                    const SizedBox(height: 16),
                    _buildAnatomySection(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Controls
            _buildControlsSection(),
            const SizedBox(height: 24),

            // Amplitude Transition Controls
            _buildAmplitudeTransitionSection(),
            const SizedBox(height: 24),

            // Linear Determinate
            _buildSection(
              'Linear Determinate Progress Indicators',
              'Shows definite progress with wavy animation, proper stop indicators, and maintained 4dp gaps',
              Column(
                children: [
                  // Basic example
                  _buildExample(
                    'Basic (4dp stroke)',
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        final progress = _isAnimating ? _progressAnimation.value : _progress;
                        return LinearWavyProgressIndicator(
                          progress: progress,
                          color: _indicatorColor,
                          trackColor: _trackColor,
                          amplitude: _customAmplitude,
                          wavelength: _wavelength,
                          strokeWidth: _strokeWidth,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Thick version
                  _buildExample(
                    'Thick Version (8dp stroke)',
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        final progress = _isAnimating ? _progressAnimation.value : _progress;
                        return LinearWavyProgressIndicator(
                          progress: progress,
                          color: _indicatorColor,
                          trackColor: _trackColor,
                          strokeWidth: 8.0,
                          trackStrokeWidth: 8.0,
                          height: 24.0,
                          amplitude: _customAmplitude,
                          wavelength: _wavelength,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Wide version
                  _buildExample(
                    'Wide Version (320dp width)',
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        final progress = _isAnimating ? _progressAnimation.value : _progress;
                        return LinearWavyProgressIndicator(
                          progress: progress,
                          color: _indicatorColor,
                          trackColor: _trackColor,
                          amplitude: _customAmplitude,
                          wavelength: _wavelength,
                          strokeWidth: _strokeWidth,
                          width: 320.0,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Circular Determinate
            _buildSection(
              'Circular Determinate Progress Indicators',
              'Shows definite progress in circular form with uniform wavy animation and proper track separation at start and end',
              Column(
                children: [
                  _buildExample(
                    'Basic (48dp size)',
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        final progress = _isAnimating ? _progressAnimation.value : _progress;
                        return CircularWavyProgressIndicator(
                          progress: progress,
                          color: _indicatorColor,
                          trackColor: _trackColor,
                          amplitude: _customAmplitude,
                          wavelength: _wavelength,
                          strokeWidth: _strokeWidth,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildExample(
                    'Large Version (64dp size, 8dp stroke)',
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        final progress = _isAnimating ? _progressAnimation.value : _progress;
                        return CircularWavyProgressIndicator(
                          progress: progress,
                          color: _indicatorColor,
                          trackColor: _trackColor,
                          strokeWidth: 8.0,
                          trackStrokeWidth: 8.0,
                          size: 64.0,
                          amplitude: _customAmplitude,
                          wavelength: _wavelength,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildExample(
                    'Extra Large Version (80dp size, 6dp stroke)',
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        final progress = _isAnimating ? _progressAnimation.value : _progress;
                        return CircularWavyProgressIndicator(
                          progress: progress,
                          color: _indicatorColor,
                          trackColor: _trackColor,
                          strokeWidth: 6.0,
                          trackStrokeWidth: 6.0,
                          size: 80.0,
                          amplitude: _customAmplitude,
                          wavelength: _wavelength,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stop Indicator Scaling Demo
            _buildStopIndicatorDemonstrationSection(),
            const SizedBox(height: 24),

            // Gap Demonstration
            _buildGapDemonstrationSection(),
            const SizedBox(height: 24),

            // Amplitude Demonstration
            _buildAmplitudeDemo(),
            const SizedBox(height: 24),

            // Usage Examples
            _buildUsageSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnatomySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Color(0xFF6750A4),
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            SizedBox(width: 8),
            Text('Active indicator - The wavy progress portion'),
          ],
        ),
        const SizedBox(height: 4),
        const Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Color(0xFFE7E0EC),
              child: Text('2', style: TextStyle(color: Colors.black, fontSize: 12)),
            ),
            SizedBox(width: 8),
            Text('Track - Background with 4dp gap from active indicator'),
          ],
        ),
        const SizedBox(height: 4),
        const Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Color(0xFF6750A4),
              child: Text('3', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            SizedBox(width: 8),
            Text('Stop indicator - Primary color circle that scales with track thickness'),
          ],
        ),
      ],
    );
  }

  Widget _buildControlsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Controls',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Progress control
            Row(
              children: [
                const Text('Progress: '),
                Expanded(
                  child: Slider(
                    value: _progress,
                    onChanged: _isAnimating ? null : (value) {
                      setState(() {
                        _progress = value;
                      });
                    },
                    min: 0.0,
                    max: 1.0,
                  ),
                ),
                Text('${(_progress * 100).round()}%'),
              ],
            ),
            
            // Animation control
            Row(
              children: [
                ElevatedButton(
                  onPressed: _isAnimating ? _stopAnimation : _startAnimation,
                  child: Text(_isAnimating ? 'Stop Animation' : 'Start Animation'),
                ),
                const SizedBox(width: 16),
                if (_isAnimating)
                  const Text('Animating...', style: TextStyle(color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 16),
            
            // Max amplitude control
            Row(
              children: [
                const Text('Max Amplitude: '),
                Expanded(
                  child: Slider(
                    value: _maxAmplitude,
                    onChanged: (value) {
                      setState(() {
                        _maxAmplitude = value;
                      });
                    },
                    min: 0.0,
                    max: 1.0,
                  ),
                ),
                Text('${(_maxAmplitude * 100).round()}%'),
              ],
            ),
            
            // Wavelength control
            Row(
              children: [
                const Text('Wavelength: '),
                Expanded(
                  child: Slider(
                    value: _wavelength,
                    onChanged: (value) {
                      setState(() {
                        _wavelength = value;
                      });
                    },
                    min: 12.0,
                    max: 48.0,
                  ),
                ),
                Text('${_wavelength.round()}dp'),
              ],
            ),
            
            // Stroke width control
            Row(
              children: [
                const Text('Stroke Width: '),
                Expanded(
                  child: Slider(
                    value: _strokeWidth,
                    onChanged: (value) {
                      setState(() {
                        _strokeWidth = value;
                      });
                    },
                    min: 2.0,
                    max: 12.0,
                  ),
                ),
                Text('${_strokeWidth.round()}dp'),
              ],
            ),
            
            // Color controls
            const SizedBox(height: 16),
            Row(
              children: [
                Column(
                  children: [
                    const Text('Indicator Color'),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _showColorPicker(true),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _indicatorColor,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 32),
                Column(
                  children: [
                    const Text('Track Color'),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _showColorPicker(false),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _trackColor,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmplitudeTransitionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amplitude Transition Controls',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Control when waves start, reach maximum amplitude, and fade back to flat',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            
            // Start wave at
            Row(
              children: [
                const Text('Start waves at: '),
                Expanded(
                  child: Slider(
                    value: _startWaveAt,
                    onChanged: (value) {
                      setState(() {
                        _startWaveAt = value;
                        if (_startWaveAt >= _maxWaveAt) {
                          _maxWaveAt = _startWaveAt + 0.05;
                        }
                      });
                    },
                    min: 0.0,
                    max: 0.5,
                  ),
                ),
                Text('${(_startWaveAt * 100).round()}%'),
              ],
            ),
            
            // Max wave at
            Row(
              children: [
                const Text('Max amplitude at: '),
                Expanded(
                  child: Slider(
                    value: _maxWaveAt,
                    onChanged: (value) {
                      setState(() {
                        _maxWaveAt = value;
                        if (_maxWaveAt <= _startWaveAt) {
                          _maxWaveAt = _startWaveAt + 0.05;
                        }
                        if (_maxWaveAt >= _endWaveAt) {
                          _endWaveAt = _maxWaveAt + 0.05;
                        }
                      });
                    },
                    min: _startWaveAt + 0.05,
                    max: 0.8,
                  ),
                ),
                Text('${(_maxWaveAt * 100).round()}%'),
              ],
            ),
            
            // End wave at
            Row(
              children: [
                const Text('End waves at: '),
                Expanded(
                  child: Slider(
                    value: _endWaveAt,
                    onChanged: (value) {
                      setState(() {
                        _endWaveAt = value;
                        if (_endWaveAt <= _maxWaveAt) {
                          _endWaveAt = _maxWaveAt + 0.05;
                        }
                        if (_endWaveAt >= _flatAt) {
                          _flatAt = _endWaveAt + 0.05;
                        }
                      });
                    },
                    min: _maxWaveAt + 0.05,
                    max: 0.95,
                  ),
                ),
                Text('${(_endWaveAt * 100).round()}%'),
              ],
            ),
            
            // Flat at
            Row(
              children: [
                const Text('Back to flat at: '),
                Expanded(
                  child: Slider(
                    value: _flatAt,
                    onChanged: (value) {
                      setState(() {
                        _flatAt = value;
                        if (_flatAt <= _endWaveAt) {
                          _flatAt = _endWaveAt + 0.05;
                        }
                      });
                    },
                    min: _endWaveAt + 0.05,
                    max: 1.0,
                  ),
                ),
                Text('${(_flatAt * 100).round()}%'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStopIndicatorDemonstrationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stop Indicator Scaling',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Stop indicators automatically scale with track thickness and match the active indicator color',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            
            _buildExample(
              'Thin Track (2dp) - Small Stop Indicator',
              LinearWavyProgressIndicator(
                progress: 0.7,
                color: _indicatorColor,
                trackColor: _trackColor,
                strokeWidth: 2.0,
                trackStrokeWidth: 2.0,
                amplitude: (_) => 0.0, // No wave for clear stop view
                wavelength: _wavelength,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildExample(
              'Medium Track (6dp) - Medium Stop Indicator',
              LinearWavyProgressIndicator(
                progress: 0.7,
                color: _indicatorColor,
                trackColor: _trackColor,
                strokeWidth: 6.0,
                trackStrokeWidth: 6.0,
                amplitude: (_) => 0.0, // No wave for clear stop view
                wavelength: _wavelength,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildExample(
              'Thick Track (10dp) - Large Stop Indicator',
              LinearWavyProgressIndicator(
                progress: 0.7,
                color: _indicatorColor,
                trackColor: _trackColor,
                strokeWidth: 10.0,
                trackStrokeWidth: 10.0,
                height: 26.0,
                amplitude: (_) => 0.0, // No wave for clear stop view
                wavelength: _wavelength,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGapDemonstrationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '4dp Gap Demonstration',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Shows how the 4dp gap is maintained between active indicator and track regardless of stroke thickness',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            
            // Different stroke widths with consistent gap
            _buildExample(
              'Thin (2dp stroke) - Gap maintained',
              LinearWavyProgressIndicator(
                progress: 0.6,
                color: _indicatorColor,
                trackColor: _trackColor,
                strokeWidth: 2.0,
                trackStrokeWidth: 2.0,
                amplitude: (_) => 0.5, // Constant amplitude for clear gap view
                wavelength: _wavelength,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildExample(
              'Medium (6dp stroke) - Gap maintained',
              LinearWavyProgressIndicator(
                progress: 0.6,
                color: _indicatorColor,
                trackColor: _trackColor,
                strokeWidth: 6.0,
                trackStrokeWidth: 6.0,
                amplitude: (_) => 0.5, // Constant amplitude for clear gap view
                wavelength: _wavelength,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildExample(
              'Thick (10dp stroke) - Gap maintained',
              LinearWavyProgressIndicator(
                progress: 0.6,
                color: _indicatorColor,
                trackColor: _trackColor,
                strokeWidth: 10.0,
                trackStrokeWidth: 10.0,
                height: 26.0,
                amplitude: (_) => 0.5, // Constant amplitude for clear gap view
                wavelength: _wavelength,
              ),
            ),
            const SizedBox(height: 16),
            
            // Circular examples
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Circular - 4dp stroke'),
                    const SizedBox(height: 8),
                    CircularWavyProgressIndicator(
                      progress: 0.7,
                      color: _indicatorColor,
                      trackColor: _trackColor,
                      strokeWidth: 4.0,
                      trackStrokeWidth: 4.0,
                      amplitude: (_) => 0.5,
                      wavelength: _wavelength,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Circular - 8dp stroke'),
                    const SizedBox(height: 8),
                    CircularWavyProgressIndicator(
                      progress: 0.7,
                      color: _indicatorColor,
                      trackColor: _trackColor,
                      strokeWidth: 8.0,
                      trackStrokeWidth: 8.0,
                      size: 56.0,
                      amplitude: (_) => 0.5,
                      wavelength: _wavelength,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Circular - 12dp stroke'),
                    const SizedBox(height: 8),
                    CircularWavyProgressIndicator(
                      progress: 0.7,
                      color: _indicatorColor,
                      trackColor: _trackColor,
                      strokeWidth: 12.0,
                      trackStrokeWidth: 12.0,
                      size: 64.0,
                      amplitude: (_) => 0.5,
                      wavelength: _wavelength,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmplitudeDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amplitude Transition Demonstration',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'See how amplitude changes across different progress values',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ...List.generate(11, (index) {
              final progress = index / 10.0;
              final amplitude = _customAmplitude(progress);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text('${(progress * 100).round()}%:'),
                    ),
                    Expanded(
                      child: LinearWavyProgressIndicator(
                        progress: progress,
                        color: _indicatorColor,
                        trackColor: _trackColor,
                        amplitude: (_) => amplitude,
                        wavelength: _wavelength,
                        strokeWidth: 3.0,
                        width: 200.0,
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Text(
                        'A: ${(amplitude * 100).round()}%',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String description, Widget content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildExample(String title, Widget widget) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: widget),
        ),
      ],
    );
  }

  Widget _buildUsageSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Usage Examples',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Code example
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  '''
// Basic linear indicator with default amplitude
LinearWavyProgressIndicator(
  progress: 0.7,
  color: Colors.blue,
  trackColor: Colors.grey.shade300,
  // Stop indicator automatically matches progress color
  // 4dp gap maintained regardless of stroke width
)

// Custom amplitude function with smooth transitions
LinearWavyProgressIndicator(
  progress: 0.7,
  amplitude: (progress) => WavyProgressIndicatorDefaults.indicatorAmplitude(
    progress,
    startWaveAt: 0.1,  // Start waves at 10%
    maxWaveAt: 0.2,    // Max amplitude at 20%
    endWaveAt: 0.8,    // End waves at 80%
    flatAt: 0.9,       // Back to flat at 90%
  ),
)

// Thick linear indicator - gap automatically adjusted
LinearWavyProgressIndicator(
  progress: 0.7,
  strokeWidth: 8.0,
  trackStrokeWidth: 8.0,
  height: 24.0,
  // Gap = 4dp + (8dp/2) + (8dp/2) = 12dp total separation
)

// Circular indicator with proper track separation
CircularWavyProgressIndicator(
  progress: 0.7,
  color: Colors.blue,
  trackColor: Colors.grey.shade300,
  // Track automatically starts after 4dp gap from progress end
)

// Large circular indicator with thick strokes
CircularWavyProgressIndicator(
  progress: 0.7,
  size: 64.0,
  strokeWidth: 8.0,
  trackStrokeWidth: 8.0,
  // Gap automatically accounts for stroke thickness
)

// Key Features:
// • Stop indicator automatically scales with track thickness
// • Stop indicator always matches progress indicator color
// • 4dp gap maintained between active indicator and track edges
// • Gap calculation accounts for stroke width differences
// • Circular indicators have proper separation at start and end
// • Smooth amplitude transitions with customizable breakpoints
// • Uniform wave distribution in circular indicators
                  ''',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showColorPicker(bool isIndicator) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose ${isIndicator ? 'Indicator' : 'Track'} Color'),
          content: SizedBox(
            width: 300,
            height: 300,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: Colors.primaries.length,
              itemBuilder: (context, index) {
                final color = Colors.primaries[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isIndicator) {
                        _indicatorColor = color;
                      } else {
                        _trackColor = color.withOpacity(0.3);
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isIndicator ? color : color.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}