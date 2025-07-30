import 'package:flutter/material.dart';
import '../widgets/Fab_menu/floating_action_button_menu.dart';
import '../widgets/Fab_menu/toggle_floating_action_button.dart';
import '../widgets/Fab_menu/fab_menu_defaults.dart';

class FabMenuDemoPage extends StatefulWidget {
  const FabMenuDemoPage({super.key});

  @override
  State<FabMenuDemoPage> createState() => _FabMenuDemoPageState();
}

class _FabMenuDemoPageState extends State<FabMenuDemoPage> {
  // FAB states
  bool _primaryExpanded = false;
  bool _secondaryExpanded = false;
  bool _tertiaryExpanded = false;
  bool _customExpanded = false;

  // Demo controls
  bool _showPrimaryFab = true;
  bool _showSecondaryFab = true;
  bool _showTertiaryFab = true;
  bool _showCustomFab = false;
  bool _useLeftAlignment = false;
  
  // Animation controls
  double _animationSpeed = 1.0;
  double _staggerDelay = 30.0; // Updated default
  
  // Style controls
  int _primaryItemCount = 4;
  int _secondaryItemCount = 3;
  int _tertiaryItemCount = 2;
  int _customItemCount = 12; // Increased to test scrolling better

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAB Menu Demo'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showControlsDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildQuickControls(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildAnimationControls(),
                  const SizedBox(height: 24),
                  _buildScrollingDemoSection(),
                  const SizedBox(height: 24),
                  _buildPresetsSection(),
                  const SizedBox(height: 24),
                  _buildUsageExampleSection(),
                  const SizedBox(height: 24),
                  _buildBehaviorSection(),
                  const SizedBox(height: 24),
                  _buildStatusGrid(),
                  const SizedBox(height: 150), // Extra space for FAB menus
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildDemoFabs(context),
    );
  }

  Widget _buildScrollingDemoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alignment & Scrolling Demo',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Menu items now align perfectly with the close button edges and have a smaller gap for tighter grouping.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildScrollingFeature(
                    Icons.straighten,
                    'Perfect Alignment',
                    'Menu items align exactly with button edges',
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildScrollingFeature(
                    Icons.compress,
                    'Smaller Gap',
                    'Reduced spacing for tighter grouping',
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildScrollingFeature(
                    Icons.layers,
                    'Stack Scrolling',
                    'Items scroll behind the fixed close button',
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildScrollingFeature(
                    Icons.center_focus_weak,
                    'Icon Positioning',
                    'Icons stay closest to screen center',
                    Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.touch_app,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Enable the Custom FAB (12 items) to test scrolling. Notice how items align perfectly with the button edge.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollingFeature(IconData icon, String title, String description, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPresetsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Presets & Defaults',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'The FAB Menu implementation includes several preset action sets and default configurations for easy setup.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildPresetChip('Edit Actions', FabMenuPresets.editActions.length, Icons.edit),
                _buildPresetChip('Social Actions', FabMenuPresets.socialActions.length, Icons.favorite),
                _buildPresetChip('Navigation', FabMenuPresets.navigationActions.length, Icons.navigation),
                _buildPresetChip('Media Actions', FabMenuPresets.mediaActions.length, Icons.photo_camera),
                _buildPresetChip('File Actions', FabMenuPresets.fileActions.length, Icons.folder),
                _buildPresetChip('Communication', FabMenuPresets.communicationActions.length, Icons.call),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Use FabMenuBuilder.buildPresetMenu() for quick setup with these presets',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageExampleSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Simple Usage Example',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''// Create a FAB menu with preset actions
FabMenuBuilder.buildPresetMenu(
  expanded: isExpanded,
  onExpandedChanged: (value) => setState(() => isExpanded = value),
  actions: FabMenuPresets.editActions,
  onActionPressed: (action) => handleAction(action),
  context: context,
  style: FabMenuStyle.primary,
  alignment: AlignmentDirectional.centerEnd, // or centerStart
  animationDuration: Duration(milliseconds: 200), // Fast & responsive
  staggerInterval: Duration(milliseconds: 30),     // Quick stagger
);

// Or use custom actions with scrolling support
FabMenuBuilder.buildPresetMenu(
  expanded: isExpanded,
  onExpandedChanged: (value) => setState(() => isExpanded = value),
  actions: [
    FabMenuAction(icon: Icons.add, label: 'Add', action: 'add'),
    FabMenuAction(icon: Icons.edit, label: 'Edit', action: 'edit'),
    // ... up to 15+ items with automatic scrolling
  ],
  onActionPressed: (action) => print('Action: \$action'),
  context: context,
  style: FabMenuStyle.secondary,
);''',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'The defaults handle all Material 3 styling, animations, and scrolling automatically',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBehaviorSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enhanced Behaviors',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            // Morphing Animation
            _buildBehaviorItem(
              Icons.transform,
              'Morphing Animation',
              'FABs transform into close buttons with scale and morph effects, originating from the top corner',
              Colors.blue,
            ),
            
            const SizedBox(height: 12),
            
            // Edge Alignment
            _buildBehaviorItem(
              Icons.straighten,
              'Perfect Edge Alignment',
              'Menu items align exactly with close button edges, not screen edges. Smaller gap for tighter grouping',
              Colors.green,
            ),
            
            const SizedBox(height: 12),
            
            // Scrolling
            _buildBehaviorItem(
              Icons.layers,
              'Intelligent Scrolling',
              'When screen height is limited, menu items scroll behind the fixed close button. Perfect for many items',
              Colors.orange,
            ),
            
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.speed,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Menu items now align perfectly with button edges and have tighter spacing. Animations are 33% faster.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBehaviorItem(IconData icon, String title, String description, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPresetChip(String label, int count, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text('$label ($count)'),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        fontSize: 12,
      ),
    );
  }

  Widget _buildQuickControls() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickToggle('Primary', _showPrimaryFab, (value) {
                setState(() {
                  _showPrimaryFab = value;
                  if (!value) _primaryExpanded = false;
                });
              }),
              _buildQuickToggle('Secondary', _showSecondaryFab, (value) {
                setState(() {
                  _showSecondaryFab = value;
                  if (!value) _secondaryExpanded = false;
                });
              }),
              _buildQuickToggle('Tertiary', _showTertiaryFab, (value) {
                setState(() {
                  _showTertiaryFab = value;
                  if (!value) _tertiaryExpanded = false;
                });
              }),
              _buildQuickToggle('Custom', _showCustomFab, (value) {
                setState(() {
                  _showCustomFab = value;
                  if (!value) _customExpanded = false;
                });
              }),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.align_horizontal_left, size: 20),
              const SizedBox(width: 8),
              const Text('Left Align'),
              Switch(
                value: _useLeftAlignment,
                onChanged: (value) {
                  setState(() {
                    _useLeftAlignment = value;
                    // Close all FABs when switching alignment
                    _primaryExpanded = false;
                    _secondaryExpanded = false;
                    _tertiaryExpanded = false;
                    _customExpanded = false;
                  });
                },
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _closeAllFabs,
                icon: const Icon(Icons.close_fullscreen, size: 18),
                label: const Text('Close All'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickToggle(String label, bool value, ValueChanged<bool> onChanged) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interactive FAB Menu Demo',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Test different configurations and animations. Use the controls above to enable/disable FAB menus and adjust settings.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildAnimationControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Animation Controls',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Speed: ${_animationSpeed.toStringAsFixed(1)}x'),
                      Slider(
                        value: _animationSpeed,
                        min: 0.5,
                        max: 3.0,
                        divisions: 10,
                        onChanged: (value) => setState(() => _animationSpeed = value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Stagger: ${_staggerDelay.round()}ms'),
                      Slider(
                        value: _staggerDelay,
                        min: 10.0,
                        max: 100.0,
                        divisions: 9,
                        onChanged: (value) => setState(() => _staggerDelay = value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FAB Menu Status',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            if (_showPrimaryFab) _buildStatusCard(
              'Primary FAB',
              _primaryExpanded,
              Colors.blue,
              _primaryItemCount,
              () => setState(() => _primaryExpanded = !_primaryExpanded),
            ),
            if (_showSecondaryFab) _buildStatusCard(
              'Secondary FAB',
              _secondaryExpanded,
              Colors.green,
              _secondaryItemCount,
              () => setState(() => _secondaryExpanded = !_secondaryExpanded),
            ),
            if (_showTertiaryFab) _buildStatusCard(
              'Tertiary FAB',
              _tertiaryExpanded,
              Colors.orange,
              _tertiaryItemCount,
              () => setState(() => _tertiaryExpanded = !_tertiaryExpanded),
            ),
            if (_showCustomFab) _buildStatusCard(
              'Custom FAB',
              _customExpanded,
              Colors.purple,
              _customItemCount,
              () => setState(() => _customExpanded = !_customExpanded),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusCard(String title, bool isExpanded, Color color, int itemCount, VoidCallback onTap) {
    return Card(
      elevation: isExpanded ? 4 : 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: color,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                isExpanded ? 'Expanded' : 'Collapsed',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isExpanded ? color : Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: isExpanded ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
              Text(
                '$itemCount items',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDemoFabs(BuildContext context) {
    final alignment = _useLeftAlignment ? AlignmentDirectional.centerStart : AlignmentDirectional.centerEnd;
    final fabPosition = _useLeftAlignment ? 16.0 : null;
    final fabRight = _useLeftAlignment ? null : 16.0;

    return Stack(
      children: [
        // Primary FAB Menu
        if (_showPrimaryFab)
          Positioned(
            bottom: 16,
            left: fabPosition,
            right: fabRight,
            child: _buildPrimaryFabMenu(context, alignment),
          ),
        // Secondary FAB Menu
        if (_showSecondaryFab)
          Positioned(
            bottom: 100,
            left: fabPosition,
            right: fabRight,
            child: _buildSecondaryFabMenu(context, alignment),
          ),
        // Tertiary FAB Menu
        if (_showTertiaryFab)
          Positioned(
            bottom: 184,
            left: fabPosition,
            right: fabRight,
            child: _buildTertiaryFabMenu(context, alignment),
          ),
        // Custom FAB Menu
        if (_showCustomFab)
          Positioned(
            bottom: 268,
            left: fabPosition,
            right: fabRight,
            child: _buildCustomFabMenu(context, alignment),
          ),
      ],
    );
  }

  Widget _buildPrimaryFabMenu(BuildContext context, AlignmentDirectional alignment) {
    // Using the new FabMenuBuilder for cleaner code
    return FabMenuBuilder.buildPresetMenu(
      expanded: _primaryExpanded,
      onExpandedChanged: (value) => setState(() => _primaryExpanded = value),
      actions: FabMenuPresets.editActions.take(_primaryItemCount).toList(),
      onActionPressed: (action) => _showSnackBar('$action pressed'),
      context: context,
      style: FabMenuStyle.primary,
      alignment: alignment,
      animationDuration: Duration(milliseconds: (200 / _animationSpeed).round()),
      staggerInterval: Duration(milliseconds: _staggerDelay.round()),
    );
  }

  Widget _buildSecondaryFabMenu(BuildContext context, AlignmentDirectional alignment) {
    // Using preset social actions with secondary styling
    return FabMenuBuilder.buildPresetMenu(
      expanded: _secondaryExpanded,
      onExpandedChanged: (value) => setState(() => _secondaryExpanded = value),
      actions: FabMenuPresets.socialActions.take(_secondaryItemCount).toList(),
      onActionPressed: (action) => _showSnackBar('$action pressed'),
      context: context,
      style: FabMenuStyle.secondary,
      alignment: alignment,
      animationDuration: Duration(milliseconds: (200 / _animationSpeed).round()),
      staggerInterval: Duration(milliseconds: _staggerDelay.round()),
      toggleIcon: Icons.more_horiz,
    );
  }

  Widget _buildTertiaryFabMenu(BuildContext context, AlignmentDirectional alignment) {
    // Using custom navigation actions with tertiary styling
    final settingsActions = [
      FabMenuAction(icon: Icons.palette, label: 'Theme', action: 'theme'),
      FabMenuAction(icon: Icons.notifications, label: 'Alerts', action: 'alerts'),
      FabMenuAction(icon: Icons.language, label: 'Language', action: 'language'),
    ];
    
    return FabMenuBuilder.buildPresetMenu(
      expanded: _tertiaryExpanded,
      onExpandedChanged: (value) => setState(() => _tertiaryExpanded = value),
      actions: settingsActions.take(_tertiaryItemCount).toList(),
      onActionPressed: (action) => _showSnackBar('$action pressed'),
      context: context,
      style: FabMenuStyle.tertiary,
      alignment: alignment,
      animationDuration: Duration(milliseconds: (200 / _animationSpeed).round()),
      staggerInterval: Duration(milliseconds: _staggerDelay.round()),
      toggleIcon: Icons.settings,
    );
  }

  Widget _buildCustomFabMenu(BuildContext context, AlignmentDirectional alignment) {
    // Custom fab menu with many items to test scrolling
    final customActions = [
      FabMenuAction(icon: Icons.star, label: 'Star', action: 'star', containerColor: const Color(0xFFFFD700).withOpacity(0.15), contentColor: const Color(0xFFFFD700)),
      FabMenuAction(icon: Icons.favorite, label: 'Love', action: 'love', containerColor: const Color(0xFFFF1744).withOpacity(0.15), contentColor: const Color(0xFFFF1744)),
      FabMenuAction(icon: Icons.thumb_up, label: 'Like', action: 'like', containerColor: const Color(0xFF00BCD4).withOpacity(0.15), contentColor: const Color(0xFF00BCD4)),
      FabMenuAction(icon: Icons.share, label: 'Share', action: 'share', containerColor: const Color(0xFF4CAF50).withOpacity(0.15), contentColor: const Color(0xFF4CAF50)),
      FabMenuAction(icon: Icons.comment, label: 'Comment', action: 'comment', containerColor: const Color(0xFFFF9800).withOpacity(0.15), contentColor: const Color(0xFFFF9800)),
      FabMenuAction(icon: Icons.bookmark, label: 'Save', action: 'save', containerColor: const Color(0xFF9C27B0).withOpacity(0.15), contentColor: const Color(0xFF9C27B0)),
      FabMenuAction(icon: Icons.flag, label: 'Report', action: 'report', containerColor: const Color(0xFFE91E63).withOpacity(0.15), contentColor: const Color(0xFFE91E63)),
      FabMenuAction(icon: Icons.info, label: 'Info', action: 'info', containerColor: const Color(0xFF2196F3).withOpacity(0.15), contentColor: const Color(0xFF2196F3)),
      FabMenuAction(icon: Icons.print, label: 'Print', action: 'print', containerColor: const Color(0xFF607D8B).withOpacity(0.15), contentColor: const Color(0xFF607D8B)),
      FabMenuAction(icon: Icons.download, label: 'Download', action: 'download', containerColor: const Color(0xFF8BC34A).withOpacity(0.15), contentColor: const Color(0xFF8BC34A)),
      FabMenuAction(icon: Icons.upload, label: 'Upload', action: 'upload', containerColor: const Color(0xFFFF5722).withOpacity(0.15), contentColor: const Color(0xFFFF5722)),
      FabMenuAction(icon: Icons.refresh, label: 'Refresh', action: 'refresh', containerColor: const Color(0xFF009688).withOpacity(0.15), contentColor: const Color(0xFF009688)),
    ];
    
    return FloatingActionButtonMenu(
      expanded: _customExpanded,
      horizontalAlignment: alignment,
      animationDuration: Duration(milliseconds: (200 / _animationSpeed).round()),
      staggerInterval: Duration(milliseconds: (_staggerDelay * 0.8).round()),
      button: () => ToggleFloatingActionButton(
        checked: _customExpanded,
        onChanged: (value) => setState(() => _customExpanded = value),
        animationDuration: Duration(milliseconds: (150 / _animationSpeed).round()),
        containerColor: (progress) => Color.lerp(
          const Color(0xFF6200EA),
          const Color(0xFFBB86FC),
          progress,
        )!,
        containerSize: (progress) => 56.0 + (72.0 - 56.0) * progress,
        containerCornerRadius: (progress) => 16.0 + (36.0 - 16.0) * progress,
        content: (scope) => FabMenuIconAnimations.shrinkMorphIcon(
          scope,
          uncheckedIcon: Icons.auto_awesome,
          checkedIcon: Icons.close,
          color: Colors.white,
          duration: Duration(milliseconds: (180 / _animationSpeed).round()),
        ),
      ),
      content: (scope) => Column(
        mainAxisSize: MainAxisSize.min,
        children: customActions.take(_customItemCount).map((action) {
          return scope.item(
            onPressed: () => _showSnackBar('${action.label} pressed'),
            text: Text(action.label),
            icon: Icon(action.icon),
            containerColor: action.containerColor,
            contentColor: action.contentColor,
          );
        }).toList(),
      ),
    );
  }

  void _closeAllFabs() {
    setState(() {
      _primaryExpanded = false;
      _secondaryExpanded = false;
      _tertiaryExpanded = false;
      _customExpanded = false;
    });
  }

  void _showControlsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Advanced Controls'),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildItemCountControl('Primary Items', _primaryItemCount, (value) {
                setState(() => _primaryItemCount = value);
                Navigator.pop(context);
              }),
              _buildItemCountControl('Secondary Items', _secondaryItemCount, (value) {
                setState(() => _secondaryItemCount = value);
                Navigator.pop(context);
              }),
              _buildItemCountControl('Tertiary Items', _tertiaryItemCount, (value) {
                setState(() => _tertiaryItemCount = value);
                Navigator.pop(context);
              }),
              _buildItemCountControl('Custom Items', _customItemCount, (value) {
                setState(() => _customItemCount = value);
                Navigator.pop(context);
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCountControl(String label, int currentValue, ValueChanged<int> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label),
          ),
          Expanded(
            flex: 3,
            child: Slider(
              value: currentValue.toDouble(),
              min: 2,
              max: 15, // Increased for better scrolling tests
              divisions: 13,
              label: currentValue.toString(),
              onChanged: (value) => onChanged(value.round()),
            ),
          ),
          Text(currentValue.toString()),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// Usage example for main.dart
class FabMenuApp extends StatelessWidget {
  const FabMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAB Menu Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const FabMenuDemoPage(),
    );
  }
}

void main() {
  runApp(const FabMenuApp());
}