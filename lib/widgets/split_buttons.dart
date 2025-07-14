import 'package:flutter/material.dart';

/// Material Design 3 split buttons implementation
/// Mimics the Jetpack Compose ExpressiveApi split buttons

/// A split button layout that displays two connected buttons:
/// - Leading button (primary action) - can contain text, icon, or both
/// - Trailing button (secondary action) - typically contains only an icon
/// 
/// The buttons are visually connected with shared corners and spacing.
class SplitButtonLayout extends StatelessWidget {
  const SplitButtonLayout({
    super.key,
    required this.leadingButton,
    required this.trailingButton,
    this.spacing = SplitButtonDefaults.spacing,
  });

  final Widget leadingButton;
  final Widget trailingButton;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leadingButton,
          SizedBox(width: spacing),
          trailingButton,
        ],
      ),
    );
  }
}

/// Default values and configurations for split buttons
class SplitButtonDefaults {
  // Spacing - consistent across all sizes
  static const double spacing = 2.0;

  // Container heights from official tokens
  static const double extraSmallContainerHeight = 32.0;
  static const double smallContainerHeight = 40.0;
  static const double mediumContainerHeight = 56.0;
  static const double largeContainerHeight = 96.0;
  static const double extraLargeContainerHeight = 136.0;

  // Shape token values (mapping from Compose tokens)
  static const double cornerValueExtraSmall = 4.0;
  static const double cornerValueSmall = 8.0;
  static const double cornerValueMedium = 12.0;
  static const double cornerValueLargeIncreased = 16.0;

  // Icon sizes from official tokens
  static const double extraSmallTrailingIconSize = 22.0;
  static const double smallTrailingIconSize = 22.0;
  static const double mediumTrailingIconSize = 26.0;
  static const double largeTrailingIconSize = 38.0;
  static const double extraLargeTrailingIconSize = 50.0;

  // Leading icon sizes (derived from button sizes)
  static const double extraSmallLeadingIconSize = 18.0;
  static const double smallLeadingIconSize = 18.0;
  static const double mediumLeadingIconSize = 20.0;
  static const double largeLeadingIconSize = 24.0;
  static const double extraLargeLeadingIconSize = 32.0;

  // Corner sizes for different button sizes (inner corners)
  static const double extraSmallInnerCornerSize = cornerValueExtraSmall; // 4dp
  static const double smallInnerCornerSize = cornerValueExtraSmall; // 4dp
  static const double mediumInnerCornerSize = cornerValueExtraSmall; // 4dp
  static const double largeInnerCornerSize = cornerValueSmall; // 8dp
  static const double extraLargeInnerCornerSize = cornerValueMedium; // 12dp

  // Corner sizes when pressed/hovered
  static const double extraSmallInnerCornerSizePressed = cornerValueSmall; // 8dp
  static const double smallInnerCornerSizePressed = cornerValueMedium; // 12dp
  static const double mediumInnerCornerSizePressed = cornerValueMedium; // 12dp
  static const double largeInnerCornerSizePressed = cornerValueLargeIncreased; // 16dp
  static const double extraLargeInnerCornerSizePressed = cornerValueLargeIncreased; // 16dp

  // Minimum button widths
  static const double leadingButtonMinWidth = 48.0;
  static const double trailingButtonMinWidth = 48.0;

  // Content padding for leading buttons (from official tokens)
  static const EdgeInsets extraSmallLeadingButtonContentPadding = 
      EdgeInsets.only(left: 12.0, right: 10.0);
  static const EdgeInsets smallLeadingButtonContentPadding = 
      EdgeInsets.only(left: 16.0, right: 12.0);
  static const EdgeInsets mediumLeadingButtonContentPadding = 
      EdgeInsets.only(left: 24.0, right: 24.0);
  static const EdgeInsets largeLeadingButtonContentPadding = 
      EdgeInsets.only(left: 48.0, right: 48.0);
  static const EdgeInsets extraLargeLeadingButtonContentPadding = 
      EdgeInsets.only(left: 64.0, right: 64.0);

