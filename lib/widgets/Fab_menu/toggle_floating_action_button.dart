import 'package:flutter/material.dart';
import 'fab_menu_tokens.dart';
import "fab_menu_scope.dart";
import "floating_action_button_menu.dart";

class ToggleFloatingActionButton extends StatefulWidget {
  final bool checked;
  final ValueChanged<bool> onChanged;
  final Color Function(double)? containerColor;
  final double Function(double)? containerSize;
  final double Function(double)? containerCornerRadius;
  final Widget Function(ToggleFloatingActionButtonScope) content;
  final Duration animationDuration;

  const ToggleFloatingActionButton({
    super.key,
    required this.checked,
    required this.onChanged,
    required this.content,
    this.containerColor,
    this.containerSize,
    this.containerCornerRadius,
    this.animationDuration = const Duration(milliseconds: 150), // Faster default
  });

  @override
  State<ToggleFloatingActionButton> createState() => _ToggleFloatingActionButtonState();
}

class _ToggleFloatingActionButtonState extends State<ToggleFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn); // Faster curve
    
    if (widget.checked) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(ToggleFloatingActionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.checked != oldWidget.checked) {
      if (widget.checked) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
    
    if (widget.animationDuration != oldWidget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final progress = _animation.value;
        final scope = ToggleFloatingActionButtonScopeImpl(progress);
        
        final containerColor = widget.containerColor?.call(progress) ??
            Color.lerp(colorScheme.primaryContainer, colorScheme.primary, progress)!;
        
        final containerSize = widget.containerSize?.call(progress) ??
            (56.0 + (FabMenuBaselineTokens.closeButtonContainerHeight - 56.0) * progress);
        
        final containerCornerRadius = widget.containerCornerRadius?.call(progress) ??
            (16.0 + (28.0 - 16.0) * progress);

        // Create transformation matrix for morphing effect
        final transformMatrix = Matrix4.identity();
        
        // Scale down slightly during transition for morphing effect (less dramatic)
        final scaleValue = 1.0 - (progress * 0.05); // Reduced from 0.1 to 0.05 for subtler effect
        transformMatrix.scale(scaleValue);
        
        // Add a subtle rotation for more dynamic feel (reduced)
        transformMatrix.rotateZ(progress * 0.05); // Reduced from 0.1 for subtler effect

        return Transform(
          alignment: Alignment.topRight, // Originate from top-right corner
          transform: transformMatrix,
          child: SizedBox(
            width: containerSize,
            height: containerSize,
            child: Material(
              elevation: 6.0 + (progress * 1.0), // Reduced elevation change
              color: containerColor,
              borderRadius: BorderRadius.circular(containerCornerRadius),
              child: InkWell(
                onTap: () => widget.onChanged(!widget.checked),
                borderRadius: BorderRadius.circular(containerCornerRadius),
                child: Center(
                  child: widget.content(scope),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Extension for FloatingActionButtonMenuScope
extension FloatingActionButtonMenuItemExtension on FloatingActionButtonMenuScope {
  Widget item({
    required VoidCallback onPressed,
    required Widget text,
    required Widget icon,
    Color? containerColor,
    Color? contentColor,
  }) {
    if (this is MenuScopeWithStagger) {
      final scope = this as MenuScopeWithStagger;
      return scope.item(
        onPressed: onPressed,
        text: text,
        icon: icon,
        containerColor: containerColor,
        contentColor: contentColor,
      );
    }
    
    // Fallback for other implementations
    return Container();
  }
}