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