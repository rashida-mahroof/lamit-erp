class Leadapi {
  String? exception;
  String? exc;
  String? sErrorMessage;

  Leadapi({this.exception, this.exc, this.sErrorMessage});

  Leadapi.fromJson(Map<String, dynamic> json) {
    exception = json['exception'];
    exc = json['exc'];
    sErrorMessage = json['_error_message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['exception'] = exception;
    data['exc'] = exc;
    data['_error_message'] = sErrorMessage;
    return data;
  }
}
