class LiveSession {
  final String message;
  final String? liveLink;
  final DateTime? liveStartTime;

  LiveSession({
    required this.message,
    this.liveLink,
    this.liveStartTime,
  });

  factory LiveSession.fromJson(Map<String, dynamic> json) {
    return LiveSession(
      message: json['message'] ?? '',
      liveLink: json['liveLink'],
      liveStartTime: json['liveStartTime'] != null
          ? DateTime.parse(json['liveStartTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'liveLink': liveLink,
      'liveStartTime': liveStartTime?.toIso8601String(),
    };
  }
}
