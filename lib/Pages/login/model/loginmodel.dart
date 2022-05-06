

import 'dart:convert';

class LoginModel {
    LoginModel({
        required this.accessToken,
        required this.userPermissions,
    });

    String accessToken;
    List<String> userPermissions;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        accessToken: json["access_token"],
        userPermissions: List<String>.from(json["user_permissions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
    };
}


class LoginToken {
    LoginToken({
        required this.schoolId,
        required this.academicyearId,
        required this.mobileToken,
        this.staffId,
        required this.studentPresentDetailsId,
        this.guardianId,
        required this.type,
    });

    String schoolId;
    String academicyearId;
    String mobileToken;
    dynamic staffId;
    String studentPresentDetailsId;
    dynamic guardianId;
    String type;

    factory LoginToken.fromJson(Map<String, dynamic> json) => LoginToken(
        schoolId: json["SchoolId"],
        academicyearId: json["AcademicyearId"],
        mobileToken: json["MobileToken"],
        staffId: json["StaffId"],
        studentPresentDetailsId: json["StudentPresentDetailsId"],
        guardianId: json["GuardianId"],
        type: json["Type"],
    );

    Map<String, dynamic> toJson() => {
        "SchoolId": schoolId,
        "AcademicyearId": academicyearId,
        "MobileToken": mobileToken,
        "StaffId": staffId,
        "StudentPresentDetailsId": studentPresentDetailsId,
        "GuardianId": guardianId,
        "Type": type,
    };
}


