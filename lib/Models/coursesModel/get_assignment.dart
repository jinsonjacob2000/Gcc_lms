class AssignmentResponse {
  final List<Assignment> assignments;

  AssignmentResponse({required this.assignments});

  factory AssignmentResponse.fromJson(Map<String, dynamic> json) {
    return AssignmentResponse(
      assignments: List<Assignment>.from(
        json['assignments'].map((x) => Assignment.fromJson(x)),
      ),
    );
  }
}

class Assignment {
  final int assignmentId;
  final String title;
  final String description;
  final DateTime dueDate;
  final String? submissionLink;

  Assignment({
    required this.assignmentId,
    required this.title,
    required this.description,
    required this.dueDate,
    this.submissionLink,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      assignmentId: json['assignmentId'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['dueDate']),
      submissionLink: json['submissionLink'],
    );
  }
}