  // Content padding for trailing buttons (from official tokens)
  static const EdgeInsets extraSmallTrailingButtonContentPadding = 
      EdgeInsets.symmetric(horizontal: 13.0);
  static const EdgeInsets smallTrailingButtonContentPadding = 
      EdgeInsets.symmetric(horizontal: 13.0);
  static const EdgeInsets mediumTrailingButtonContentPadding = 
      EdgeInsets.symmetric(horizontal: 15.0);
  static const EdgeInsets largeTrailingButtonContentPadding = 
      EdgeInsets.symmetric(horizontal: 29.0);
  static const EdgeInsets extraLargeTrailingButtonContentPadding = 
      EdgeInsets.symmetric(horizontal: 43.0);

  /// Get leading button content padding for a given height
  static EdgeInsets leadingButtonContentPaddingFor(double buttonHeight) {
    if (buttonHeight <= (extraSmallContainerHeight + smallContainerHeight) / 2) return extraSmallLeadingButtonContentPadding;
    if (buttonHeight <= (smallContainerHeight + mediumContainerHeight) / 2) return smallLeadingButtonContentPadding;
    if (buttonHeight <= (mediumContainerHeight + largeContainerHeight) / 2) return mediumLeadingButtonContentPadding;
    if (buttonHeight <= (largeContainerHeight + extraLargeContainerHeight) / 2) return largeLeadingButtonContentPadding;
    return extraLargeLeadingButtonContentPadding;
  }

  /// Get trailing button content padding for a given height
  static EdgeInsets trailingButtonContentPaddingFor(double buttonHeight) {
    if (buttonHeight <= (extraSmallContainerHeight + smallContainerHeight) / 2) return extraSmallTrailingButtonContentPadding;
    if (buttonHeight <= (smallContainerHeight + mediumContainerHeight) / 2) return smallTrailingButtonContentPadding;
    if (buttonHeight <= (mediumContainerHeight + largeContainerHeight) / 2) return mediumTrailingButtonContentPadding;
    if (buttonHeight <= (largeContainerHeight + extraLargeContainerHeight) / 2) return largeTrailingButtonContentPadding;
    return extraLargeTrailingButtonContentPadding;
  }

  /// Get leading button icon size for a given height
  static double leadingButtonIconSizeFor(double buttonHeight) {
    if (buttonHeight <= (extraSmallContainerHeight + smallContainerHeight) / 2) return extraSmallLeadingIconSize;
    if (buttonHeight <= (smallContainerHeight + mediumContainerHeight) / 2) return smallLeadingIconSize;
    if (buttonHeight <= (mediumContainerHeight + largeContainerHeight) / 2) return mediumLeadingIconSize;
    if (buttonHeight <= (largeContainerHeight + extraLargeContainerHeight) / 2) return largeLeadingIconSize;
    return extraLargeLeadingIconSize;
  }

  /// Get trailing button icon size for a given height
  static double trailingButtonIconSizeFor(double buttonHeight) {
    if (buttonHeight <= extraSmallContainerHeight) return extraSmallTrailingIconSize;
    if (buttonHeight <= smallContainerHeight) return smallTrailingIconSize;
    if (buttonHeight <= mediumContainerHeight) return mediumTrailingIconSize;
    if (buttonHeight <= largeContainerHeight) return largeTrailingIconSize;
    return extraLargeTrailingIconSize;
  }

