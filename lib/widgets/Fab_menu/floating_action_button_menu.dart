import 'package:flutter/material.dart';
import 'fab_menu_scope.dart';
import 'floating_action_button_menu_item.dart';
import 'fab_menu_tokens.dart';

class FloatingActionButtonMenu extends StatefulWidget {
  final bool expanded;
  final Widget Function() button;
  final AlignmentDirectional horizontalAlignment;
  final Widget Function(FloatingActionButtonMenuScope) content;
  final Duration animationDuration;
  final Duration staggerInterval;

  const FloatingActionButtonMenu({
    super.key,
    required this.expanded,
    required this.button,
    required this.content,
    this.horizontalAlignment = AlignmentDirectional.centerEnd,
    this.animationDuration = const Duration(milliseconds: 200), // Faster default
    this.staggerInterval = const Duration(milliseconds: 30), // Faster stagger
  });

  @override
  State<FloatingActionButtonMenu> createState() => _FloatingActionButtonMenuState();
}

class _FloatingActionButtonMenuState extends State<FloatingActionButtonMenu>
    with TickerProviderStateMixin {
  late AnimationController _staggerController;
  late Animation<double> _staggerAnimation;
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _staggerAnimation = CurvedAnimation(
      parent: _staggerController,
      curve: Curves.fastOutSlowIn,
    );
    
    if (widget.expanded) {
      _staggerController.forward();
    }
  }

  @override
  void didUpdateWidget(FloatingActionButtonMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expanded != oldWidget.expanded) {
      if (widget.expanded) {
        _staggerController.forward();
      } else {
        _staggerController.reverse();
        // Reset scroll position when closing
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 150), // Faster scroll reset
            curve: Curves.easeOut,
          );
        }
      }
    }
    
    if (widget.animationDuration != oldWidget.animationDuration) {
      _staggerController.duration = widget.animationDuration;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fixed: Remove horizontal padding to allow proper alignment
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: widget.horizontalAlignment == AlignmentDirectional.centerStart
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            // Scrollable menu items area
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: constraints.maxHeight - 100, // Reserve space for button and padding
              ),
              child: AnimatedBuilder(
                animation: _staggerAnimation,
                builder: (context, child) {
                  return FloatingActionButtonMenuItemColumn(
                    expanded: widget.expanded,
                    horizontalAlignment: widget.horizontalAlignment,
                    staggerAnimation: _staggerAnimation,
                    staggerInterval: widget.staggerInterval,
                    scrollController: _scrollController,
                    content: widget.content,
                    buttonAlignment: widget.horizontalAlignment
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            // Fixed button at bottom with proper alignment
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: widget.horizontalAlignment == AlignmentDirectional.centerStart
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: widget.button(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class FloatingActionButtonMenuItemColumn extends StatefulWidget {
  final bool expanded;
  final AlignmentDirectional horizontalAlignment;
  final Animation<double> staggerAnimation;
  final Duration staggerInterval;
  final ScrollController scrollController;
  final Widget Function(FloatingActionButtonMenuScope) content;
  final AlignmentDirectional buttonAlignment; // Add this parameter

  const FloatingActionButtonMenuItemColumn({
    required this.expanded,
    required this.horizontalAlignment,
    required this.staggerAnimation,
    required this.staggerInterval,
    required this.scrollController,
    required this.content,
    required this.buttonAlignment, // Add this parameter
  });

  @override
  State<FloatingActionButtonMenuItemColumn> createState() => FloatingActionButtonMenuItemColumnState();
}

class FloatingActionButtonMenuItemColumnState extends State<FloatingActionButtonMenuItemColumn> {
  List<GlobalKey> _itemKeys = [];
  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    final scope = MenuScopeWithStagger(
      widget.horizontalAlignment,
      widget.staggerAnimation,
      widget.staggerInterval,
      (count) {
        setState(() {
          _itemCount = count;
          _itemKeys = List.generate(count, (index) => GlobalKey());
        });
      },
      _itemCount,
    );
    
    // Align items exactly with the button - same positioning as the button
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: widget.buttonAlignment == AlignmentDirectional.centerStart ? 16.0 : 0,
        right: widget.buttonAlignment == AlignmentDirectional.centerEnd ? 16.0 : 0,
        bottom: 8.0, // Minimal bottom padding for scrolling behind button
      ),
      child: SingleChildScrollView(
        controller: widget.scrollController,
        physics: widget.expanded ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: widget.horizontalAlignment == AlignmentDirectional.centerStart
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            widget.content(scope),
          ],
        ),
      ),
    );
  }
}

class MenuScopeWithStagger implements FloatingActionButtonMenuScope {
  @override
  final AlignmentDirectional horizontalAlignment;
  final Animation<double> staggerAnimation;
  final Duration staggerInterval;
  final Function(int) onItemCountChanged;
  final int currentItemCount;
  int _itemIndex = 0;

  MenuScopeWithStagger(
    this.horizontalAlignment,
    this.staggerAnimation,
    this.staggerInterval,
    this.onItemCountChanged,
    this.currentItemCount,
  );

  Widget item({
    required VoidCallback onPressed,
    required Widget text,
    required Widget icon,
    Color? containerColor,
    Color? contentColor,
  }) {
    final index = _itemIndex++;
    
    // Update item count if this is a new build
    if (_itemIndex > currentItemCount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onItemCountChanged(_itemIndex);
      });
    }
    
    return FloatingActionButtonMenuItem(
      onPressed: onPressed,
      text: text,
      icon: icon,
      index: index,
      totalItems: _itemIndex,
      staggerAnimation: staggerAnimation,
      staggerInterval: staggerInterval,
      containerColor: containerColor,
      contentColor: contentColor,
      horizontalAlignment: horizontalAlignment, // Pass alignment to item
    );
  }
}