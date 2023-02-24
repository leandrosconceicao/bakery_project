import 'package:bakery/libraries/utils.dart';

import '../../libraries/models.dart';

class Configs extends DefaultDatabaseInfo {
  num? daysOfWork;
  num? hoursPerDay;
  num? averageGain;
  num? averageGainPerTime;
  num? averageTimeInMinutes;

  Configs(
      {this.daysOfWork,
      this.hoursPerDay,
      this.averageGain,
      this.averageGainPerTime,
      this.averageTimeInMinutes,
      String? id,
      String? storeCode})
      : super(id: id, storeCode:  storeCode);

  Configs.fromJson(Map<String, dynamic> json)
      : daysOfWork = json['daysOfWork'],
        hoursPerDay = json['hoursPerDay'],
        averageGain = json['averageGain'],
        averageGainPerTime = json['averageGainPerTime'],
        averageTimeInMinutes = json['averageTimeInMinutes'],
        super(id: json['_id'], storeCode:  json['storeCode']);

  Map<String, dynamic> toJson() {
    return {
      "storeCode": storeCode,
      "daysOfWork": daysOfWork,
      "hoursPerDay": hoursPerDay,
      "averageGain": averageGain
    };
  }

  static List<Configs?> toList(List json) =>
      json.map((e) => Configs.fromJson(e)).toList();

  Money getAverageGain() {
    final func = Functions(number: averageGainPerTime ?? 0.0);
    return func.getMoney();
  }
}
