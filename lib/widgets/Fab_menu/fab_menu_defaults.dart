// fab_menu_defaults.dart
import 'package:flutter/material.dart';
import "fab_menu_tokens.dart";
import 'fab_menu_scope.dart';
import 'floating_action_button_menu.dart';
import 'toggle_floating_action_button.dart';

/// Contains the default values and utility functions for [FloatingActionButtonMenu]
class FloatingActionButtonMenuDefaults {
  /// Default container color function for menu items
  static Color containerColor(BuildContext context, {Color? color}) {
    return color ?? Theme.of(context).colorScheme.primaryContainer;
  }

  /// Default content color function for menu items
  static Color contentColor(BuildContext context, {Color? color}) {
    if (color != null) return color;
    return Theme.of(context).colorScheme.onPrimaryContainer;
  }

  /// Default secondary container color
  static Color secondaryContainerColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondaryContainer;
  }

  /// Default secondary content color
  static Color secondaryContentColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSecondaryContainer;
  }

  /// Default tertiary container color
  static Color tertiaryContainerColor(BuildContext context) {
    return Theme.of(context).colorScheme.tertiaryContainer;
  }

  /// Default tertiary content color
  static Color tertiaryContentColor(BuildContext context) {
    return Theme.of(context).colorScheme.onTertiaryContainer;
  }

  /// Default animation duration for menu expansion/collapse (faster)
  static const Duration animationDuration = Duration(milliseconds: 200);

  /// Default stagger interval between menu items (faster)
  static const Duration staggerInterval = Duration(milliseconds: 30);

  /// Default horizontal alignment for menu items
  static const AlignmentDirectional horizontalAlignment = AlignmentDirectional.centerEnd;
}

/// Contains the default values for [ToggleFloatingActionButton]
class ToggleFloatingActionButtonDefaults {
  /// Default container color transition from unchecked to checked state
  static Color Function(double) containerColor(BuildContext context, {
    Color? initialColor,
    Color? finalColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return (double progress) {
      return Color.lerp(
        initialColor ?? colorScheme.primaryContainer,
        finalColor ?? colorScheme.primary,
        progress,
      )!;
    };
  }

  /// Creates a secondary container color function
  static Color Function(double) secondaryContainerColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return (double progress) {
      return Color.lerp(
        colorScheme.secondaryContainer,
        colorScheme.secondary,
        progress,
      )!;
    };
  }

