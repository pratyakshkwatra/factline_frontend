import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:factline/api/models/post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCarousel extends StatefulWidget {
  final List<Post> posts;
  final Function(Post) onClick;

  const CustomCarousel({super.key, required this.posts, required this.onClick});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          controller: _controller,
          itemCount: widget.posts.length,
          itemBuilder: (context, index, realIndex) {
            final post = widget.posts[index];
            final imageUrl = index % 2 == 0
                ? "assets/news_bg_1.jpg"
                : "assets/news_bg_2.jpg";

            return GestureDetector(
              onTap: () async {
                widget.onClick(post);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.black45,
                          size: 40,
                        ),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.9),
                            Colors.black.withValues(alpha: 0.85),
                            Colors.black.withValues(alpha: 0.75),
                            Colors.black.withValues(alpha: 0.65),
                            Colors.black.withValues(alpha: 0.6),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (post.credibilityScore != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: post.credibilityScore! >= 70
                                        ? Colors.green.withValues(alpha: 0.5)
                                        : Colors.red.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "Cred: ${post.credibilityScore}%",
                                    style: GoogleFonts.merriweather(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: post.credibilityScore! >= 70
                                          ? Colors.green.shade100
                                          : Colors.red.shade100,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Text(
                            post.shortTitle ?? post.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.merriweather(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 148,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            enlargeFactor: 0.18,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 7),
            autoPlayAnimationDuration: const Duration(milliseconds: 900),
            onPageChanged: (index, reason) => setState(() => _current = index),
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.posts.asMap().entries.map((entry) {
            final bool isActive = entry.key == _current;
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                width: isActive ? 22 : 10,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isActive
                      ? Colors.black
                      : Colors.black.withValues(alpha: 0.5),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
