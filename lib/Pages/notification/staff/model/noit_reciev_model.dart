class NotificationReceivedModel {
  NotificationReceivedModel({
    required this.createdDate,
    required this.toStaff,
    required this.toGuardian,
    required this.toStudent,
    required this.fromStaff,
    required this.title,
    required this.body,
  });

  DateTime createdDate;
  List<String> toStaff;
  List<dynamic> toGuardian;
  List<dynamic> toStudent;
  String fromStaff;
  String title;
  String body;

  factory NotificationReceivedModel.fromJson(Map<String, dynamic> json) =>
      NotificationReceivedModel(
        createdDate: DateTime.parse(json["createdDate"]),
        toStaff: json["toStaff"] == null
            ? []
            : List<String>.from(json["toStaff"].map((x) => x)),
        toGuardian: json["toGuardian"] == null
            ? []
            : List<dynamic>.from(json["toGuardian"].map((x) => x)),
        toStudent: json["toStudent"] == null
            ? []
            : List<dynamic>.from(json["toStudent"].map((x) => x)),
        fromStaff: json["fromStaff"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "createdDate": createdDate.toIso8601String(),
        "toStaff": List<dynamic>.from(toStaff.map((x) => x)),
        "toGuardian": List<dynamic>.from(toGuardian.map((x) => x)),
        "toStudent": List<dynamic>.from(toStudent.map((x) => x)),
        "fromStaff": fromStaff,
        "title": title,
        "body": body,
      };
}
