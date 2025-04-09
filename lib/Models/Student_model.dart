// Course Category model for the advertising model,replace with the actual back  end data
class CourseCategory {
  final String heading;
  final String subheading;
  final String numberOfCourses;
  final String description;

  CourseCategory({
    required this.heading,
    required this.subheading,
    required this.numberOfCourses,
    required this.description,
  });
}

// Model to get the couse details of a student
class Course {
    int courseId;
    String courseName;
    String courseDescription;
    int batchId;
    String batchName;
    String status;

    Course({
        required this.courseId,
        required this.courseName,
        required this.courseDescription,
        required this.batchId,
        required this.batchName,
        required this.status,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseId: json["courseId"],
        courseName: json["courseName"],
        courseDescription: json["courseDescription"],
        batchId: json["batchId"],
        batchName: json["batchName"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "courseId": courseId,
        "courseName": courseName,
        "courseDescription": courseDescription,
        "batchId": batchId,
        "batchName": batchName,
        "status": status,
    };
}
