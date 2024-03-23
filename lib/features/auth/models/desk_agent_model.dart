/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var  myDeskAgentModel = DeskAgentModel.fromJson(map);
*/

class DeskAgentModel {
  DeskAgent? deskAgent;
  String? accessToken;

  DeskAgentModel({this.deskAgent, this.accessToken});

  DeskAgentModel.fromJson(Map<String, dynamic> json) {
    deskAgent = json['deskAgent'] != null
        ? new DeskAgent.fromJson(json['deskAgent'])
        : null;
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deskAgent != null) {
      data['deskAgent'] = this.deskAgent!.toJson();
    }
    data['accessToken'] = this.accessToken;
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
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    if (this.event != null) {
      data['event'] = this.event!.toJson();
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
  List<Attendees>? attendees;

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
      attendees = <Attendees>[];
      json['attendees'].forEach((v) {
        attendees!.add(new Attendees.fromJson(v));
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

class Attendees {
  String? id;
  String? name;
  String? email;
  bool? isInvited;
  bool? hasAttended;

  Attendees({this.id, this.name, this.email, this.isInvited, this.hasAttended});

  Attendees.fromJson(Map<String, dynamic> json) {
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
