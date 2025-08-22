import 'package:auto_route/auto_route.dart';
import 'package:factline/api/post.dart';
import 'package:factline/router/router.gr.dart';
import 'package:factline/services/auth.dart';
import 'package:factline/widgets/breaking_news_carousel.dart';
import 'package:factline/widgets/header.dart';
import 'package:factline/widgets/recommendations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  final AuthService authService;
  final FlutterSecureStorage secureStorage;
  const HomeScreen({
    super.key,
    required this.authService,
    required this.secureStorage,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade200.withValues(
                        alpha: 0.7,
                      ),
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.router.push(
                              AddPostRoute(
                                authService: widget.authService,
                                secureStorage: widget.secureStorage,
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade200.withValues(
                              alpha: 0.7,
                            ),
                            child: Icon(Icons.add, color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200.withValues(
                            alpha: 0.7,
                          ),
                          child: Badge(
                            backgroundColor: Colors.redAccent,
                            child: Icon(
                              Icons.notifications_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              CustomHeader(title: "Breaking News"),
              const SizedBox(height: 18),
              BreakingNewsCarousel(
                onClick: (post) async {
                  await PostAPI().viewPost(post.id);
                  setState(() {});
                  if (context.mounted) {
                    await context.router.push(NewsFullRoute(post: post));
                  }
                },
              ),
              const SizedBox(height: 18),
              CustomHeader(title: "Recommendations"),
              const SizedBox(height: 18),
              CustomRecommendations(),
            ],
          ),
        ),
      ),
    );
  }
}
