import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(600, 400),
    center: true,
    backgroundColor: Colors.transparent,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'test height animation',
      home: const AnimatedScaffold(),
    );
  }
}

class AnimatedScaffold extends StatefulWidget {
  const AnimatedScaffold({super.key});

  @override
  _AnimatedScaffoldState createState() => _AnimatedScaffoldState();
}

class _AnimatedScaffoldState extends State<AnimatedScaffold> {
  bool _isSmall = false;

  void _toggleHeight() {
    setState(() {
      _isSmall = !_isSmall;
    });
    windowManager.setSize(
      _isSmall ? const Size(600, 200) : const Size(600, 400),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('test height animation'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _toggleHeight,
          child: const Text('Toggle Window Height'),
        ),
      ),
    );
  }
}
