# Material 3 Expressive FAB Menu

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Material 3](https://img.shields.io/badge/Material%203-Expressive-blue?style=for-the-badge)](https://m3.material.io/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

A Flutter package providing **Material 3 Expressive FAB Menus** that closely match the official Jetpack Compose implementation. Features smooth staggered animations, intelligent scrolling, morphing transformations, and comprehensive theming support.

## ✨ Features

### 🎯 **Material 3 Expressive Design**
- **Official Specification**: Matches Google's Material 3 Expressive FAB Menu design
- **Jetpack Compose Parity**: Ported directly from the official Android implementation
- **Design Tokens**: Uses proper Material 3 spacing, elevation, and corner radius values

### 🎨 **Comprehensive Theming**
- **Color Schemes**: Primary, Secondary, and Tertiary color support
- **Dynamic Colors**: Automatic color scheme adaptation
- **Custom Styling**: Full control over colors, sizes, and animations

### ⚡ **Smooth Animations**
- **Staggered Entry**: Menu items appear with sequential timing
- **Morphing FAB**: Transforms from action button to close button
- **Configurable Timing**: Adjustable animation speed and stagger intervals
- **Multiple Styles**: Morphing, rotating, flipping, and custom icon animations

### 📱 **Intelligent Behavior**
- **Edge Alignment**: Menu items align to the nearest screen edge
- **Smart Scrolling**: Items scroll behind the close button in limited height scenarios
- **Landscape Support**: Perfect for horizontal device orientation
- **Accessibility**: Full semantic support and keyboard navigation

### 🛠️ **Developer Experience**
- **Simple API**: Easy setup with sensible defaults
- **Preset Actions**: 6+ built-in action sets (Edit, Social, Navigation, etc.)
- **Builder Pattern**: Quick configuration with `FabMenuBuilder`
- **Type Safety**: Strongly typed action system with `FabMenuAction`

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  material3_fab_menu: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### Basic Usage

```dart
import 'package:material3_fab_menu/material3_fab_menu.dart';

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FabMenuBuilder.buildPresetMenu(
        expanded: _isExpanded,
        onExpandedChanged: (value) => setState(() => _isExpanded = value),
        actions: FabMenuPresets.editActions,
        onActionPressed: (action) => _handleAction(action),
        context: context,
        style: FabMenuStyle.primary,
      ),
    );
  }

  void _handleAction(String action) {
    print('Action pressed: $action');
    // Handle your actions here
  }
}
```

### Custom Actions

```dart
FabMenuBuilder.buildPresetMenu(
  expanded: _isExpanded,
  onExpandedChanged: (value) => setState(() => _isExpanded = value),
  actions: [
    FabMenuAction(icon: Icons.star, label: 'Star', action: 'star'),
    FabMenuAction(icon: Icons.favorite, label: 'Favorite', action: 'favorite'),
    FabMenuAction(icon: Icons.share, label: 'Share', action: 'share'),
  ],
  onActionPressed: _handleAction,
  context: context,
  style: FabMenuStyle.secondary,
)
```

## 📖 API Reference

### FabMenuBuilder

The easiest way to create FAB menus with preset configurations.

#### buildPresetMenu()

```dart
static Widget buildPresetMenu({
  required bool expanded,
  required ValueChanged<bool> onExpandedChanged,
  required List<FabMenuAction> actions,
  required Function(String) onActionPressed,
  required BuildContext context,
  FabMenuStyle style = FabMenuStyle.primary,
  AlignmentDirectional alignment = AlignmentDirectional.centerEnd,
  Duration? animationDuration,
  Duration? staggerInterval,
  IconData toggleIcon = Icons.add,
  IconData closeIcon = Icons.close,
})
```

### FloatingActionButtonMenu

Advanced widget for full customization.

```dart
FloatingActionButtonMenu(
  expanded: _isExpanded,
  horizontalAlignment: AlignmentDirectional.centerEnd,
  animationDuration: Duration(milliseconds: 300),
  staggerInterval: Duration(milliseconds: 50),
  button: () => ToggleFloatingActionButton(
    checked: _isExpanded,
    onChanged: (value) => setState(() => _isExpanded = value),
    content: (scope) => FabMenuIconAnimations.morphingIcon(
      scope,
      uncheckedIcon: Icons.add,
      checkedIcon: Icons.close,
    ),
  ),
  content: (scope) => Column(
    children: [
      scope.item(
        onPressed: () => _handleAction('edit'),
        text: Text('Edit'),
        icon: Icon(Icons.edit),
      ),
      // More items...
    ],
  ),
)
```

### ToggleFloatingActionButton

Morphing FAB with customizable transformations.

```dart
ToggleFloatingActionButton(
  checked: _isExpanded,
  onChanged: (value) => setState(() => _isExpanded = value),
  containerColor: (progress) => Color.lerp(Colors.blue, Colors.red, progress)!,
  containerSize: (progress) => 56.0 + (16.0 * progress),
  containerCornerRadius: (progress) => 16.0 + (12.0 * progress),
  content: (scope) => FabMenuIconAnimations.shrinkMorphIcon(
    scope,
    uncheckedIcon: Icons.add,
    checkedIcon: Icons.close,
  ),
)
```

## 🎨 Theming & Customization

### Color Schemes

```dart
// Primary colors (default)
FabMenuBuilder.buildPresetMenu(
  style: FabMenuStyle.primary,
  // Uses colorScheme.primaryContainer / onPrimaryContainer
)

// Secondary colors
FabMenuBuilder.buildPresetMenu(
  style: FabMenuStyle.secondary,
  // Uses colorScheme.secondaryContainer / onSecondaryContainer
)

// Tertiary colors
FabMenuBuilder.buildPresetMenu(
  style: FabMenuStyle.tertiary,
  // Uses colorScheme.tertiaryContainer / onTertiaryContainer
)

// Custom colors
FabMenuBuilder.buildPresetMenu(
  style: FabMenuStyle.custom,
  actions: [
    FabMenuAction(
      icon: Icons.star,
      label: 'Star',
      action: 'star',
      containerColor: Colors.amber.withOpacity(0.1),
      contentColor: Colors.amber,
    ),
  ],
)
```

### Animation Styles

```dart
// Morphing (recommended default)
FabMenuIconAnimations.morphingIcon(scope, 
  uncheckedIcon: Icons.add, 
  checkedIcon: Icons.close,
)

// Shrink and morph
FabMenuIconAnimations.shrinkMorphIcon(scope,
  uncheckedIcon: Icons.menu,
  checkedIcon: Icons.close,
)

// Rotating
FabMenuIconAnimations.rotatingIcon(scope,
  uncheckedIcon: Icons.add,
  checkedIcon: Icons.close,
  rotationTurns: 0.5,
)

// Flipping
FabMenuIconAnimations.flippingIcon(scope,
  uncheckedIcon: Icons.favorite_border,
  checkedIcon: Icons.favorite,
)
```

### Alignment Options

```dart
// Right-aligned (default)
FloatingActionButtonMenu(
  horizontalAlignment: AlignmentDirectional.centerEnd,
)

// Left-aligned  
FloatingActionButtonMenu(
  horizontalAlignment: AlignmentDirectional.centerStart,
)
```

## 📋 Preset Actions

The package includes 6 preset action sets for common use cases:

### Edit Actions
```dart
FabMenuPresets.editActions // Edit, Copy, Share, Delete
```

### Social Actions
```dart
FabMenuPresets.socialActions // Like, Comment, Share, Save
```

### Navigation Actions
```dart
FabMenuPresets.navigationActions // Home, Search, Notifications, Profile
```

### Media Actions
```dart
FabMenuPresets.mediaActions // Camera, Gallery, Video
```

### File Actions
```dart
FabMenuPresets.fileActions // Upload, Download, Folder
```

### Communication Actions
```dart
FabMenuPresets.communicationActions // Call, Message, Email, Video Call
```

## 🎯 Advanced Features

### Scrolling Behavior

When screen height is limited (e.g., landscape orientation), menu items automatically scroll behind the close button:

```dart
FloatingActionButtonMenu(
  // Scrolling is automatic when content exceeds available height
  // Items scroll behind the fixed close button
  // Perfect for landscape mode or when you have 6+ menu items
)
```

### Custom Transformations

```dart
ToggleFloatingActionButton(
  containerColor: (progress) {
    // Custom color transitions
    return Color.lerp(startColor, endColor, progress)!;
  },
  containerSize: (progress) {
    // Custom size transitions  
    return startSize + (endSize - startSize) * progress;
  },
  containerCornerRadius: (progress) {
    // Custom corner radius transitions
    return startRadius + (endRadius - startRadius) * progress;
  },
)
```

### Animation Timing

```dart
FloatingActionButtonMenu(
  animationDuration: Duration(milliseconds: 400), // Overall timing
  staggerInterval: Duration(milliseconds: 80),    // Delay between items
)
```

## 🎪 Demo

Run the example app to see all features in action:

```bash
git clone https://github.com/yourusername/material3_fab_menu.git
cd material3_fab_menu/example
flutter run
```

The demo includes:
- **Interactive Controls**: Toggle different FAB menu configurations
- **Animation Tuning**: Adjust speed and stagger timing in real-time
- **Color Schemes**: Test Primary, Secondary, Tertiary, and Custom styles
- **Alignment Testing**: Switch between left and right alignment
- **Scrolling Demo**: Test with 2-8 menu items
- **Behavior Examples**: Morphing animations, edge alignment, and intelligent scrolling

## 🏗️ Architecture

### Component Structure

```
material3_fab_menu/
├── lib/
│   ├── src/
│   │   ├── fab_menu_tokens.dart          # Material 3 design tokens
│   │   ├── floating_action_button_menu.dart    # Main menu widget
│   │   ├── floating_action_button_menu_item.dart # Individual menu items
│   │   ├── toggle_floating_action_button.dart  # Morphing FAB button
│   │   ├── fab_menu_defaults.dart        # Default configurations
│   │   └── fab_menu_scope.dart          # Scope definitions
│   └── material3_fab_menu.dart          # Public API exports
└── example/                             # Demo application
```

### Key Classes

- **`FloatingActionButtonMenu`**: Main container with staggered animations
- **`FloatingActionButtonMenuItem`**: Individual menu items with scale/fade animations
- **`ToggleFloatingActionButton`**: Morphing toggle button with size/color transitions
- **`FabMenuBuilder`**: High-level builder for quick setup
- **`FabMenuPresets`**: Pre-built action sets for common use cases
- **`FabMenuIconAnimations`**: Reusable icon animation patterns

## 🔧 Requirements

- **Flutter**: 3.10.0 or higher
- **Dart**: 3.0.0 or higher
- **Material 3**: Uses Material Design 3 theming

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

### Development Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/material3_fab_menu.git
   cd material3_fab_menu
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the example**
   ```bash
   cd example
   flutter run
   ```

4. **Run tests**
   ```bash
   flutter test
   ```

### Areas for Contribution

- **Additional Presets**: More action sets for specific use cases
- **Animation Styles**: New icon transformation animations  
- **Accessibility**: Enhanced keyboard navigation and screen reader support
- **Platform Support**: Web and desktop optimizations
- **Performance**: Animation optimization and memory usage improvements

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Google Material Design Team** for the Material 3 Expressive specifications
- **Android Jetpack Compose Team** for the reference implementation
- **Flutter Team** for the amazing framework
- **Contributors** who help improve this package

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/material3_fab_menu/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/material3_fab_menu/discussions)
- **Documentation**: [API Documentation](https://pub.dev/documentation/material3_fab_menu)

## 🔗 Related Packages

- **[material3_extended_fab](https://pub.dev/packages/material3_extended_fab)**: Extended FAB implementation
- **[material3_button_groups](https://pub.dev/packages/material3_button_groups)**: Button group components
- **[material3_navigation](https://pub.dev/packages/material3_navigation)**: Navigation components

---

<div align="center">

**Built with ❤️ for the Flutter community**

[⭐ Star this repo](https://github.com/yourusername/material3_fab_menu) • [🐛 Report Bug](https://github.com/yourusername/material3_fab_menu/issues) • [💡 Request Feature](https://github.com/yourusername/material3_fab_menu/issues)

</div>