  /// Get leading button shapes for a given height
  static SplitButtonShapes leadingButtonShapesFor(double buttonHeight) {
    final cornerSize = _getInnerCornerSizeFor(buttonHeight);
    final cornerSizePressed = _getInnerCornerSizePressedFor(buttonHeight);
    
    return SplitButtonShapes(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(1000), // Full round
          bottomLeft: const Radius.circular(1000), // Full round
          topRight: Radius.circular(cornerSize),
          bottomRight: Radius.circular(cornerSize),
        ),
      ),
      pressedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(1000), // Full round
          bottomLeft: const Radius.circular(1000), // Full round
          topRight: Radius.circular(cornerSizePressed),
          bottomRight: Radius.circular(cornerSizePressed),
        ),
      ),
      checkedShape: null, // Leading button doesn't have checked state
    );
  }

  /// Get trailing button shapes for a given height
  static SplitButtonShapes trailingButtonShapesFor(double buttonHeight) {
    final cornerSize = _getInnerCornerSizeFor(buttonHeight);
    final cornerSizePressed = _getInnerCornerSizePressedFor(buttonHeight);
    
    return SplitButtonShapes(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(cornerSize),
          bottomLeft: Radius.circular(cornerSize),
          topRight: const Radius.circular(1000), // Full round
          bottomRight: const Radius.circular(1000), // Full round
        ),
      ),
      pressedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(cornerSizePressed),
          bottomLeft: Radius.circular(cornerSizePressed),
          topRight: const Radius.circular(1000), // Full round
          bottomRight: const Radius.circular(1000), // Full round
        ),
      ),
      checkedShape: const CircleBorder(), // Becomes circular when checked
    );
  }

  static double _getInnerCornerSizeFor(double buttonHeight) {
    if (buttonHeight <= extraSmallContainerHeight) return extraSmallInnerCornerSize;
    if (buttonHeight <= smallContainerHeight) return smallInnerCornerSize;
    if (buttonHeight <= mediumContainerHeight) return mediumInnerCornerSize;
    if (buttonHeight <= largeContainerHeight) return largeInnerCornerSize;
    return extraLargeInnerCornerSize;
  }

  static double _getInnerCornerSizePressedFor(double buttonHeight) {
    if (buttonHeight <= extraSmallContainerHeight) return extraSmallInnerCornerSizePressed;
    if (buttonHeight <= smallContainerHeight) return smallInnerCornerSizePressed;
    if (buttonHeight <= mediumContainerHeight) return mediumInnerCornerSizePressed;
    if (buttonHeight <= largeContainerHeight) return largeInnerCornerSizePressed;
    return extraLargeInnerCornerSizePressed;
  }

  /// Creates a leading button (primary action)
  static Widget leadingButton({
    required VoidCallback onPressed,
    required Widget child,
    double height = smallContainerHeight,
    ButtonStyle? style,
    bool enabled = true,
  }) {
    return SplitLeadingButton(
      onPressed: enabled ? onPressed : null,
      height: height,
      style: style,
      child: child,
    );
  }

  /// Creates a trailing button (secondary action)
  static Widget trailingButton({
    required VoidCallback onPressed,
    required Widget child,
    double height = smallContainerHeight,
    ButtonStyle? style,
    bool enabled = true,
    bool checked = false,
  }) {
    return SplitTrailingButton(
      onPressed: enabled ? onPressed : null,
      height: height,
      style: style,
      checked: checked,
      child: child,
    );
  }

  /// Creates a tonal leading button
  static Widget tonalLeadingButton({
    required VoidCallback onPressed,
    required Widget child,
    double height = smallContainerHeight,
    bool enabled = true,
  }) {
    return leadingButton(
      onPressed: onPressed,
      child: child,
      height: height,
      enabled: enabled,
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(
            WidgetsBinding.instance.rootElement! as BuildContext).colorScheme.secondaryContainer,
        foregroundColor: Theme.of(
            WidgetsBinding.instance.rootElement! as BuildContext).colorScheme.onSecondaryContainer,
      ),
    );
  }

  /// Creates a tonal trailing button
  static Widget tonalTrailingButton({
    required VoidCallback onPressed,
    required Widget child,
    double height = smallContainerHeight,
    bool enabled = true,
    bool checked = false,
  }) {
    return trailingButton(
      onPressed: onPressed,
      child: child,
      height: height,
      enabled: enabled,
      checked: checked,
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of( 
            WidgetsBinding.instance.rootElement! as BuildContext).colorScheme.secondaryContainer,
        foregroundColor: Theme.of(
            WidgetsBinding.instance.rootElement! as BuildContext).colorScheme.onSecondaryContainer,
      ),
    );
  }

  /// Creates an outlined leading button
  static Widget outlinedLeadingButton({
    required VoidCallback onPressed,
    required Widget child,
    double height = smallContainerHeight,
    bool enabled = true,
  }) {
    return leadingButton(
      onPressed: onPressed,
      child: child,
      height: height,
      enabled: enabled,
      style: OutlinedButton.styleFrom(),
    );
  }

  /// Creates an outlined trailing button
  static Widget outlinedTrailingButton({
    required VoidCallback onPressed,
    required Widget child,
    double height = smallContainerHeight,
    bool enabled = true,
    bool checked = false,
  }) {
    return Builder(
      builder: (context) => trailingButton(
        onPressed: onPressed,
        child: child,
        height: height,
        enabled: enabled,
        checked: checked,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Theme.of(context).colorScheme.onSurface.withOpacity(0.38);
            }
            return Theme.of(context).colorScheme.primary;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                width: 1.0,
              );
            }
            return BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 1.0,
            );
          }),
        ),
      ),
    );
  }

  /// Creates an elevated leading button
  static Widget elevatedLeadingButton({
    required VoidCallback onPressed,
    required Widget child,
    double height = smallContainerHeight,
    bool enabled = true,
  }) {
    return Builder(
      builder: (context) => leadingButton(
        onPressed: onPressed,
        child: child,
        height: height,
        enabled: enabled,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Theme.of(context).colorScheme.onSurface.withOpacity(0.12);
            }
            return Theme.of(context).colorScheme.surface;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Theme.of(context).colorScheme.onSurface.withOpacity(0.38);
            }
            return Theme.of(context).colorScheme.primary;
          }),
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) return 0.0;
            if (states.contains(WidgetState.pressed)) return 1.0;
            if (states.contains(WidgetState.hovered)) return 3.0;
            return 1.0;
          }),
          shadowColor: WidgetStateProperty.all(Theme.of(context).colorScheme.shadow),
        ),
      ),
    );
  }

  /// Creates an elevated trailing button
  static Widget elevatedTrailingButton({
    required VoidCallback onPressed,
    required Widget child,
    double height = smallContainerHeight,
    bool enabled = true,
    bool checked = false,
  }) {
    return Builder(
      builder: (context) => trailingButton(
        onPressed: onPressed,
        child: child,
        height: height,
        enabled: enabled,
        checked: checked,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Theme.of(context).colorScheme.onSurface.withOpacity(0.12);
            }
            return Theme.of(context).colorScheme.surface;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Theme.of(context).colorScheme.onSurface.withOpacity(0.38);
            }
            return Theme.of(context).colorScheme.primary;
          }),
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) return 0.0;
            if (states.contains(WidgetState.pressed)) return 1.0;
            if (states.contains(WidgetState.hovered)) return 3.0;
            return 1.0;
          }),
          shadowColor: WidgetStateProperty.all(Theme.of(context).colorScheme.shadow),
        ),
      ),
    );
  }
}