  /// Creates a tertiary container color function
  static Color Function(double) tertiaryContainerColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return (double progress) {
      return Color.lerp(
        colorScheme.tertiaryContainer,
        colorScheme.tertiary,
        progress,
      )!;
    };
  }

  /// Default container size transition
  static double Function(double) containerSize({
    double initialSize = 56.0,
    double finalSize = 56.0,
  }) {
    return (double progress) {
      return initialSize + (finalSize - initialSize) * progress;
    };
  }

  /// Standard FAB size transition (matches Material 3 specs)
  static double Function(double) standardContainerSize() {
    return containerSize(
      initialSize: 56.0,
      finalSize: FabMenuBaselineTokens.closeButtonContainerHeight,
    );
  }

  /// Medium FAB size transition
  static double Function(double) mediumContainerSize() {
    return containerSize(
      initialSize: 64.0,
      finalSize: FabMenuBaselineTokens.closeButtonContainerHeight,
    );
  }

  /// Large FAB size transition
  static double Function(double) largeContainerSize() {
    return containerSize(
      initialSize: 96.0,
      finalSize: FabMenuBaselineTokens.closeButtonContainerHeight,
    );
  }

  /// Default corner radius transition
  static double Function(double) containerCornerRadius({
    double initialRadius = 16.0,
    double finalRadius = 28.0,
  }) {
    return (double progress) {
      return initialRadius + (finalRadius - initialRadius) * progress;
    };
  }

  /// Standard corner radius transition (matches Material 3 specs)
  static double Function(double) standardCornerRadius() {
    return containerCornerRadius(
      initialRadius: 16.0,
      finalRadius: FabMenuBaselineTokens.closeButtonContainerHeight / 2,
    );
  }

  /// Medium corner radius transition
  static double Function(double) mediumCornerRadius() {
    return containerCornerRadius(
      initialRadius: 20.0,
      finalRadius: FabMenuBaselineTokens.closeButtonContainerHeight / 2,
    );
  }

  /// Large corner radius transition
  static double Function(double) largeCornerRadius() {
    return containerCornerRadius(
      initialRadius: 28.0,
      finalRadius: FabMenuBaselineTokens.closeButtonContainerHeight / 2,
    );
  }

  /// Default icon color transition
  static Color Function(double) iconColor(BuildContext context, {
    Color? initialColor,
    Color? finalColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return (double progress) {
      return Color.lerp(
        initialColor ?? colorScheme.onPrimaryContainer,
        finalColor ?? colorScheme.onPrimary,
        progress,
      )!;
    };
  }

  /// Creates a secondary icon color function
  static Color Function(double) secondaryIconColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return (double progress) {
      return Color.lerp(
        colorScheme.onSecondaryContainer,
        colorScheme.onSecondary,
        progress,
      )!;
    };
  }

  /// Creates a tertiary icon color function
  static Color Function(double) tertiaryIconColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return (double progress) {
      return Color.lerp(
        colorScheme.onTertiaryContainer,
        colorScheme.onTertiary,
        progress,
      )!;
    };
  }

  /// Default icon size transition
  static double Function(double) iconSize({
    double initialSize = 24.0,
    double finalSize = 20.0,
  }) {
    return (double progress) {
      return initialSize + (finalSize - initialSize) * progress;
    };
  }

  /// Standard icon size transition (matches Material 3 specs)
  static double Function(double) standardIconSize() {
    return iconSize(
      initialSize: 24.0,
      finalSize: FabMenuBaselineTokens.closeButtonIconSize,
    );
  }

  /// Default animation duration for toggle transitions (faster)
  static const Duration animationDuration = Duration(milliseconds: 150);
}

