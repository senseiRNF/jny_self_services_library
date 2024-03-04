class LocalBluetoothJson {
  String? bluetoothRemoteId;
  String? bluetoothName;

  LocalBluetoothJson({this.bluetoothRemoteId, this.bluetoothName});

  LocalBluetoothJson.fromJson(Map<String, dynamic> json) {
    bluetoothRemoteId = json['bluetooth_remote_id'];
    bluetoothName = json['bluetooth_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bluetooth_remote_id'] = bluetoothRemoteId;
    data['bluetooth_name'] = bluetoothName;
    return data;
  }
}