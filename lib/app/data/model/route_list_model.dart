class RouteListModel {
  List<Result>? routes;

  RouteListModel();
  RouteListModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['result'] != null) {
      routes = <Result>[];
      json['result'].forEach((v) {
        routes!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (routes != null) {
      data['result'] = routes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? routes;

  Result({this.routes});

  Result.fromJson(Map<String, dynamic> json) {
    routes = json['routes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['routes'] = routes;
    return data;
  }
}