/// Utility class for creating animated icons in toggle FABs
class FabMenuIconAnimations {
  /// Creates a morphing icon animation (recommended for FAB menus)
  /// This transforms the icon with a scale and morph effect, not rotation
  static Widget morphingIcon(
    ToggleFloatingActionButtonScope scope, {
    required IconData uncheckedIcon,
    required IconData checkedIcon,
    Color? color,
    double baseSize = 24.0,
    Duration duration = const Duration(milliseconds: 150), // Faster default
  }) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: Icon(
        scope.checkedProgress > 0.5 ? checkedIcon : uncheckedIcon,
        key: ValueKey(scope.checkedProgress > 0.5 ? checkedIcon : uncheckedIcon),
        color: color,
        size: baseSize + (4.0 * scope.checkedProgress), // Slightly grow when expanded
      ),
    );
  }

  /// Creates a simple rotating icon animation
  static Widget rotatingIcon(
    ToggleFloatingActionButtonScope scope, {
    required IconData uncheckedIcon,
    required IconData checkedIcon,
    Color? color,
    double baseSize = 24.0,
    double sizeMultiplier = 1.2,
    double rotationTurns = 0.5,
    Duration duration = const Duration(milliseconds: 150), // Faster default
  }) {
    return AnimatedRotation(
      turns: scope.checkedProgress * rotationTurns,
      duration: duration,
      child: Icon(
        scope.checkedProgress > 0.5 ? checkedIcon : uncheckedIcon,
        color: color,
        size: baseSize * (1 + (sizeMultiplier - 1) * scope.checkedProgress),
      ),
    );
  }

  /// Creates a shrinking and morphing animation (good for transformation effect)
  static Widget shrinkMorphIcon(
    ToggleFloatingActionButtonScope scope, {
    required IconData uncheckedIcon,
    required IconData checkedIcon,
    Color? color,
    double baseSize = 24.0,
    Duration duration = const Duration(milliseconds: 180), // Faster default
  }) {
    // Create a shrink-expand effect during transition
    final scaleProgress = scope.checkedProgress < 0.5 
        ? 1.0 - (scope.checkedProgress * 0.4) // Shrink in first half
        : 0.6 + ((scope.checkedProgress - 0.5) * 0.8); // Expand in second half

    return AnimatedContainer(
      duration: duration,
      child: Transform.scale(
        scale: scaleProgress,
        child: Icon(
          scope.checkedProgress > 0.5 ? checkedIcon : uncheckedIcon,
          color: color,
          size: baseSize,
        ),
      ),
    );
  }

  /// Creates a flipping icon animation
  static Widget flippingIcon(
    ToggleFloatingActionButtonScope scope, {
    required IconData uncheckedIcon,
    required IconData checkedIcon,
    Color? color,
    double size = 24.0,
    Duration duration = const Duration(milliseconds: 150), // Faster default
  }) {
    return AnimatedContainer(
      duration: duration,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(scope.checkedProgress * 3.14159),
      child: Icon(
        scope.checkedProgress > 0.5 ? checkedIcon : uncheckedIcon,
        color: color,
        size: size,
      ),
    );
  }

  /// Creates a scaling icon animation
  static Widget scalingIcon(
    ToggleFloatingActionButtonScope scope, {
    required IconData uncheckedIcon,
    required IconData checkedIcon,
    Color? color,
    double baseSize = 24.0,
    double minScale = 0.8,
    double maxScale = 1.2,
  }) {
    final scale = minScale + (maxScale - minScale) * scope.checkedProgress;
    
    return Transform.scale(
      scale: scale,
      child: Icon(
        scope.checkedProgress > 0.5 ? checkedIcon : uncheckedIcon,
        color: color,
        size: baseSize,
      ),
    );
  }

  /// Creates a cross-fade icon animation using cross-fade
  static Widget crossFadeIcon(
    ToggleFloatingActionButtonScope scope, {
    required IconData uncheckedIcon,
    required IconData checkedIcon,
    Color? color,
    double size = 24.0,
    Duration duration = const Duration(milliseconds: 200), // Slightly slower for smooth crossfade
  }) {
    return AnimatedCrossFade(
      firstChild: Icon(uncheckedIcon, color: color, size: size),
      secondChild: Icon(checkedIcon, color: color, size: size),
      crossFadeState: scope.checkedProgress > 0.5
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: duration,
    );
  }

  /// Creates a custom color-changing icon
  static Widget colorChangingIcon(
    ToggleFloatingActionButtonScope scope, {
    required IconData uncheckedIcon,
    required IconData checkedIcon,
    required Color uncheckedColor,
    required Color checkedColor,
    double size = 24.0,
  }) {
    return Icon(
      scope.checkedProgress > 0.5 ? checkedIcon : uncheckedIcon,
      color: Color.lerp(uncheckedColor, checkedColor, scope.checkedProgress),
      size: size,
    );
  }

  /// Creates a bouncing transformation effect
  static Widget bouncingIcon(
    ToggleFloatingActionButtonScope scope, {
    required IconData uncheckedIcon,
    required IconData checkedIcon,
    Color? color,
    double baseSize = 24.0,
  }) {
    // Create a bounce effect using a sine wave
    final bounceValue = scope.checkedProgress < 0.5 
        ? 1.0 + (scope.checkedProgress * 0.4) // Grow first
        : 1.4 - ((scope.checkedProgress - 0.5) * 0.4); // Then shrink

    return Transform.scale(
      scale: bounceValue,
      child: Icon(
        scope.checkedProgress > 0.5 ? checkedIcon : uncheckedIcon,
        color: color,
        size: baseSize,
      ),
    );
  }
}

/// Extension methods for easier FAB Menu usage
extension FabMenuExtensions on FloatingActionButtonMenuScope {
  /// Helper method to create a menu item with standard styling
  Widget standardItem({
    required VoidCallback onPressed,
    required Widget text,
    required Widget icon,
    BuildContext? context,
  }) {
    return item(
      onPressed: onPressed,
      text: text,
      icon: icon,
      containerColor: context != null 
          ? FloatingActionButtonMenuDefaults.containerColor(context)
          : null,
      contentColor: context != null 
          ? FloatingActionButtonMenuDefaults.contentColor(context)
          : null,
    );
  }

