import 'package:flutter/material.dart';

// Import all demo pages here
// import 'demos/app_bars_demo.dart';
// import 'demos/button_groups_demo.dart';
// import 'demos/carousel_demo.dart';
// import 'demos/common_buttons_demo.dart';
// import 'demos/extended_fab_demo.dart';
import 'demos/fabdemo.dart';
// import 'demos/fabs_demo.dart';
// import 'demos/icon_buttons_demo.dart';
import 'demos/wavydemo.dart';
// import 'demos/navigation_bar_demo.dart';
// import 'demos/navigation_rail_demo.dart';
// import 'demos/progress_indicators_demo.dart';
import 'demos/splitdemo.dart';
// import 'demos/toolbars_demo.dart';

void main() {
  runApp(const Material3ExpressiveDemoApp());
}

class Material3ExpressiveDemoApp extends StatelessWidget {
  const Material3ExpressiveDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material 3 Expressive Components',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  final List<DemoComponent> _components = [
    DemoComponent(
      title: 'App Bars',
      description: 'Top and bottom app bars with Material 3 styling',
      icon: Icons.view_headline,
      status: ComponentStatus.planned,
      route: '/app-bars',
      builder: (context) => const PlaceholderDemoPage(title: 'App Bars'),
    ),
    DemoComponent(
      title: 'Button Groups',
      description: 'New grouped button components for related actions',
      icon: Icons.smart_button,
      status: ComponentStatus.planned,
      isNew: true,
      route: '/button-groups',
      builder: (context) => const PlaceholderDemoPage(title: 'Button Groups'),
    ),
    DemoComponent(
      title: 'Carousel',
      description: 'Swipeable content carousel with Material 3 design',
      icon: Icons.view_carousel,
      status: ComponentStatus.planned,
      route: '/carousel',
      builder: (context) => const PlaceholderDemoPage(title: 'Carousel'),
    ),
    DemoComponent(
      title: 'Common Buttons',
      description: 'Standard button variations with updated styling',
      icon: Icons.smart_button,
      status: ComponentStatus.planned,
      route: '/common-buttons',
      builder: (context) => const PlaceholderDemoPage(title: 'Common Buttons'),
    ),
    DemoComponent(
      title: 'Extended FAB',
      description: 'Extended floating action buttons with animations',
      icon: Icons.add_circle,
      status: ComponentStatus.planned,
      route: '/extended-fab',
      builder: (context) => const PlaceholderDemoPage(title: 'Extended FAB'),
    ),
    DemoComponent(
      title: 'FAB Menu',
      description: 'Expandable floating action button menus',
      icon: Icons.menu_open,
      status: ComponentStatus.implemented,
      isNew: true,
      route: '/fab-menu',
      builder: (context) => const FabMenuDemoPage(),
    ),
    DemoComponent(
      title: 'FABs',
      description: 'Standard floating action buttons',
      icon: Icons.add,
      status: ComponentStatus.planned,
      route: '/fabs',
      builder: (context) => const PlaceholderDemoPage(title: 'FABs'),
    ),
    DemoComponent(
      title: 'Icon Buttons',
      description: 'Enhanced icon buttons with state animations',
      icon: Icons.radio_button_unchecked,
      status: ComponentStatus.planned,
      route: '/icon-buttons',
      builder: (context) => const PlaceholderDemoPage(title: 'Icon Buttons'),
    ),
    DemoComponent(
      title: 'Loading Indicator',
      description: 'New loading and progress indication patterns',
      icon: Icons.hourglass_empty,
      status: ComponentStatus.implemented,
      isNew: true,
      route: '/loading-indicator',
      builder: (context) => const WavyProgressIndicatorDemo(),
    ),
    DemoComponent(
      title: 'Navigation Bar',
      description: 'Bottom navigation with Material 3 styling',
      icon: Icons.navigation,
      status: ComponentStatus.planned,
      route: '/navigation-bar',
      builder: (context) => const PlaceholderDemoPage(title: 'Navigation Bar'),
    ),
    DemoComponent(
      title: 'Navigation Rail',
      description: 'Side navigation for larger screens',
      icon: Icons.view_sidebar,
      status: ComponentStatus.planned,
      route: '/navigation-rail',
      builder: (context) => const PlaceholderDemoPage(title: 'Navigation Rail'),
    ),
    DemoComponent(
      title: 'Progress Indicators',
      description: 'Linear and circular progress indicators',
      icon: Icons.waves,
      status: ComponentStatus.planned,
      route: '/progress-indicators',
      builder: (context) => const PlaceholderDemoPage(title: 'Progress Indicators'),
    ),
    DemoComponent(
      title: 'Split Button',
      description: 'New split button component for multiple actions',
      icon: Icons.call_split,
      status: ComponentStatus.implemented,
      isNew: true,
      route: '/split-button',
      builder: (context) => const SplitButtonsDemo(),
    ),
    DemoComponent(
      title: 'Toolbars',
      description: 'Contextual toolbars and action bars',
      icon: Icons.build,
      status: ComponentStatus.planned,
      isNew: true,
      route: '/toolbars',
      builder: (context) => const PlaceholderDemoPage(title: 'Toolbars'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          _buildHeader(context),
          _buildStatsSection(context),
          _buildComponentGrid(context),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar.large(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Material 3 Expressive'),
        
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.secondaryContainer,
              ],
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.widgets,
              size: 80,
              color: Colors.white54,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () => _showInfoDialog(context),
        ),
        IconButton(
          icon: const Icon(Icons.palette),
          onPressed: () => _showThemeDialog(context),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter Component Library',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'A comprehensive collection of Material 3 Expressive components '
              'ported from the official Jetpack Compose implementation.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final implemented = _components.where((c) => c.status == ComponentStatus.implemented).length;
    final inProgress = _components.where((c) => c.status == ComponentStatus.inProgress).length;
    final planned = _components.where((c) => c.status == ComponentStatus.planned).length;
    final newComponents = _components.where((c) => c.isNew).length;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Development Progress',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildStatItem(context, 'Implemented', implemented, Colors.green)),
                    Expanded(child: _buildStatItem(context, 'In Progress', inProgress, Colors.orange)),
                    Expanded(child: _buildStatItem(context, 'Planned', planned, Colors.blue)),
                    Expanded(child: _buildStatItem(context, 'New in M3', newComponents, Colors.purple)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, int count, Color color) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              count.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildComponentGrid(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(24.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildComponentCard(context, _components[index]),
          childCount: _components.length,
        ),
      ),
    );
  }

