import 'dart:math';
import 'package:factline/api/models/post.dart';
import 'package:factline/api/models/user.dart';
import 'package:factline/api/post.dart';
import 'package:factline/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class MapTab extends StatefulWidget {
  final AuthService authService;
  final FlutterSecureStorage secureStorage;
  final User user;

  const MapTab({
    super.key,
    required this.authService,
    required this.secureStorage,
    required this.user,
  });

  @override
  State<MapTab> createState() => _MapTabState();
}

final List<String> satelliteFallbackUrls = [
  'https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
];

Future<String> getWorkingTileUrl(List<String> urls) async {
  for (final url in urls) {
    final testUrl = url
        .replaceAll('{z}', '1')
        .replaceAll('{x}', '1')
        .replaceAll('{y}', '1');
    try {
      final res = await http
          .get(Uri.parse(testUrl))
          .timeout(const Duration(seconds: 2));
      if (res.statusCode == 200) return url;
    } catch (_) {}
  }
  return urls.last;
}

class _MapTabState extends State<MapTab> {
  late final MapController _mapController;

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  Color credibilityColor(int score) {
    if (score <= 20) {
      return Colors.red;
    } else if (score <= 40) {
      return Colors.orange;
    } else if (score <= 60) {
      return Colors.yellow;
    } else if (score <= 80) {
      return Colors.lime;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tileProvider = FMTCTileProvider(
      stores: const {'mapStore': BrowseStoreStrategy.readUpdateCreate},
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "News Map",
                  style: GoogleFonts.merriweather(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Expanded(
              child: FutureBuilder<List<Post>>(
                future: PostAPI().getRecommendations(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                        strokeWidth: 8,
                        color: Colors.black,
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No Data Available",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final List<Post> posts = snapshot.data!;

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: FutureBuilder<String>(
                      future: getWorkingTileUrl(satelliteFallbackUrls),
                      builder: (context, tileSnap) {
                        if (!tileSnap.hasData) {
                          return Shimmer(
                            color: Colors.white,
                            colorOpacity: 0.75,
                            child: Container(color: Colors.grey.shade300),
                          );
                        }

                        return FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            minZoom: 3,
                            maxZoom: 18,
                            initialZoom: 4,
                            initialCenter: LatLng(posts[0].lat, posts[0].long),
                            interactionOptions: const InteractionOptions(
                              flags: InteractiveFlag.all,
                            ),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: tileSnap.data!,
                              userAgentPackageName: 'com.example.factline_app',
                              subdomains: ["a", "b", "c"],
                              tileProvider: tileProvider,
                            ),

                            // MarkerLayer(
                            //   markers: posts.map((post) {
                            //     final score = post.credibilityScore ?? 50;
                            //     return Marker(
                            //       point: LatLng(post.lat, post.long),
                            //       width: 40,
                            //       height: 40,
                            //       child: Icon(
                            //         Icons.location_pin,
                            //         size: 40,
                            //         color: credibilityColor(score),
                            //       ),
                            //     );
                            //   }).toList(),
                            // ),
                            MarkerLayer(
                              markers: List.generate(15, (index) {
                                final score = Random().nextInt(101);

                                final lat =
                                    28.6139 +
                                    (Random().nextDouble() - 0.5) * 0.1;
                                final lon =
                                    77.2090 +
                                    (Random().nextDouble() - 0.5) * 0.1;

                                final color = [
                                  Colors.red,
                                  Colors.orange,
                                  Colors.yellow,
                                  Colors.lime,
                                  Colors.green,
                                ][(score / 20).floor().clamp(0, 4)];

                                return Marker(
                                  point: LatLng(lat, lon),
                                  width: 40,
                                  height: 40,
                                  child: Icon(
                                    Icons.location_pin,
                                    size: 40,
                                    color: color,
                                  ),
                                );
                              }),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
