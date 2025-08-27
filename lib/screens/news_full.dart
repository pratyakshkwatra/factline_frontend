import 'package:auto_route/auto_route.dart';
import 'package:factline/api/models/post.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class NewsFullScreen extends StatefulWidget {
  final Post post;
  const NewsFullScreen({super.key, required this.post});

  @override
  State<NewsFullScreen> createState() => _NewsFullScreenState();
}

class _NewsFullScreenState extends State<NewsFullScreen> {
  String? _selectedAlt = "Neutral";
  bool _showTrustSignals = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Scaffold(
      backgroundColor: const Color(0xffF8F5E9),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onPressed: () => context.router.pop(),
        backgroundColor: Colors.black,
        label: const FaIcon(Icons.exit_to_app, color: Colors.white, size: 24),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title.toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(color: Colors.black),
              const SizedBox(height: 8),

              _buildSummary(post),

              _buildAltHeadlines(post),

              const SizedBox(height: 16),
              _buildClaims(post),

              const SizedBox(height: 16),

              if (post.body.isNotEmpty)
                Card(
                  color: const Color(0xffFFFFFF).withValues(alpha: 0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      post.body,
                      style: GoogleFonts.merriweather(
                        fontSize: 14,
                        height: 1.4,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummary(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Wrap(
              spacing: 8,
              children: post.tags
                  .map(
                    (t) => Text(
                      "#${t.replaceAll(' ', '_')}",
                      style: GoogleFonts.merriweather(
                        fontSize: 12,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

        if (post.summaryEasy != null)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: const Color(0xffFFFFFF).withValues(alpha: 0.6),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                post.summaryEasy!,
                style: GoogleFonts.merriweather(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        const SizedBox(height: 12),

        _buildAnalysis(post),
        const SizedBox(height: 12),
        const Divider(color: Colors.black),
        const SizedBox(height: 12),
        _buildSignals(post),
      ],
    );
  }

  Widget _buildSignals(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.trustSignals.isNotEmpty || post.redFlags.isNotEmpty)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.black87,
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: ExpansionTile(
                expansionAnimationStyle: AnimationStyle(
                  duration: const Duration(milliseconds: 500),
                ),
                minTileHeight: 16,
                shape: const Border(),
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                onExpansionChanged: (expanded) {
                  setState(() => _showTrustSignals = expanded);
                },
                trailing: AnimatedRotation(
                  turns: _showTrustSignals ? 0.5 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: const Icon(Icons.expand_more, color: Colors.white),
                ),
                title: Text(
                  "Trust Signals",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),

                childrenPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),

                children: [...post.trustSignals, ...post.redFlags]
                    .map(
                      (s) => Card(
                        color: Colors.grey.shade800.withValues(alpha: 0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              s,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),

        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildAnalysis(Post post) {
    return SizedBox(
      width: double.maxFinite,
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [
          if (post.credibilityScore != null)
            _infoChip(Icons.verified, "Credibility: ${post.credibilityScore}"),
          if (post.bias != null)
            _infoChip(Icons.compare_arrows, "Bias: ${post.bias}"),
          if (post.sentiment != null)
            _infoChip(
              Icons.sentiment_satisfied,
              "Sentiment: ${post.sentiment}",
            ),
          if (post.claims.isNotEmpty)
            _infoChip(Icons.window, "Claims: ${post.claims.length}"),
        ],
      ),
    );
  }

  Widget _buildAltHeadlines(Post post) {
    final altOptions = {
      "Neutral": post.altHeadlineNeutral,
      "Sensational": post.altHeadlineSensational,
      "Calm": post.altHeadlineCalm,
    }..removeWhere((k, v) => v == null);

    if (altOptions.isEmpty) return const SizedBox();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: double.maxFinite,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xffFFFFFF).withValues(alpha: 0.6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Alternate Headlines",
              style: GoogleFonts.merriweather(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: altOptions.keys.map((key) {
                final selected = _selectedAlt == key;
                return ChoiceChip(
                  label: Text(
                    key,
                    style: GoogleFonts.merriweather(color: Colors.white),
                  ),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      _selectedAlt = _selectedAlt != key ? key : null;
                    });
                  },
                  checkmarkColor: Colors.white,
                  selectedColor: Colors.black87,
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 8),

            if (_selectedAlt != null)
              Center(
                child: Card(
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      altOptions[_selectedAlt]!,
                      style: GoogleFonts.merriweather(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildClaims(Post post) {
    if (post.claims.isEmpty) return const SizedBox();

    return Column(
      children: [
        Divider(color: Colors.black87),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                "Claims",
                style: GoogleFonts.merriweather(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              ...post.claims.map((c) {
                bool expanded = false;

                return StatefulBuilder(
                  builder: (context, setState) => Card(
                    color: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 0,
                    child: ExpansionTile(
                      expansionAnimationStyle: const AnimationStyle(
                        duration: Duration(milliseconds: 400),
                      ),
                      shape: const Border(),
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      onExpansionChanged: (isOpen) =>
                          setState(() => expanded = isOpen),
                      trailing: AnimatedRotation(
                        turns: expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 400),
                        child: const Icon(
                          Icons.expand_more,
                          color: Colors.white70,
                        ),
                      ),
                      title: Text(
                        c.text,
                        style: GoogleFonts.merriweather(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      childrenPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      children: [
                        if (c.credibilityScore != null)
                          _buildClaimDetail(
                            icon: Icons.verified,
                            label: "Credibility: ${c.credibilityScore}",
                          ),
                        if (c.confidence != null)
                          _buildClaimDetail(
                            icon: Icons.assessment,
                            label: "Confidence: ${c.confidence}",
                          ),
                        if (c.reason != null)
                          _buildClaimDetail(
                            icon: Icons.info,
                            label: "Reason: ${c.reason}",
                          ),
                        if (c.historicalContext != null)
                          if (c.historicalContext!.isNotEmpty)
                            _buildClaimDetail(
                              icon: Icons.history,
                              label: "Context: ${c.historicalContext}",
                            ),
                        if (c.sources.isNotEmpty)
                          _buildClaimDetail(
                            icon: Icons.link,

                            label: "Coming Soon!",
                          ),
                        if (c.factCheckSites.isNotEmpty)
                          _buildClaimDetail(
                            icon: Icons.fact_check,
                            label: "Fact Check: ${c.factCheckSites.join(", ")}",
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClaimDetail({required IconData icon, required String label}) {
    return Card(
      color: Colors.grey.shade800.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.merriweather(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Colors.white),
      label: Text(label, style: GoogleFonts.merriweather(color: Colors.white)),
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    );
  }
}
