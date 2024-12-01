import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orchestra_rehearsal_scheduler/feature/auth/provider/auth_provider.dart';
import 'package:orchestra_rehearsal_scheduler/feature/auth/screen/login.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/screen/calendar_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  final bool isLoading;
  final bool isAuth;

  const App({super.key, this.isLoading = false, this.isAuth = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Orchestra Rehearsal Scheduler',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0D1627),
          ),
          useMaterial3: true,
        ),
        home: Consumer(
          builder: (context, ref, child) {
            final authInitializer = ref.watch(initializeAuthProvider);

            return authInitializer.when(
              data: (value) {
                return value ? const CalendarPage() : const Login();
              },
              loading: () => const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stackTrace) {
                return const Scaffold(
                  body: Center(
                    child: Text("Error"),
                  ),
                );
              },
            );
          },
        ));
  }
}
