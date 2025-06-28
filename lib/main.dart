import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/dream_journal_screen.dart';
import 'screens/relaxation_screen.dart';
import 'screens/sleep_tracking_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Temporarily disabled Firebase for testing
  // try {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: "your-api-key",
  //       appId: "your-app-id",
  //       messagingSenderId: "your-sender-id",
  //       projectId: "your-project-id",
  //     ),
  //   );
  //   debugPrint('Firebase initialized successfully');
  // } catch (e) {
  //   debugPrint('Firebase initialization failed: $e');
  //   // Continue without Firebase for now
  // }

  runApp(const SleepWellnessApp());
}

class SleepWellnessApp extends StatelessWidget {
  const SleepWellnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleep & Wellness',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const AuthFlow(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthFlow extends StatefulWidget {
  const AuthFlow({super.key});

  @override
  State<AuthFlow> createState() => _AuthFlowState();
}

class _AuthFlowState extends State<AuthFlow> {
  bool _showLogin = false;
  bool _isAuthenticated = false;

  void _onAuthSuccess() {
    setState(() => _isAuthenticated = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_isAuthenticated) {
      return const MainNavigationScreen();
    }
    return _showLogin
        ? LoginScreen(
            onSignUpTap: () => setState(() => _showLogin = false),
            onLoginSuccess: _onAuthSuccess,
          )
        : SignUpScreen(
            onLoginTap: () => setState(() => _showLogin = true),
            onSignUpSuccess: _onAuthSuccess,
          );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SleepTrackingScreen(),
    const DreamJournalScreen(),
    const RelaxationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bedtime),
            label: 'Sleep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Dreams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spa),
            label: 'Relax',
          ),
        ],
      ),
    );
  }
}
