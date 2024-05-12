import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hero Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'Home',
      pageBuilder: (context, state) {
        return MaterialPage(
          child: HeroControllerScope(
            controller: MaterialApp.createMaterialHeroController(),
            child: const MyHomePage(),
          ),
        );
      },
      routes: [
        GoRoute(
            path: 'details',
            name: 'Details',
            pageBuilder: (context, state) {
              final indexStr = state.uri.queryParameters['index'] ?? '0';
              final index = int.tryParse(indexStr) ?? 0;
              return MaterialPage(
                child: DetailsPage(
                  index: index,
                ),
              );
            }),
      ],
    ),
  ],
);

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            10,
            (index) {
              return GestureDetector(
                  onTap: () => GoRouter.of(context).goNamed(
                        'Details',
                        queryParameters: {'index': index.toString()},
                      ),
                  child: HeroWidget(index: index));
            },
          ),
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Page'),
      ),
      body: Center(
        child: HeroWidget(index: index),
      ),
    );
  }
}

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'imageHero $index',
      child: Image.network(
        'https://picsum.photos/250?image=${index * 10}',
      ),
    );
  }
}
