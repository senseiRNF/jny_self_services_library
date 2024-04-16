class GateLogsJson {
  bool? success;
  int? statusCode;
  List<GateLogsData>? gateLogsData;

  GateLogsJson({this.success, this.statusCode, this.gateLogsData});

  GateLogsJson.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      gateLogsData = <GateLogsData>[];
      json['data'].forEach((v) {
        gateLogsData!.add(GateLogsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status_code'] = statusCode;
    if (gateLogsData != null) {
      data['data'] = gateLogsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GateLogsData {
  int? id;
  String? epc;
  int? status;
  int? gateNumber;
  String? timestamp;

  GateLogsData({this.id, this.epc, this.status, this.gateNumber, this.timestamp});

  GateLogsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    epc = json['epc'];
    status = json['status'];
    gateNumber = json['gate_number'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['epc'] = epc;
    data['status'] = status;
    data['gate_number'] = gateNumber;
    data['timestamp'] = timestamp;
    return data;
  }
}