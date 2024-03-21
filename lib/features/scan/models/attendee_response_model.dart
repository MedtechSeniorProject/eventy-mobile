/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myAttendeeResponseModelNode = AttendeeResponseModel.fromJson(map);
*/
class AttendeeResponseModel {
  String? id;
  String? name;
  String? email;
  bool? isInvited;
  bool? hasAttended;

  AttendeeResponseModel(
      {this.id, this.name, this.email, this.isInvited, this.hasAttended});

  AttendeeResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    isInvited = json['isInvited'];
    hasAttended = json['hasAttended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['isInvited'] = isInvited;
    data['hasAttended'] = hasAttended;
    return data;
  }
}
