import '../../domain/entities/entities.dart';

class VariationMapper {
  static List<VariationEntity> fromList(Map json) {
    List<VariationEntity> list = [];

    int i = json["timestamp"].length > 30 ? json["timestamp"].length - 30 : 0;

    for (; i < json["timestamp"].length; i++) {
      list.add(VariationEntity(
        date: DateTime.fromMillisecondsSinceEpoch(json["timestamp"][i] * 1000),
        value: json["indicators"]["quote"][0]["open"][i],
      ));
    }

    return list;
  }
}
