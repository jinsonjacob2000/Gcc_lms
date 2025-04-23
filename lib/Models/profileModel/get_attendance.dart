class Attendance {
  final int id;
  final int studentId;
  final int batchId;
  final DateTime date;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Batch batch;

  Attendance({
    required this.id,
    required this.studentId,
    required this.batchId,
    required this.date,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.batch,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        id: json["id"],
        studentId: json["studentId"],
        batchId: json["batchId"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        batch: Batch.fromJson(json["Batch"]),
      );
}

class Batch {
  final String batchName;

  Batch({
    required this.batchName,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        batchName: json["batchName"],
      );
}

class AttendanceResponse {
  final List<Attendance> attendance;
  final int attendanceCount;

  AttendanceResponse({
    required this.attendance,
    required this.attendanceCount,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) =>
      AttendanceResponse(
        attendance: List<Attendance>.from(
            json["attendance"].map((x) => Attendance.fromJson(x))),
        attendanceCount: json["attendanceCount"],
      );
}