  /// Helper method to create a secondary styled menu item
  Widget secondaryItem({
    required VoidCallback onPressed,
    required Widget text,
    required Widget icon,
    required BuildContext context,
  }) {
    return item(
      onPressed: onPressed,
      text: text,
      icon: icon,
      containerColor: FloatingActionButtonMenuDefaults.secondaryContainerColor(context),
      contentColor: FloatingActionButtonMenuDefaults.secondaryContentColor(context),
    );
  }

  /// Helper method to create a tertiary styled menu item
  Widget tertiaryItem({
    required VoidCallback onPressed,
    required Widget text,
    required Widget icon,
    required BuildContext context,
  }) {
    return item(
      onPressed: onPressed,
      text: text,
      icon: icon,
      containerColor: FloatingActionButtonMenuDefaults.tertiaryContainerColor(context),
      contentColor: FloatingActionButtonMenuDefaults.tertiaryContentColor(context),
    );
  }

  /// Helper method to create a custom colored menu item
  Widget customItem({
    required VoidCallback onPressed,
    required Widget text,
    required Widget icon,
    required Color containerColor,
    required Color contentColor,
  }) {
    return item(
      onPressed: onPressed,
      text: text,
      icon: icon,
      containerColor: containerColor,
      contentColor: contentColor,
    );
  }
}

/// Predefined FAB Menu configurations for common use cases
class FabMenuPresets {
  /// Standard edit actions menu
  static List<FabMenuAction> editActions = [
    FabMenuAction(icon: Icons.edit, label: 'Edit', action: 'edit'),
    FabMenuAction(icon: Icons.copy, label: 'Copy', action: 'copy'),
    FabMenuAction(icon: Icons.share, label: 'Share', action: 'share'),
    FabMenuAction(icon: Icons.delete, label: 'Delete', action: 'delete'),
  ];

  /// Social actions menu
  static List<FabMenuAction> socialActions = [
    FabMenuAction(icon: Icons.favorite, label: 'Like', action: 'like'),
    FabMenuAction(icon: Icons.comment, label: 'Comment', action: 'comment'),
    FabMenuAction(icon: Icons.share, label: 'Share', action: 'share'),
    FabMenuAction(icon: Icons.bookmark, label: 'Save', action: 'save'),
  ];

  /// Navigation actions menu
  static List<FabMenuAction> navigationActions = [
    FabMenuAction(icon: Icons.home, label: 'Home', action: 'home'),
    FabMenuAction(icon: Icons.search, label: 'Search', action: 'search'),
    FabMenuAction(icon: Icons.notifications, label: 'Notifications', action: 'notifications'),
    FabMenuAction(icon: Icons.person, label: 'Profile', action: 'profile'),
  ];

  /// Media actions menu
  static List<FabMenuAction> mediaActions = [
    FabMenuAction(icon: Icons.photo_camera, label: 'Camera', action: 'camera'),
    FabMenuAction(icon: Icons.photo_library, label: 'Gallery', action: 'gallery'),
    FabMenuAction(icon: Icons.videocam, label: 'Video', action: 'video'),
  ];

  /// File actions menu
  static List<FabMenuAction> fileActions = [
    FabMenuAction(icon: Icons.file_upload, label: 'Upload', action: 'upload'),
    FabMenuAction(icon: Icons.file_download, label: 'Download', action: 'download'),
    FabMenuAction(icon: Icons.folder, label: 'Folder', action: 'folder'),
  ];

  /// Communication actions menu
  static List<FabMenuAction> communicationActions = [
    FabMenuAction(icon: Icons.call, label: 'Call', action: 'call'),
    FabMenuAction(icon: Icons.message, label: 'Message', action: 'message'),
    FabMenuAction(icon: Icons.email, label: 'Email', action: 'email'),
    FabMenuAction(icon: Icons.videocam, label: 'Video Call', action: 'video_call'),
  ];