/// Shapes for split button components
class SplitButtonShapes {
  const SplitButtonShapes({
    required this.shape,
    required this.pressedShape,
    this.checkedShape,
  });

  final OutlinedBorder shape;
  final OutlinedBorder pressedShape;
  final OutlinedBorder? checkedShape;
}

/// Leading button component for split buttons
class SplitLeadingButton extends StatefulWidget {
  const SplitLeadingButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.height = SplitButtonDefaults.smallContainerHeight,
    this.style,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double height;
  final ButtonStyle? style;

  @override
  State<SplitLeadingButton> createState() => _SplitLeadingButtonState();
}

class _SplitLeadingButtonState extends State<SplitLeadingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shapeAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _shapeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final shapes = SplitButtonDefaults.leadingButtonShapesFor(widget.height);
    final contentPadding = SplitButtonDefaults.leadingButtonContentPaddingFor(widget.height);
    
    return AnimatedBuilder(
      animation: _shapeAnimation,
      builder: (context, child) {
        // Interpolate between normal and pressed corner radius
        final normalRadius = _getCornerRadius(shapes.shape);
        final pressedRadius = _getCornerRadius(shapes.pressedShape);
        final currentRadius = normalRadius + (pressedRadius - normalRadius) * _shapeAnimation.value;
        
        final currentShape = RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(1000), // Full round
            bottomLeft: const Radius.circular(1000), // Full round
            topRight: Radius.circular(currentRadius),
            bottomRight: Radius.circular(currentRadius),
          ),
        );

        final border = _getBorder(context);
        final elevation = _getElevation(context);

        return Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTapDown: widget.onPressed != null ? _handleTapDown : null,
            onTapUp: widget.onPressed != null ? _handleTapUp : null,
            onTapCancel: widget.onPressed != null ? _handleTapCancel : null,
            onTap: widget.onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: widget.height,
              constraints: const BoxConstraints(
                minWidth: SplitButtonDefaults.leadingButtonMinWidth,
              ),
              decoration: ShapeDecoration(
                shape: border != null 
                    ? currentShape.copyWith(side: border)
                    : currentShape,
                color: _getBackgroundColor(context),
                shadows: elevation,
              ),
              child: DefaultTextStyle.merge(
                style: TextStyle(color: _getForegroundColor(context)),
                child: IconTheme.merge(
                  data: IconThemeData(
                    color: _getForegroundColor(context),
                    size: SplitButtonDefaults.leadingButtonIconSizeFor(widget.height),
                  ),
                  child: Padding(
                    padding: contentPadding,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [widget.child],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double _getCornerRadius(OutlinedBorder border) {
    if (border is RoundedRectangleBorder) {
      final borderRadius = border.borderRadius;
      if (borderRadius is BorderRadius) {
        return borderRadius.topRight.x;
      }
    }
    return 8.0; // Default fallback
  }

  Color _getBackgroundColor(BuildContext context) {
    final style = widget.style;
    final states = <WidgetState>{
      if (widget.onPressed == null) WidgetState.disabled,
      if (_isPressed) WidgetState.pressed,
    };
    
    if (style?.backgroundColor != null) {
      return style!.backgroundColor!.resolve(states) ?? Theme.of(context).colorScheme.primary;
    }
    return widget.onPressed == null 
        ? Theme.of(context).colorScheme.onSurface.withOpacity(0.12)
        : Theme.of(context).colorScheme.primary;
  }

  Color _getForegroundColor(BuildContext context) {
    final style = widget.style;
    final states = <WidgetState>{
      if (widget.onPressed == null) WidgetState.disabled,
      if (_isPressed) WidgetState.pressed,
    };
    
    if (style?.foregroundColor != null) {
      return style!.foregroundColor!.resolve(states) ?? Theme.of(context).colorScheme.onPrimary;
    }
    return widget.onPressed == null
        ? Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
        : Theme.of(context).colorScheme.onPrimary;
  }

  BorderSide? _getBorder(BuildContext context) {
    final style = widget.style;
    final states = <WidgetState>{
      if (widget.onPressed == null) WidgetState.disabled,
      if (_isPressed) WidgetState.pressed,
    };
    
    if (style?.side != null) {
      return style!.side!.resolve(states);
    }
    return null;
  }

  List<BoxShadow> _getElevation(BuildContext context) {
    final style = widget.style;
    final states = <WidgetState>{
      if (widget.onPressed == null) WidgetState.disabled,
      if (_isPressed) WidgetState.pressed,
    };
    
    if (style?.elevation != null) {
      final elevationValue = style!.elevation!.resolve(states) ?? 0.0;
      
      if (elevationValue > 0) {
        return [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
            blurRadius: elevationValue * 2,
            offset: Offset(0, elevationValue),
          ),
        ];
      }
    }
    return [];
  }
}

/// Trailing button component for split buttons
class SplitTrailingButton extends StatefulWidget {
  const SplitTrailingButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.height = SplitButtonDefaults.smallContainerHeight,
    this.style,
    this.checked = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double height;
  final ButtonStyle? style;
  final bool checked;

  @override
  State<SplitTrailingButton> createState() => _SplitTrailingButtonState();
}

class _SplitTrailingButtonState extends State<SplitTrailingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shapeAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _shapeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final shapes = SplitButtonDefaults.trailingButtonShapesFor(widget.height);
    final contentPadding = SplitButtonDefaults.trailingButtonContentPaddingFor(widget.height);
    
    return AnimatedBuilder(
      animation: _shapeAnimation,
      builder: (context, child) {
        OutlinedBorder currentShape;
        
        if (widget.checked && shapes.checkedShape != null) {
          // Use circular shape when checked
          currentShape = shapes.checkedShape!;
        } else {
          // Interpolate between normal and pressed corner radius
          final normalRadius = _getCornerRadius(shapes.shape);
          final pressedRadius = _getCornerRadius(shapes.pressedShape);
          final currentRadius = normalRadius + (pressedRadius - normalRadius) * _shapeAnimation.value;
          
          currentShape = RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(currentRadius),
              bottomLeft: Radius.circular(currentRadius),
              topRight: const Radius.circular(1000), // Full round
              bottomRight: const Radius.circular(1000), // Full round
            ),
          );
        }

        final border = _getBorder(context);
        final elevation = _getElevation(context);

        return Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTapDown: widget.onPressed != null ? _handleTapDown : null,
            onTapUp: widget.onPressed != null ? _handleTapUp : null,
            onTapCancel: widget.onPressed != null ? _handleTapCancel : null,
            onTap: widget.onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: widget.height,
              constraints: BoxConstraints(
                minWidth: widget.checked ? widget.height : SplitButtonDefaults.trailingButtonMinWidth,
                maxWidth: widget.checked ? widget.height : double.infinity,
              ),
              decoration: ShapeDecoration(
                shape: border != null && currentShape is RoundedRectangleBorder
                    ? currentShape.copyWith(side: border)
                    : currentShape,
                color: _getBackgroundColor(context),
                shadows: elevation,
              ),
              child: DefaultTextStyle.merge(
                style: TextStyle(color: _getForegroundColor(context)),
                child: IconTheme.merge(
                  data: IconThemeData(
                    color: _getForegroundColor(context),
                    size: SplitButtonDefaults.trailingButtonIconSizeFor(widget.height),
                  ),
                  child: Padding(
                    padding: contentPadding,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [widget.child],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double _getCornerRadius(OutlinedBorder border) {
    if (border is RoundedRectangleBorder) {
      final borderRadius = border.borderRadius;
      if (borderRadius is BorderRadius) {
        return borderRadius.topLeft.x;
      }
    }
    return 8.0; // Default fallback
  }

  Color _getBackgroundColor(BuildContext context) {
    final style = widget.style;
    final states = <WidgetState>{
      if (widget.onPressed == null) WidgetState.disabled,
      if (_isPressed) WidgetState.pressed,
    };
    
    if (style?.backgroundColor != null) {
      return style!.backgroundColor!.resolve(states) ?? Theme.of(context).colorScheme.primary;
    }
    return widget.onPressed == null 
        ? Theme.of(context).colorScheme.onSurface.withOpacity(0.12)
        : Theme.of(context).colorScheme.primary;
  }

  Color _getForegroundColor(BuildContext context) {
    final style = widget.style;
    final states = <WidgetState>{
      if (widget.onPressed == null) WidgetState.disabled,
      if (_isPressed) WidgetState.pressed,
    };
    
    if (style?.foregroundColor != null) {
      return style!.foregroundColor!.resolve(states) ?? Theme.of(context).colorScheme.onPrimary;
    }
    return widget.onPressed == null
        ? Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
        : Theme.of(context).colorScheme.onPrimary;
  }

  BorderSide? _getBorder(BuildContext context) {
    final style = widget.style;
    final states = <WidgetState>{
      if (widget.onPressed == null) WidgetState.disabled,
      if (_isPressed) WidgetState.pressed,
    };
    
    if (style?.side != null) {
      return style!.side!.resolve(states);
    }
    return null;
  }

  List<BoxShadow> _getElevation(BuildContext context) {
    final style = widget.style;
    final states = <WidgetState>{
      if (widget.onPressed == null) WidgetState.disabled,
      if (_isPressed) WidgetState.pressed,
    };
    
    if (style?.elevation != null) {
      final elevationValue = style!.elevation!.resolve(states) ?? 0.0;
      
      if (elevationValue > 0) {
        return [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
            blurRadius: elevationValue * 2,
            offset: Offset(0, elevationValue),
          ),
        ];
      }
    }
    return [];
  }
}