import 'package:country_flags/country_flags.dart';
import 'package:factline/api/models/user.dart';
import 'package:factline/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recase/recase.dart';

class GameQuesTab extends StatefulWidget {
  final AuthService authService;
  final FlutterSecureStorage secureStorage;
  final User user;

  const GameQuesTab({
    super.key,
    required this.authService,
    required this.secureStorage,
    required this.user,
  });

  @override
  State<GameQuesTab> createState() => _GameQuesTabState();
}

class _GameQuesTabState extends State<GameQuesTab> {
  int currentStep = 0;

  String? selectedCategoryId;
  String? selectedCountryId;

  final List<Map<String, dynamic>> categories = [
    {"title": "General", "id": "general", "icon": Icons.category},
    {"title": "World", "id": "world", "icon": Icons.public},
    {"title": "Nation", "id": "nation", "icon": Icons.flag},
    {"title": "Business", "id": "business", "icon": Icons.business_center},
    {"title": "Technology", "id": "technology", "icon": Icons.computer},
    {"title": "Entertainment", "id": "entertainment", "icon": Icons.movie},
    {"title": "Sports", "id": "sports", "icon": Icons.sports_soccer},
    {"title": "Science", "id": "science", "icon": Icons.science},
    {"title": "Health", "id": "health", "icon": Icons.health_and_safety},
  ];

  final List<Map<String, String>> countries = [
    {"name": "Australia", "id": "au"},
    {"name": "Brazil", "id": "br"},
    {"name": "Canada", "id": "ca"},
    {"name": "China", "id": "cn"},
    {"name": "Egypt", "id": "eg"},
    {"name": "France", "id": "fr"},
    {"name": "Germany", "id": "de"},
    {"name": "Greece", "id": "gr"},
    {"name": "Hong Kong", "id": "hk"},
    {"name": "India", "id": "in"},
    {"name": "Ireland", "id": "ie"},
    {"name": "Italy", "id": "it"},
    {"name": "Japan", "id": "jp"},
    {"name": "Netherlands", "id": "nl"},
    {"name": "Norway", "id": "no"},
    {"name": "Peru", "id": "pe"},
    {"name": "Philippines", "id": "ph"},
    {"name": "Portugal", "id": "pt"},
    {"name": "Romania", "id": "ro"},
    {"name": "Russian Federation", "id": "ru"},
    {"name": "Singapore", "id": "sg"},
    {"name": "Sweden", "id": "se"},
    {"name": "Switzerland", "id": "ch"},
    {"name": "Taiwan", "id": "tw"},
    {"name": "Ukraine", "id": "ua"},
    {"name": "United Kingdom", "id": "gb"},
    {"name": "United States", "id": "us"},
  ];

  @override
  Widget build(BuildContext context) {
    String title = "";
    if (currentStep == 0) title = "Choose a Category";
    if (currentStep == 1) title = "Select Your Country";
    if (currentStep == 2) title = "Ready to Play?";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (currentStep > 0)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentStep = currentStep - 1;
                    });
                  },
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                ),
              const SizedBox(width: 8),
              if (currentStep != 2)
              Text(
                title,
                style: GoogleFonts.merriweather(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          if (currentStep == 0) ...[
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategoryId == category["id"];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryId = category["id"];
                        currentStep = 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.black.withValues(alpha: 0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Colors.black : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(category["icon"], color: Colors.black, size: 42),
                          const SizedBox(height: 12),
                          Text(
                            ReCase(category["title"]).titleCase,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.merriweather(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ] else if (currentStep == 1) ...[
            Expanded(
              child: ListView.separated(
                itemCount: countries.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final country = countries[index];
                  final isSelected = selectedCountryId == country["id"];

                  return ListTile(
                    tileColor: isSelected
                        ? Colors.black.withValues(alpha: 0.1)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected ? Colors.black : Colors.grey[300]!,
                        width: 2,
                      ),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CountryFlag.fromCountryCode(
                        country["id"]!,
                        height: 28,
                        width: 40,
                        shape: RoundedRectangle(8),
                      ),
                    ),
                    title: Text(
                      country["name"]!,
                      style: GoogleFonts.merriweather(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedCountryId = country["id"];
                        currentStep = 2;
                      });
                    },
                  );
                },
              ),
            ),
          ] else if (currentStep == 2) ...[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Ready to Play?",
                      style: GoogleFonts.merriweather(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        // debugPrint("Category: $selectedCategoryId");
                        // debugPrint("Country: $selectedCountryId");
                      },
                      child: Text(
                        "Start",
                        style: GoogleFonts.merriweather(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
