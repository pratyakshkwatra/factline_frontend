import 'package:auto_route/auto_route.dart';
import 'package:factline/api/models/user.dart';
import 'package:factline/widgets/recommendations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class RecommendationsFullScreen extends StatefulWidget {
  final User user;
  const RecommendationsFullScreen({super.key, required this.user});

  @override
  State<RecommendationsFullScreen> createState() =>
      _RecommendationsFullScreenState();
}

class _RecommendationsFullScreenState extends State<RecommendationsFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F5E9),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Recommendations",
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomRecommendations(
                      user: widget.user,
                      restrictedView: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
