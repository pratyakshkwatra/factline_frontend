import 'package:auto_route/auto_route.dart';
import 'package:factline/api/models/post.dart';
import 'package:factline/api/post.dart';
import 'package:factline/router/router.gr.dart';
import 'package:factline/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomRecommendations extends StatefulWidget {
  const CustomRecommendations({super.key});

  @override
  State<CustomRecommendations> createState() => _CustomRecommendationsState();
}

class _CustomRecommendationsState extends State<CustomRecommendations> {
  Future<List<Post>> getNewsArticles() async {
    List<Post> articles = await PostAPI().getRecommendations();
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FutureBuilder(
        future: getNewsArticles(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Shimmer(
                    color: Colors.grey.shade400,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                      width: MediaQuery.of(context).size.width,
                      height: 256,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,

                        border: Border.all(
                          color: Colors.grey.shade200.withValues(alpha: 0.6),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400.withValues(alpha: 0.2),
                            spreadRadius: 1,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          List<Post> posts = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: posts.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Post post = posts[index];
              return GestureDetector(
                onTap: () async {
                  await PostAPI().viewPost(post.id);
                  setState(() {});
                  if (context.mounted) {
                    await context.router.push(NewsFullRoute(post: post));
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade200.withValues(alpha: 0.6),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400.withValues(alpha: 0.2),
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 8),
                              CustomTag(tag: post.tags[0]),
                              const SizedBox(width: 4),
                              CustomTag(tag: post.tags[1]),
                              const SizedBox(width: 4),
                              CustomTag(tag: post.tags[2]),
                            ],
                          ),
                          Icon(Icons.more_horiz, color: Colors.grey.shade400),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          ReCase(
                            (post.credibilityScore! > 85
                                    ? "✅ "
                                    : post.credibilityScore! > 50
                                    ? "‼️ "
                                    : "❌ ") +
                                post.title,
                          ).titleCase,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          post.summaryEasy!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await PostAPI().upvotePost(post.id);
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.keyboard_arrow_up,
                                    size: 28,
                                    color: post.isUpvoted
                                        ? Colors.red.shade600
                                        : Colors.grey.shade400,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    NumberFormat.compact().format(
                                      post.upvoteDownvoteCount,
                                    ),
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () async {
                                    await PostAPI().downvotePost(post.id);
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 28,
                                    color: post.isDownvoted
                                        ? Colors.red.shade600
                                        : Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Spacer(),

                          Flexible(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.visibility,
                                  size: 20,
                                  color: Colors.grey.shade400,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  NumberFormat.compact().format(post.viewCount),
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
