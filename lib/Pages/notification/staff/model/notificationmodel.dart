import '../../Student/model/notificationmodel.dart';

class StaffListModel {
  StaffListModel({
    required this.staffId,
    required this.name,
    required this.section,
    required this.designation,
    required this.staffRole,
    required this.classTeacher,
    this.selected,
  });

  String staffId;
  String name;
  dynamic section;
  String? designation;
  String? staffRole;
  bool? classTeacher;
  bool? selected;

  factory StaffListModel.fromJson(Map<String, dynamic> json) => StaffListModel(
        staffId: json["staffId"],
        name: json["name"],
        section: json["section"],
        designation: json["designation"],
        staffRole: json["staffRole"],
        classTeacher: json["classTeacher"],
      );

  Map<String, dynamic> toJson() => {
        "staffId": staffId,
        "name": name,
        "section": section,
        "designation": designation,
        "staffRole": staffRole,
        "classTeacher": classTeacher,
      };
  @override
  bool operator ==(Object other) {
    return (other is StudentListModel) && other.presentDetailsId == staffId;
  }
}
