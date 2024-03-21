/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var  myDeskAgentModel = DeskAgentModel.fromJson(map);
*/

class DeskAgentModel {
  DeskAgent? deskAgent;

  DeskAgentModel({this.deskAgent});

  DeskAgentModel.fromJson(Map<String, dynamic> json) {
    deskAgent = json['deskAgent'] != null
        ? DeskAgent.fromJson(json['deskAgent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deskAgent != null) {
      data['deskAgent'] = deskAgent!.toJson();
    }
    return data;
  }
}

class DeskAgent {
  String? id;
  String? username;
  Event? event;

  DeskAgent({this.id, this.username, this.event});

  DeskAgent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    event = json['event'] != null ? Event.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    if (event != null) {
      data['event'] = event!.toJson();
    }
    return data;
  }
}

class Event {
  String? id;
  String? name;
  String? description;
  double? longitude;
  double? latitude;
  String? address;
  String? startTime;
  String? endTime;
  bool? isArchived;
  List<Attendee>? attendees;

  Event(
      {this.id,
      this.name,
      this.description,
      this.longitude,
      this.latitude,
      this.address,
      this.startTime,
      this.endTime,
      this.isArchived,
      this.attendees});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['address'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    isArchived = json['isArchived'];
    if (json['attendees'] != null) {
      attendees = <Attendee>[];
      json['attendees'].forEach((v) {
        attendees!.add(Attendee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['address'] = this.address;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['isArchived'] = this.isArchived;
    if (this.attendees != null) {
      data['attendees'] = this.attendees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendee {
  String? id;
  String? name;
  String? email;
  bool? isInvited;
  bool? hasAttended;

  Attendee({this.id, this.name, this.email, this.isInvited, this.hasAttended});

  Attendee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    isInvited = json['isInvited'];
    hasAttended = json['hasAttended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['isInvited'] = this.isInvited;
    data['hasAttended'] = this.hasAttended;
    return data;
  }
}
