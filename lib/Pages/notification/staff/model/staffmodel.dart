

class StaffModel {
    StaffModel({
       
        required this.name, 
        this.designation,
        this.staffRole,
        
    });

    
    String name; 
    String? designation;
    String? staffRole;
    

    factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
       
        name: json["name"],   
        designation: json["designation"],
        staffRole: json["staffRole"],
        
    );

    Map<String, dynamic> toJson() => {
        
        "name": name,   
        "designation": designation,
        "staffRole": staffRole,
        
    };
}