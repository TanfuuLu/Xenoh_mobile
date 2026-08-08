class ChallengeSummary {
  const ChallengeSummary({
    required this.id,
    required this.title,
    required this.description,
    required this.creatorId,
    required this.creatorName,
    required this.metricType,
    required this.accessType,
    required this.capacity,
    required this.acceptedCount,
    required this.reservedCount,
    required this.timeZoneId,
    required this.startsAtUtc,
    required this.endsAtUtc,
    required this.status,
    required this.canJoin,
  });

  factory ChallengeSummary.fromJson(Map<String, dynamic> json) =>
      ChallengeSummary(
        id: json['id'].toString(),
        title: json['title']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        creatorId: json['creatorId'].toString(),
        creatorName: json['creatorName']?.toString() ?? '',
        metricType: json['metricType']?.toString() ?? '',
        accessType: json['accessType']?.toString() ?? '',
        capacity: (json['capacity'] as num?)?.toInt() ?? 0,
        acceptedCount: (json['acceptedCount'] as num?)?.toInt() ?? 0,
        reservedCount: (json['reservedCount'] as num?)?.toInt() ?? 0,
        timeZoneId: json['timeZoneId']?.toString() ?? '',
        startsAtUtc: DateTime.parse(json['startsAtUtc'].toString()),
        endsAtUtc: DateTime.parse(json['endsAtUtc'].toString()),
        status: json['status']?.toString() ?? '',
        canJoin: json['canJoin'] == true,
      );

  final String id;
  final String title;
  final String description;
  final String creatorId;
  final String creatorName;
  final String metricType;
  final String accessType;
  final int capacity;
  final int acceptedCount;
  final int reservedCount;
  final String timeZoneId;
  final DateTime startsAtUtc;
  final DateTime endsAtUtc;
  final String status;
  final bool canJoin;
}

class Challenge extends ChallengeSummary {
  const Challenge({
    required super.id,
    required super.title,
    required super.description,
    required super.creatorId,
    required super.creatorName,
    required super.metricType,
    required super.accessType,
    required super.capacity,
    required super.acceptedCount,
    required super.reservedCount,
    required super.timeZoneId,
    required super.startsAtUtc,
    required super.endsAtUtc,
    required super.status,
    required super.canJoin,
    required this.targetSessionsPerWeek,
    required this.selectedLifts,
    required this.canManage,
    required this.joinClosed,
    required this.members,
    this.checkInPrompt,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    final summary = ChallengeSummary.fromJson(json);
    return Challenge(
      id: summary.id,
      title: summary.title,
      description: summary.description,
      creatorId: summary.creatorId,
      creatorName: summary.creatorName,
      metricType: summary.metricType,
      accessType: summary.accessType,
      capacity: summary.capacity,
      acceptedCount: summary.acceptedCount,
      reservedCount: summary.reservedCount,
      timeZoneId: summary.timeZoneId,
      startsAtUtc: summary.startsAtUtc,
      endsAtUtc: summary.endsAtUtc,
      status: summary.status,
      canJoin: summary.canJoin,
      targetSessionsPerWeek:
          (json['targetSessionsPerWeek'] as num?)?.toInt() ?? 0,
      selectedLifts: (json['selectedLifts'] as List<dynamic>? ?? const [])
          .map((item) => item.toString())
          .toList(),
      checkInPrompt: json['checkInPrompt']?.toString(),
      canManage: json['canManage'] == true,
      joinClosed: json['joinClosed'] == true,
      members: (json['members'] as List<dynamic>? ?? const [])
          .map((item) => ChallengeMember.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  final int targetSessionsPerWeek;
  final List<String> selectedLifts;
  final String? checkInPrompt;
  final bool canManage;
  final bool joinClosed;
  final List<ChallengeMember> members;
}

class ChallengeMember {
  const ChallengeMember({
    required this.userId,
    required this.fullName,
    required this.status,
    required this.isCreator,
    required this.checkedInToday,
    required this.completedSessions,
    required this.targetSessions,
    this.score,
    this.rank,
    this.avatarUrl,
    this.scoreUnit = '',
    this.baselineReady = true,
  });

  factory ChallengeMember.fromJson(Map<String, dynamic> json) =>
      ChallengeMember(
        userId: json['userId'].toString(),
        fullName: json['fullName']?.toString() ?? '',
        status: json['status']?.toString() ?? '',
        isCreator: json['isCreator'] == true,
        checkedInToday: json['checkedInToday'] == true,
        completedSessions: (json['completedSessions'] as num?)?.toInt() ?? 0,
        targetSessions: (json['targetSessions'] as num?)?.toInt() ?? 0,
        score: (json['score'] as num?)?.toDouble(),
        rank: (json['rank'] as num?)?.toInt(),
        avatarUrl: json['avatarUrl']?.toString(),
        scoreUnit: json['scoreUnit']?.toString() ?? '',
        baselineReady: json['baselineReady'] != false,
      );

  final String userId;
  final String fullName;
  final String status;
  final bool isCreator;
  final bool checkedInToday;
  final int completedSessions;
  final int targetSessions;
  final double? score;
  final int? rank;
  final String? avatarUrl;
  final String scoreUnit;
  final bool baselineReady;
}

class ChallengeInvitee {
  const ChallengeInvitee({
    required this.userId,
    required this.fullName,
    required this.relationship,
  });

  factory ChallengeInvitee.fromJson(Map<String, dynamic> json) =>
      ChallengeInvitee(
        userId: json['userId'].toString(),
        fullName: json['fullName']?.toString() ?? '',
        relationship: json['relationship']?.toString() ?? '',
      );

  final String userId;
  final String fullName;
  final String relationship;
}

class ChallengeInput {
  const ChallengeInput({
    required this.title,
    required this.description,
    required this.metricType,
    required this.accessType,
    required this.targetSessionsPerWeek,
    required this.selectedLifts,
    required this.capacity,
    required this.startsAtUtc,
    required this.endsAtUtc,
    this.checkInPrompt,
    this.inviteeUserIds = const [],
  });

  final String title;
  final String description;
  final String metricType;
  final String accessType;
  final int targetSessionsPerWeek;
  final List<String> selectedLifts;
  final String? checkInPrompt;
  final int capacity;
  final DateTime startsAtUtc;
  final DateTime endsAtUtc;
  final List<String> inviteeUserIds;

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'metricType': metricType,
    'accessType': accessType,
    'targetSessionsPerWeek': targetSessionsPerWeek,
    'selectedLifts': selectedLifts,
    'checkInPrompt': checkInPrompt,
    'capacity': capacity,
    'timeZoneId': 'Asia/Ho_Chi_Minh',
    'startsAtUtc': startsAtUtc.toUtc().toIso8601String(),
    'endsAtUtc': endsAtUtc.toUtc().toIso8601String(),
    'inviteeUserIds': inviteeUserIds,
  };
}
