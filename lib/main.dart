

// Main App
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_optimization_01/bloc_implementation.dart';
import 'package:test_optimization_01/provider_implementation.dart';
import 'package:test_optimization_01/reverpod_implementation.dart';
import 'package:test_optimization_01/setstate_implementation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        Provider(create: (_) => TodoBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (_) => const HomeScreen(),
          '/setstate': (_) => const SetStateScreen(),
          '/provider': (_) => const ProviderScreen(),
          '/riverpod': (_) => const RiverpodScreen(),
          '/bloc': (_) => const BlocScreen(),
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('State Management Performance')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/setstate'),
              child: const Text('Test setState'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/provider'),
              child: const Text('Test Provider'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/riverpod'),
              child: const Text('Test Riverpod'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/bloc'),
              child: const Text('Test BLoC'),
            ),
          ],
        ),
      ),
    );
  }
}