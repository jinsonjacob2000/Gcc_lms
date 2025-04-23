


class Module {
    int moduleId;
    String title;
    String content;

    Module({
        required this.moduleId,
        required this.title,
        required this.content,
    });

    factory Module.fromJson(Map<String, dynamic> json) => Module(
        moduleId: json["moduleId"],
        title: json["title"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "moduleId": moduleId,
        "title": title,
        "content": content,
    };
}