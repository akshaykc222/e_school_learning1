class StudentListModel {
  StudentListModel({
    required this.presentDetailsId,
    required this.name,
    required this.admissionNo,
    required this.division,
    required this.course,
    required this.rollNo,
    required this.sectionOrder,
    required this.courseOrder,
    required this.divisionOrder,
    this.selected,
  });

  String presentDetailsId;
  String name;
  String? admissionNo;
  String? division;
  String? course;
  int? rollNo;
  int? sectionOrder;
  int? courseOrder;
  int? divisionOrder;
  bool? selected;
  factory StudentListModel.fromJson(Map<String, dynamic> json) =>
      StudentListModel(
        presentDetailsId: json["presentDetailsId"],
        name: json["name"],
        admissionNo: json["admissionNo"],
        division: json["division"],
        course: json["course"],
        rollNo: json["rollNo"],
        sectionOrder: json["sectionOrder"],
        courseOrder: json["courseOrder"],
        divisionOrder: json["divisionOrder"],
      );

  Map<String, dynamic> toJson() => {
        "presentDetailsId": presentDetailsId,
        "name": name,
        "admissionNo": admissionNo,
        "division": division,
        "course": course,
        "rollNo": rollNo,
        "sectionOrder": sectionOrder,
        "courseOrder": courseOrder,
        "divisionOrder": divisionOrder,
      };
}

class CourseList {
  CourseList({
    required this.courseId,
    required this.name,
    required this.sectionOrder,
    required this.courseOrder,
  });

  String courseId;
  String name;
  int sectionOrder;
  int courseOrder;

  factory CourseList.fromJson(Map<String, dynamic> json) => CourseList(
        courseId: json["courseId"],
        name: json["name"],
        sectionOrder: json["sectionOrder"],
        courseOrder: json["courseOrder"],
      );

  Map<String, dynamic> toJson() => {
        "courseId": courseId,
        "name": name,
        "sectionOrder": sectionOrder,
        "courseOrder": courseOrder,
      };
}

class DivisionList {
  DivisionList({
    required this.divisionId,
    required this.name,
    required this.sectionOrder,
    required this.courseOrder,
    required this.divisionOrder,
  });

  String divisionId;
  String name;
  int sectionOrder;
  int courseOrder;
  int divisionOrder;

  factory DivisionList.fromJson(Map<String, dynamic> json) => DivisionList(
        divisionId: json["divisionId"],
        name: json["name"],
        sectionOrder: json["sectionOrder"],
        courseOrder: json["courseOrder"],
        divisionOrder: json["divisionOrder"],
      );

  Map<String, dynamic> toJson() => {
        "divisionId": divisionId,
        "name": name,
        "sectionOrder": sectionOrder,
        "courseOrder": courseOrder,
        "divisionOrder": divisionOrder,
      };
}
