import 'package:factline/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await FMTCObjectBoxBackend().initialise(
      maxDatabaseSize: 100000000,
    );
    await FMTCStore('mapStore').manage.create();
  
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Factline',
      routerConfig: _appRouter.config(),
      themeAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
    );
  }
}