  /// Helper method to build menu items from preset actions
  static List<Widget> buildMenuItems(
    FloatingActionButtonMenuScope scope,
    List<FabMenuAction> actions,
    Function(String) onActionPressed, {
    BuildContext? context,
    FabMenuStyle style = FabMenuStyle.primary,
  }) {
    return actions.map((action) {
      switch (style) {
        case FabMenuStyle.primary:
          return scope.standardItem(
            onPressed: () => onActionPressed(action.action),
            text: Text(action.label),
            icon: Icon(action.icon),
            context: context,
          );
        case FabMenuStyle.secondary:
          return scope.secondaryItem(
            onPressed: () => onActionPressed(action.action),
            text: Text(action.label),
            icon: Icon(action.icon),
            context: context!,
          );
        case FabMenuStyle.tertiary:
          return scope.tertiaryItem(
            onPressed: () => onActionPressed(action.action),
            text: Text(action.label),
            icon: Icon(action.icon),
            context: context!,
          );
        case FabMenuStyle.custom:
          return scope.customItem(
            onPressed: () => onActionPressed(action.action),
            text: Text(action.label),
            icon: Icon(action.icon),
            containerColor: action.containerColor ?? Colors.blue.withOpacity(0.1),
            contentColor: action.contentColor ?? Colors.blue,
          );
      }
    }).toList();
  }
}

/// Data class for FAB menu actions
class FabMenuAction {
  final IconData icon;
  final String label;
  final String action;
  final Color? containerColor;
  final Color? contentColor;

  const FabMenuAction({
    required this.icon,
    required this.label,
    required this.action,
    this.containerColor,
    this.contentColor,
  });
}

/// Enum for FAB menu styles
enum FabMenuStyle {
  primary,
  secondary,
  tertiary,
  custom,
}

/// Helper class for creating complete FAB menu configurations
class FabMenuBuilder {
  /// Creates a standard FAB menu with preset actions
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
  }) {
    return FloatingActionButtonMenu(
      expanded: expanded,
      horizontalAlignment: alignment,
      animationDuration: animationDuration ?? FloatingActionButtonMenuDefaults.animationDuration,
      staggerInterval: staggerInterval ?? FloatingActionButtonMenuDefaults.staggerInterval,
      button: () => ToggleFloatingActionButton(
        checked: expanded,
        onChanged: onExpandedChanged,
        animationDuration: FloatingActionButtonMenuDefaults.animationDuration, // Use faster default
        containerColor: _getContainerColorFunction(context, style),
        content: (scope) => FabMenuIconAnimations.morphingIcon(
          scope,
          uncheckedIcon: toggleIcon,
          checkedIcon: closeIcon,
          color: _getIconColor(context, style, scope.checkedProgress),
          duration: const Duration(milliseconds: 150), // Faster icon animation
        ),
      ),
      content: (scope) => Column(
        mainAxisSize: MainAxisSize.min,
        children: FabMenuPresets.buildMenuItems(
          scope,
          actions,
          onActionPressed,
          context: context,
          style: style,
        ),
      ),
    );
  }

  static Color Function(double) _getContainerColorFunction(BuildContext context, FabMenuStyle style) {
    switch (style) {
      case FabMenuStyle.primary:
        return ToggleFloatingActionButtonDefaults.containerColor(context);
      case FabMenuStyle.secondary:
        return ToggleFloatingActionButtonDefaults.secondaryContainerColor(context);
      case FabMenuStyle.tertiary:
        return ToggleFloatingActionButtonDefaults.tertiaryContainerColor(context);
      case FabMenuStyle.custom:
        return ToggleFloatingActionButtonDefaults.containerColor(context);
    }
  }

  static Color _getIconColor(BuildContext context, FabMenuStyle style, double progress) {
    switch (style) {
      case FabMenuStyle.primary:
        return ToggleFloatingActionButtonDefaults.iconColor(context)(progress);
      case FabMenuStyle.secondary:
        return ToggleFloatingActionButtonDefaults.secondaryIconColor(context)(progress);
      case FabMenuStyle.tertiary:
        return ToggleFloatingActionButtonDefaults.tertiaryIconColor(context)(progress);
      case FabMenuStyle.custom:
        return ToggleFloatingActionButtonDefaults.iconColor(context)(progress);
    }
  }
}