  Widget _buildComponentCard(BuildContext context, DemoComponent component) {
    final isAvailable = component.status == ComponentStatus.implemented;
    
    return Card(
      elevation: isAvailable ? 4 : 1,
      child: InkWell(
        onTap: isAvailable
            ? () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: component.builder),
                )
            : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getStatusColor(component.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      component.icon,
                      color: _getStatusColor(component.status),
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  if (component.isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'NEW',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                component.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isAvailable ? null : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  component.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _getStatusColor(component.status),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _getStatusText(component.status),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: _getStatusColor(component.status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  if (isAvailable)
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(ComponentStatus status) {
    switch (status) {
      case ComponentStatus.implemented:
        return Colors.green;
      case ComponentStatus.inProgress:
        return Colors.orange;
      case ComponentStatus.planned:
        return Colors.blue;
    }
  }

  String _getStatusText(ComponentStatus status) {
    switch (status) {
      case ComponentStatus.implemented:
        return 'Ready';
      case ComponentStatus.inProgress:
        return 'In Progress';
      case ComponentStatus.planned:
        return 'Planned';
    }
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About This Demo'),
        content: const Text(
          'This Flutter package provides Material 3 Expressive components '
          'that closely match the official Jetpack Compose implementation. '
          'Each component includes comprehensive demos, documentation, and '
          'customization options.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    // Implementation for theme switching would go here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Theme switching coming soon!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// Placeholder demo page for components that haven't been implemented yet
class PlaceholderDemoPage extends StatelessWidget {
  final String title;

  const PlaceholderDemoPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title Demo'),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                '$title Demo',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'This component is coming soon!\nImplementation is planned based on the Material 3 Expressive specifications.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Components'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Data models
class DemoComponent {
  final String title;
  final String description;
  final IconData icon;
  final ComponentStatus status;
  final bool isNew;
  final String route;
  final Widget Function(BuildContext) builder;

  const DemoComponent({
    required this.title,
    required this.description,
    required this.icon,
    required this.status,
    required this.route,
    required this.builder,
    this.isNew = false,
  });
}

enum ComponentStatus {
  implemented,
  inProgress,
  planned,
}

// Export the main app for use in main.dart
class Material3ExpressiveDemo {
  static Widget app() => const Material3ExpressiveDemoApp();
}