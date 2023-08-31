class Api {
  String? excType;
  String? sServerMessages;

  Api({this.excType, this.sServerMessages});

  Api.fromJson(Map<String, dynamic> json) {
    excType = json['exc_type'];
    sServerMessages = json['_server_messages'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['exc_type'] = excType;
    data['_server_messages'] = sServerMessages;
    return data;
  }
}
