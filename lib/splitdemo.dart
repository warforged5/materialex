// lib/demo/split_buttons_demo.dart

import 'package:flutter/material.dart';
import '../widgets/split_buttons.dart';


class SplitButtonsDemo extends StatefulWidget {
  const SplitButtonsDemo({super.key});

  @override
  State<SplitButtonsDemo> createState() => _SplitButtonsDemoState();
}

class _SplitButtonsDemoState extends State<SplitButtonsDemo> {
  bool _isChecked = false;
  bool _isEnabled = true;
  double _selectedHeight = SplitButtonDefaults.mediumContainerHeight;
  String _selectedStyle = 'Filled';
  bool _showWithText = true;
  bool _showWithIcon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material 3 Split Buttons'),
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
                      'Material Design 3 Split Buttons',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Split buttons consist of two connected buttons: a leading button for primary actions '
                      'and a trailing button for secondary actions. The buttons share corners and maintain '
                      'visual connection while providing distinct interaction areas. This implementation uses '
                      'official Material Design 3 tokens for accurate sizing, spacing, and proportions.',
                    ),
                    const SizedBox(height: 16),
                    _buildAnatomySection(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Interactive Controls
            _buildControlsSection(),
            const SizedBox(height: 24),

            // Size Variants
            _buildSizeVariantsSection(),
            const SizedBox(height: 24),

            // Style Variants
            _buildStyleVariantsSection(),
            const SizedBox(height: 24),

            // Content Variants
            _buildContentVariantsSection(),
            const SizedBox(height: 24),

            // Interactive Examples
            _buildInteractiveExamplesSection(),
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
        const Text('• Leading Button - Primary action (left side, pill-shaped start)'),
        const Text('• Trailing Button - Secondary action (right side, typically icon-only)'),
        const Text('• Inner Corners - Smaller radius where buttons connect'),
        const Text('• Outer Corners - Full radius on outside edges'),
        const Text('• 2dp Spacing - Gap between the two buttons'),
        const SizedBox(height: 12),
        // Visual example
        Center(
          child: SplitButtonLayout(
            leadingButton: SplitButtonDefaults.leadingButton(
              onPressed: () {},
              height: SplitButtonDefaults.mediumContainerHeight,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.download, size: 20),
                  SizedBox(width: 8),
                  Text('Download'),
                ],
              ),
            ),
            trailingButton: SplitButtonDefaults.trailingButton(
              onPressed: () {},
              height: SplitButtonDefaults.mediumContainerHeight,
              child: const Icon(Icons.keyboard_arrow_down, size: 26),
            ),
          ),
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
              'Interactive Controls',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Enabled/Disabled toggle
            SwitchListTile(
              title: const Text('Enabled'),
              value: _isEnabled,
              onChanged: (value) {
                setState(() {
                  _isEnabled = value;
                });
              },
            ),
            
            // Checked toggle for trailing button
            SwitchListTile(
              title: const Text('Trailing Button Checked'),
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value;
                });
              },
            ),
            
            // Height selection
            const SizedBox(height: 16),
            Text('Button Height:', style: Theme.of(context).textTheme.titleMedium),
            DropdownButton<double>(
              value: _selectedHeight,
              onChanged: (value) {
                setState(() {
                  _selectedHeight = value!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: SplitButtonDefaults.extraSmallContainerHeight,
                  child: Text('Extra Small (32dp)'),
                ),
                DropdownMenuItem(
                  value: SplitButtonDefaults.smallContainerHeight,
                  child: Text('Small (40dp)'),
                ),
                DropdownMenuItem(
                  value: SplitButtonDefaults.mediumContainerHeight,
                  child: Text('Medium (56dp)'),
                ),
                DropdownMenuItem(
                  value: SplitButtonDefaults.largeContainerHeight,
                  child: Text('Large (96dp)'),
                ),
                DropdownMenuItem(
                  value: SplitButtonDefaults.extraLargeContainerHeight,
                  child: Text('Extra Large (136dp)'),
                ),
              ],
            ),
            
            // Style selection
            const SizedBox(height: 16),
            Text('Button Style:', style: Theme.of(context).textTheme.titleMedium),
            DropdownButton<String>(
              value: _selectedStyle,
              onChanged: (value) {
                setState(() {
                  _selectedStyle = value!;
                });
              },
              items: const [
                DropdownMenuItem(value: 'Filled', child: Text('Filled')),
                DropdownMenuItem(value: 'Tonal', child: Text('Tonal')),
                DropdownMenuItem(value: 'Outlined', child: Text('Outlined')),
                DropdownMenuItem(value: 'Elevated', child: Text('Elevated')),
              ],
            ),
            
            // Content toggles
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Show Text'),
              value: _showWithText,
              onChanged: (value) {
                setState(() {
                  _showWithText = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Show Icon'),
              value: _showWithIcon,
              onChanged: (value) {
                setState(() {
                  _showWithIcon = value!;
                });
              },
            ),
            
            const SizedBox(height: 16),
            Text('Live Preview:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Center(
              child: _buildCustomSplitButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomSplitButton() {
    Widget leadingContent = Container();
    if (_showWithIcon && _showWithText) {
      leadingContent = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.save, size: SplitButtonDefaults.leadingButtonIconSizeFor(_selectedHeight)),
          const SizedBox(width: 8),
          const Text('Save'),
        ],
      );
    } else if (_showWithIcon) {
      leadingContent = Icon(Icons.save, size: SplitButtonDefaults.leadingButtonIconSizeFor(_selectedHeight));
    } else if (_showWithText) {
      leadingContent = const Text('Save');
    }

    Widget trailingContent = Icon(
      Icons.keyboard_arrow_down,
      size: SplitButtonDefaults.trailingButtonIconSizeFor(_selectedHeight),
    );

    return SplitButtonLayout(
      leadingButton: _createLeadingButton(leadingContent),
      trailingButton: _createTrailingButton(trailingContent),
    );
  }

  Widget _createLeadingButton(Widget child) {
    switch (_selectedStyle) {
      case 'Tonal':
        return SplitButtonDefaults.tonalLeadingButton(
          onPressed: () {},
          height: _selectedHeight,
          enabled: _isEnabled,
          child: child,
        );
      case 'Outlined':
        return SplitButtonDefaults.outlinedLeadingButton(
          onPressed: () {},
          height: _selectedHeight,
          enabled: _isEnabled,
          child: child,
        );
      case 'Elevated':
        return SplitButtonDefaults.elevatedLeadingButton(
          onPressed: () {},
          height: _selectedHeight,
          enabled: _isEnabled,
          child: child,
        );
      default: // Filled
        return SplitButtonDefaults.leadingButton(
          onPressed: () {},
          height: _selectedHeight,
          enabled: _isEnabled,
          child: child,
        );
    }
  }

  Widget _createTrailingButton(Widget child) {
    switch (_selectedStyle) {
      case 'Tonal':
        return SplitButtonDefaults.tonalTrailingButton(
          onPressed: () {},
          height: _selectedHeight,
          enabled: _isEnabled,
          checked: _isChecked,
          child: child,
        );
      case 'Outlined':
        return SplitButtonDefaults.outlinedTrailingButton(
          onPressed: () {},
          height: _selectedHeight,
          enabled: _isEnabled,
          checked: _isChecked,
          child: child,
        );
      case 'Elevated':
        return SplitButtonDefaults.elevatedTrailingButton(
          onPressed: () {},
          height: _selectedHeight,
          enabled: _isEnabled,
          checked: _isChecked,
          child: child,
        );
      default: // Filled
        return SplitButtonDefaults.trailingButton(
          onPressed: () {},
          height: _selectedHeight,
          enabled: _isEnabled,
          checked: _isChecked,
          child: child,
        );
    }
  }

  Widget _buildSizeVariantsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Size Variants',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            _buildSizeExample('Extra Small (32dp)', SplitButtonDefaults.extraSmallContainerHeight),
            const SizedBox(height: 12),
            _buildSizeExample('Small (40dp)', SplitButtonDefaults.smallContainerHeight),
            const SizedBox(height: 12),
            _buildSizeExample('Medium (56dp)', SplitButtonDefaults.mediumContainerHeight),
            const SizedBox(height: 12),
            _buildSizeExample('Large (96dp)', SplitButtonDefaults.largeContainerHeight),
            const SizedBox(height: 12),
            _buildSizeExample('Extra Large (136dp)', SplitButtonDefaults.extraLargeContainerHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeExample(String title, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SplitButtonLayout(
          leadingButton: SplitButtonDefaults.leadingButton(
            onPressed: () {},
            height: height,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.download, size: SplitButtonDefaults.leadingButtonIconSizeFor(height)),
                const SizedBox(width: 8),
                const Text('Download'),
              ],
            ),
          ),
          trailingButton: SplitButtonDefaults.trailingButton(
            onPressed: () {},
            height: height,
            child: Icon(Icons.keyboard_arrow_down, size: SplitButtonDefaults.trailingButtonIconSizeFor(height)),
          ),
        ),
      ],
    );
  }

  Widget _buildStyleVariantsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Style Variants',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            _buildStyleExample('Filled (High Emphasis)', _createFilledSplitButton()),
            const SizedBox(height: 16),
            _buildStyleExample('Tonal (Medium Emphasis)', _createTonalSplitButton()),
            const SizedBox(height: 16),
            _buildStyleExample('Outlined (Medium Emphasis)', _createOutlinedSplitButton()),
            const SizedBox(height: 16),
            _buildStyleExample('Elevated (Medium Emphasis)', _createElevatedSplitButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildStyleExample(String title, Widget button) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        button,
      ],
    );
  }

  Widget _createFilledSplitButton() {
    return SplitButtonLayout(
      leadingButton: SplitButtonDefaults.leadingButton(
        onPressed: () {},
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.send, size: 18),
            SizedBox(width: 8),
            Text('Send'),
          ],
        ),
      ),
      trailingButton: SplitButtonDefaults.trailingButton(
        onPressed: () {},
        child: const Icon(Icons.keyboard_arrow_down, size: 18),
      ),
    );
  }

  Widget _createTonalSplitButton() {
    return SplitButtonLayout(
      leadingButton: SplitButtonDefaults.tonalLeadingButton(
        onPressed: () {},
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit, size: 18),
            SizedBox(width: 8),
            Text('Edit'),
          ],
        ),
      ),
      trailingButton: SplitButtonDefaults.tonalTrailingButton(
        onPressed: () {},
        child: const Icon(Icons.keyboard_arrow_down, size: 18),
      ),
    );
  }

  Widget _createOutlinedSplitButton() {
    return SplitButtonLayout(
      leadingButton: SplitButtonDefaults.outlinedLeadingButton(
        onPressed: () {},
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.share, size: 18),
            SizedBox(width: 8),
            Text('Share'),
          ],
        ),
      ),
      trailingButton: SplitButtonDefaults.outlinedTrailingButton(
        onPressed: () {},
        child: const Icon(Icons.keyboard_arrow_down, size: 18),
      ),
    );
  }

  Widget _createElevatedSplitButton() {
    return SplitButtonLayout(
      leadingButton: SplitButtonDefaults.elevatedLeadingButton(
        onPressed: () {},
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.upload, size: 18),
            SizedBox(width: 8),
            Text('Upload'),
          ],
        ),
      ),
      trailingButton: SplitButtonDefaults.elevatedTrailingButton(
        onPressed: () {},
        child: const Icon(Icons.keyboard_arrow_down, size: 18),
      ),
    );
  }

  Widget _buildContentVariantsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Content Variants',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            _buildContentExample(
              'Icon + Text Leading, Icon Trailing',
              SplitButtonLayout(
                leadingButton: SplitButtonDefaults.leadingButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite, size: 18),
                      SizedBox(width: 8),
                      Text('Like'),
                    ],
                  ),
                ),
                trailingButton: SplitButtonDefaults.trailingButton(
                  onPressed: () {},
                  child: const Icon(Icons.more_vert, size: 18),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            _buildContentExample(
              'Text Only Leading, Icon Trailing',
              SplitButtonLayout(
                leadingButton: SplitButtonDefaults.leadingButton(
                  onPressed: () {},
                  child: const Text('Save Document'),
                ),
                trailingButton: SplitButtonDefaults.trailingButton(
                  onPressed: () {},
                  child: const Icon(Icons.keyboard_arrow_down, size: 18),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            _buildContentExample(
              'Icon Only Leading, Icon Trailing',
              SplitButtonLayout(
                leadingButton: SplitButtonDefaults.leadingButton(
                  onPressed: () {},
                  child: const Icon(Icons.print, size: 18),
                ),
                trailingButton: SplitButtonDefaults.trailingButton(
                  onPressed: () {},
                  child: const Icon(Icons.settings, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentExample(String title, Widget button) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        button,
      ],
    );
  }

  Widget _buildInteractiveExamplesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interactive Examples',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text('Tap buttons to see shape morphing and interaction states'),
            const SizedBox(height: 16),
            
            _buildInteractiveExample(),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveExample() {
    return StatefulBuilder(
      builder: (context, setState) {
        bool localChecked = false;
        
        return Column(
          children: [
            SplitButtonLayout(
              leadingButton: SplitButtonDefaults.leadingButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Leading button pressed!')),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow, size: 18),
                    SizedBox(width: 8),
                    Text('Play'),
                  ],
                ),
              ),
              trailingButton: SplitButtonDefaults.trailingButton(
                onPressed: () {
                  setState(() {
                    localChecked = !localChecked;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Trailing button ${localChecked ? 'checked' : 'unchecked'}!')),
                  );
                },
                checked: localChecked,
                child: Icon(
                  localChecked ? Icons.check : Icons.more_vert,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Trailing button is ${localChecked ? 'checked (circular)' : 'unchecked (rounded)'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        );
      },
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
// Basic split button (using official Material 3 tokens)
SplitButtonLayout(
  leadingButton: SplitButtonDefaults.leadingButton(
    onPressed: () => print('Primary action'),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.download),
        SizedBox(width: 8),
        Text('Download'),
      ],
    ),
  ),
  trailingButton: SplitButtonDefaults.trailingButton(
    onPressed: () => print('Secondary action'),
    child: Icon(Icons.keyboard_arrow_down),
  ),
)

// Tonal split button with custom height
SplitButtonLayout(
  leadingButton: SplitButtonDefaults.tonalLeadingButton(
    onPressed: () => print('Edit'),
    height: SplitButtonDefaults.largeContainerHeight, // 96dp
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.edit),
        SizedBox(width: 8),
        Text('Edit'),
      ],
    ),
  ),
  trailingButton: SplitButtonDefaults.tonalTrailingButton(
    onPressed: () => toggleMenu(),
    height: SplitButtonDefaults.largeContainerHeight, // 96dp
    checked: isMenuOpen,
    child: Icon(Icons.more_vert),
  ),
)

// Different size variants (from official Material 3 tokens)
SplitButtonDefaults.extraSmallContainerHeight  // 32dp
SplitButtonDefaults.smallContainerHeight       // 40dp
SplitButtonDefaults.mediumContainerHeight      // 56dp
SplitButtonDefaults.largeContainerHeight       // 96dp
SplitButtonDefaults.extraLargeContainerHeight  // 136dp

// Different style variants
SplitButtonDefaults.leadingButton()          // Filled (high emphasis)
SplitButtonDefaults.tonalLeadingButton()     // Tonal (medium emphasis)
SplitButtonDefaults.outlinedLeadingButton()  // Outlined (medium emphasis)
SplitButtonDefaults.elevatedLeadingButton()  // Elevated (medium emphasis)

// Key Features:
// • Uses official Material Design 3 tokens for precise sizing
// • Automatic scaling of icons, padding, and corner radii
// • Shape morphing animations matching Jetpack Compose
// • Full Material 3 theming support across all variants
// • 2dp spacing with complex corner radius calculations
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
}
