class Profile {
    int userId;
    String name;
    String email;
    String role;
    String phoneNumber;
    String profilePicture;
    String registrationId;

    Profile({
        required this.userId,
        required this.name,
        required this.email,
        required this.role,
        required this.phoneNumber,
        required this.profilePicture,
        required this.registrationId,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        phoneNumber: json["phoneNumber"],
        profilePicture: json["profilePicture"],
        registrationId: json["registrationId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "role": role,
        "phoneNumber": phoneNumber,
        "profilePicture": profilePicture,
        "registrationId": registrationId,
    };
}

class LeaveRequest {
    int id;
    DateTime leaveDate;
    String reason;
    String status;
    DateTime createdAt;

    LeaveRequest({
        required this.id,
        required this.leaveDate,
        required this.reason,
        required this.status,
        required this.createdAt,
    });

    factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
        id: json["id"],
        leaveDate: DateTime.parse(json["leaveDate"]),
        reason: json["reason"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "leaveDate": "${leaveDate.year.toString().padLeft(4, '0')}-${leaveDate.month.toString().padLeft(2, '0')}-${leaveDate.day.toString().padLeft(2, '0')}",
        "reason": reason,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
    };
}