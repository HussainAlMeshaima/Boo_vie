class BookError {
  Error error;

  BookError({this.error});

  BookError.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    return data;
  }
}

class Error {
  int code;
  String message;
  List<Errors> errors;

  Error({this.code, this.message, this.errors});

  Error.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['errors'] != null) {
      errors = new List<Errors>();
      json['errors'].forEach((v) {
        errors.add(new Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Errors {
  String message;
  String domain;
  String reason;
  String location;
  String locationType;

  Errors(
      {this.message,
      this.domain,
      this.reason,
      this.location,
      this.locationType});

  Errors.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    domain = json['domain'];
    reason = json['reason'];
    location = json['location'];
    locationType = json['locationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['domain'] = this.domain;
    data['reason'] = this.reason;
    data['location'] = this.location;
    data['locationType'] = this.locationType;
    return data;
  }
}
