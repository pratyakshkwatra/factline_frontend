import 'package:auto_route/auto_route.dart';
import 'package:factline/api/models/user.dart';
import 'package:factline/api/post.dart';
import 'package:factline/router/router.gr.dart';
import 'package:factline/services/auth.dart';
import 'package:factline/widgets/breaking_news_carousel.dart';
import 'package:factline/widgets/header.dart';
import 'package:factline/widgets/recommendations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeTab extends StatefulWidget {
  final AuthService authService;
  final FlutterSecureStorage secureStorage;
  final User user;
  const HomeTab({
    super.key,
    required this.authService,
    required this.secureStorage,
    required this.user,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  backgroundColor: const Color(0xffEFE9DC),
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
                        backgroundColor: const Color(0xffEFE9DC),
                        child: Icon(Icons.add, color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: const Color(0xffEFE9DC),
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
          CustomHeader(title: "Breaking News", onViewAllTap: null),
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
          CustomHeader(
            title: "Recommendations",
            onViewAllTap: (contextNew) async {
              if (contextNew.mounted) {
                await contextNew.router.push(
                  RecommendationsFullRoute(user: widget.user),
                );
              }
            },
          ),
          const SizedBox(height: 18),
          CustomRecommendations(user: widget.user, restrictedView: true),
        ],
      ),
    );
  }
}
