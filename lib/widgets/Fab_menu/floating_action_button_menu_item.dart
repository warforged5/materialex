import 'package:flutter/material.dart';
import 'fab_menu_tokens.dart';
import 'floating_action_button_menu.dart';

class FloatingActionButtonMenuItem extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget text;
  final Widget icon;
  final Color? containerColor;
  final Color? contentColor;
  final int index;
  final int totalItems;
  final Animation<double> staggerAnimation;
  final Duration staggerInterval;

  const FloatingActionButtonMenuItem({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.index,
    required this.totalItems,
    required this.staggerAnimation,
    required this.staggerInterval,
    this.containerColor,
    this.contentColor,
  });

  @override
  State<FloatingActionButtonMenuItem> createState() => _FloatingActionButtonMenuItemState();
}

class _FloatingActionButtonMenuItemState extends State<FloatingActionButtonMenuItem>
    with TickerProviderStateMixin {
  late AnimationController _itemController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _itemController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _itemController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _itemController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _itemController,
      curve: Curves.easeOutCubic,
    ));

    // Listen to stagger animation
    widget.staggerAnimation.addListener(_updateAnimation);
    _updateAnimation();
  }

  void _updateAnimation() {
    final progress = widget.staggerAnimation.value;
    final totalItems = widget.totalItems;
    
    // Calculate the delay for this item (items appear from top to bottom)
    // For closing, items disappear from bottom to top
    final itemDelay = widget.index / totalItems;
    final reverseItemDelay = (totalItems - 1 - widget.index) / totalItems;
    
    // Use different delays for opening vs closing
    final effectiveDelay = widget.staggerAnimation.status == AnimationStatus.forward 
        ? itemDelay 
        : reverseItemDelay;
    
    // Calculate when this item should start animating (with stagger)
    final animationStart = effectiveDelay * 0.6; // 60% of the animation is staggered
    final animationEnd = animationStart + 0.4; // Each item takes 40% of total time
    
    final itemProgress = ((progress - animationStart) / (animationEnd - animationStart)).clamp(0.0, 1.0);
    
    if (itemProgress > 0 && widget.staggerAnimation.status == AnimationStatus.forward) {
      _itemController.forward();
    } else if (itemProgress <= 0 && widget.staggerAnimation.status == AnimationStatus.reverse) {
      _itemController.reverse();
    } else if (widget.staggerAnimation.status == AnimationStatus.reverse) {
      // Handle reverse animation timing
      final reverseProgress = ((progress - (1.0 - animationEnd)) / (animationEnd - animationStart)).clamp(0.0, 1.0);
      if (reverseProgress <= 0) {
        _itemController.reverse();
      }
    }
  }

  @override
  void didUpdateWidget(FloatingActionButtonMenuItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.staggerAnimation != widget.staggerAnimation) {
      oldWidget.staggerAnimation.removeListener(_updateAnimation);
      widget.staggerAnimation.addListener(_updateAnimation);
      _updateAnimation();
    }
  }

  @override
  void dispose() {
    widget.staggerAnimation.removeListener(_updateAnimation);
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final effectiveContainerColor = widget.containerColor ?? colorScheme.primaryContainer;
    final effectiveContentColor = widget.contentColor ?? colorScheme.onPrimaryContainer;

    return AnimatedBuilder(
      animation: Listenable.merge([_scaleAnimation, _fadeAnimation, _slideAnimation]),
      builder: (context, child) {
        // Determine the alignment based on the menu's horizontal alignment
        final menuColumn = context.findAncestorWidgetOfExactType<FloatingActionButtonMenuItemColumn>();
        final isLeftAligned = menuColumn?.horizontalAlignment == AlignmentDirectional.centerStart;
        
        return Transform.scale(
          scale: _scaleAnimation.value,
          alignment: isLeftAligned ? Alignment.centerLeft : Alignment.centerRight,
          child: SlideTransition(
            position: _slideAnimation,
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Container(
                margin: const EdgeInsets.only(bottom: FabMenuBaselineTokens.listItemBetweenSpace),
                child: Material(
                  elevation: FabMenuBaselineTokens.listItemContainerElevation,
                  borderRadius: BorderRadius.circular(FabMenuBaselineTokens.listItemContainerHeight / 2),
                  color: effectiveContainerColor,
                  child: InkWell(
                    onTap: widget.onPressed,
                    borderRadius: BorderRadius.circular(FabMenuBaselineTokens.listItemContainerHeight / 2),
                    child: Container(
                      height: FabMenuBaselineTokens.listItemContainerHeight,
                      constraints: const BoxConstraints(
                        minWidth: FabMenuBaselineTokens.listItemContainerHeight,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: FabMenuBaselineTokens.listItemLeadingSpace,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isLeftAligned 
                            ? MainAxisAlignment.start 
                            : MainAxisAlignment.end,
                        children: isLeftAligned 
                            ? [
                                // Left-aligned: text then icon
                                Flexible(
                                  child: DefaultTextStyle(
                                    style: theme.textTheme.titleMedium!.copyWith(
                                      color: effectiveContentColor,
                                    ),
                                    child: widget.text,
                                  ),
                                ),
                                const SizedBox(width: FabMenuBaselineTokens.listItemIconLabelSpace),
                                IconTheme(
                                  data: IconThemeData(
                                    color: effectiveContentColor,
                                    size: FabMenuBaselineTokens.listItemIconSize,
                                  ),
                                  child: widget.icon,
                                ),
                              ]
                            : [
                                // Right-aligned: icon, then text
                                IconTheme(
                                  data: IconThemeData(
                                    color: effectiveContentColor,
                                    size: FabMenuBaselineTokens.listItemIconSize,
                                  ),
                                  child: widget.icon,
                                ),
                                const SizedBox(width: FabMenuBaselineTokens.listItemIconLabelSpace),
                                Flexible(
                                  child: DefaultTextStyle(
                                    style: theme.textTheme.titleMedium!.copyWith(
                                      color: effectiveContentColor,
                                    ),
                                    child: widget.text,
                                  ),
                                ),
                              ],
                      ),
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
}