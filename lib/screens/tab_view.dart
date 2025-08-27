import 'package:auto_route/auto_route.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:factline/api/models/user.dart';
import 'package:factline/router/router.gr.dart';
import 'package:factline/screens/game_ques.dart';
import 'package:factline/screens/home.dart';
import 'package:factline/screens/map.dart';
import 'package:factline/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  final AuthService authService;
  final FlutterSecureStorage secureStorage;
  final User user;
  const HomeScreen({
    super.key,
    required this.authService,
    required this.secureStorage,
    required this.user,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xffF8F5E9),
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: _currentIndex,
        indicatorColor: Colors.transparent,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.black.withValues(alpha: 0.8),
        borderWidth: 2,
        enableFloatingNavBar: true,
        enablePaddingAnimation: true,
        outlineBorderColor: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 50,
            spreadRadius: 5,
          ),
        ],
        onTap: (val) {
          setState(() {
            _currentIndex = val;
          });
        },
        items: [
          CrystalNavigationBarItem(
            icon: Icons.home,
            unselectedIcon: Icons.home_outlined,
            selectedColor: Colors.white,
          ),
          CrystalNavigationBarItem(
            icon: Icons.games,
            unselectedIcon: Icons.games_outlined,
            selectedColor: Colors.white,
          ),
          CrystalNavigationBarItem(
            icon: Icons.map,
            unselectedIcon: Icons.map_outlined,
            selectedColor: Colors.white,
          ),
        ],
      ),
      body: SafeArea(
  bottom: false,
  left: false,
  right: false,
  child: IndexedStack(
    index: _currentIndex,
    children: [
      HomeTab(
        authService: widget.authService,
        secureStorage: widget.secureStorage,
        user: widget.user,
      ),
      GameQuesTab(
        authService: widget.authService,
        secureStorage: widget.secureStorage,
        user: widget.user,
      ),
      MapTab(
        authService: widget.authService,
        secureStorage: widget.secureStorage,
        user: widget.user,
      ),
    ],
  ),
),

    );
  }
}
