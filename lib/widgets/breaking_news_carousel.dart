import 'package:factline/api/post.dart';
import 'package:factline/widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:factline/api/models/post.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BreakingNewsCarousel extends StatelessWidget {
  final Function(Post post) onClick;
  const BreakingNewsCarousel({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: PostAPI().getBreakingNews(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: [
              SizedBox(
                height: 148,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Shimmer(
                          color: Colors.white,
                          child: Container(color: Colors.grey.shade300),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Shimmer(
                    color: Colors.grey.shade100,
                    child: Container(
                      width: 10,
                      height: 8,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return CustomCarousel(posts: snapshot.data!, onClick: onClick);
      },
    );
  }
}
