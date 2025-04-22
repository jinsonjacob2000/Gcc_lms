class Lesson {
    int lessonId;
    int moduleId;
    int courseId;
    String title;
    String content;
    String videoLink;
    String? pdfPath;

    Lesson({
        required this.lessonId,
        required this.moduleId,
        required this.courseId,
        required this.title,
        required this.content,
        required this.videoLink,
        required this.pdfPath,
    });

    factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        lessonId: json["lessonId"],
        moduleId: json["moduleId"],
        courseId: json["courseId"],
        title: json["title"],
        content: json["content"],
        videoLink: json["videoLink"],
        pdfPath: json["pdfPath"],
    );

    Map<String, dynamic> toJson() => {
        "lessonId": lessonId,
        "moduleId": moduleId,
        "courseId": courseId,
        "title": title,
        "content": content,
        "videoLink": videoLink,
        "pdfPath": pdfPath,
    };
}