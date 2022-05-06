

class StudentModel {
    StudentModel({
        required this.name,
        this.course,
        this.division,
    });

    String name;
    String? course;
    String? division;

    factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        name: json["name"],
        course: json["course"],
        division: json["division"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "course": course,
        "division": division,
    };
}