import 'user.dart';

class Post {
  final int id;
  final String title;
  final String body;
  final User owner;
  final DateTime createdAt;
  final AnalysisStatus analysisStatus;
  final double analysisProgress;
  final String statusMessage;
  final String? shortTitle;
  final String? summaryEasy;
  final int? credibilityScore;
  final String? bias;
  final String? sentiment;
  final String? riskType;
  final String? altHeadlineNeutral;
  final String? altHeadlineSensational;
  final String? altHeadlineCalm;
  final AnalysisRaw? analysisRaw;
  final List<String> tags;
  final List<String> redFlags;
  final List<String> trustSignals;
  final List<Claim> claims;
  final bool isUpvoted;
  final bool isDownvoted;
  final int upvoteDownvoteCount;
  final int viewCount;
  final double lat;
  final double long;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.owner,
    required this.createdAt,
    required this.analysisStatus,
    required this.analysisProgress,
    required this.statusMessage,
    this.shortTitle,
    this.summaryEasy,
    this.credibilityScore,
    this.bias,
    this.sentiment,
    this.riskType,
    this.altHeadlineNeutral,
    this.altHeadlineSensational,
    this.altHeadlineCalm,
    this.analysisRaw,
    required this.tags,
    required this.redFlags,
    required this.trustSignals,
    required this.claims,
    required this.isUpvoted,
    required this.isDownvoted,
    required this.upvoteDownvoteCount,
    required this.viewCount,
    required this.lat,
    required this.long,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final List<Claim> claims = (json['claims'] as List? ?? [])
        .whereType<Map<String, dynamic>>()
        .map((claimJson) => Claim.fromJson(claimJson))
        .toList();

    final List<String> tags = (json['tags'] as List? ?? [])
        .map((e) => (e as Map?)?['tag']?.toString() ?? "")
        .where((tag) => tag.isNotEmpty)
        .toList();

    final List<String> redFlags = (json['red_flags'] as List? ?? [])
        .map((e) => (e as Map?)?['flag']?.toString() ?? "")
        .where((flag) => flag.isNotEmpty)
        .toList();

    final List<String> trustSignals = (json['trust_signals'] as List? ?? [])
        .map((e) {
          if (e is Map) return e['signal']?.toString();
          if (e is String) return e;
          return null;
        })
        .whereType<String>()
        .toList();
        
    return Post(
      id: json['id'] ?? -1,
      title: json['title'] ?? "",
      body: json['body'] ?? "",
      owner: User.fromJson(json['owner']),
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? "") ??
          DateTime.now(),
      analysisStatus: _stringToAnalysisStatus(
        json['analysis_status']?.toString(),
      ),
      analysisProgress: (json['analysis_progress'] is num)
          ? (json['analysis_progress'] as num).toDouble()
          : 0.0,
      statusMessage: json['status_message'] ?? "No status available",
      shortTitle: json['short_title'],
      summaryEasy: json['summary_easy'],
      credibilityScore: json['credibility_score'],
      bias: json['bias'],
      sentiment: json['sentiment'],
      riskType: json['risk_type'],
      altHeadlineNeutral: json['alt_headline_neutral'],
      altHeadlineSensational: json['alt_headline_sensational'],
      altHeadlineCalm: json['alt_headline_calm'],
      analysisRaw: (json['analysis_raw'] is Map<String, dynamic>)
          ? AnalysisRaw.fromJson(json['analysis_raw'])
          : null,
      tags: tags,
      redFlags: redFlags,
      trustSignals: trustSignals,
      claims: claims,
      isUpvoted: json["is_upvoted"],
      isDownvoted: json["is_downvoted"],
      upvoteDownvoteCount: json["upvote_downvote_count"],
      viewCount: json["view_count"],
      lat: json["latitude"],
      long: json["longitude"],
    );
  }

  static AnalysisStatus _stringToAnalysisStatus(String? status) {
    switch (status) {
      case 'PENDING':
        return AnalysisStatus.pending;
      case 'PROCESSING':
        return AnalysisStatus.processing;
      case 'COMPLETED':
        return AnalysisStatus.completed;
      case 'FAILED':
        return AnalysisStatus.failed;
      default:
        return AnalysisStatus.pending;
    }
  }
}

enum AnalysisStatus { pending, processing, completed, failed }

class AnalysisRaw {
  final Map<String, dynamic> data;

  AnalysisRaw(this.data);

  factory AnalysisRaw.fromJson(Map<String, dynamic> json) {
    return AnalysisRaw(json);
  }
}

class Claim {
  final String text;
  final int? credibilityScore;
  final String? confidence;
  final String? reason;
  final String? historicalContext;
  final List<String> sources;
  final List<String> factCheckSites;

  Claim({
    required this.text,
    this.credibilityScore,
    this.confidence,
    this.reason,
    this.historicalContext,
    required this.sources,
    required this.factCheckSites,
  });

  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
      text: json['text'] ?? "",
      credibilityScore: json['credibility_score'],
      confidence: json['confidence'],
      reason: json['reason'],
      historicalContext: json['historical_context'],
      sources: (json['sources'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      factCheckSites: (json['fact_check_sites'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
