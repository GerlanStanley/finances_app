import '../../domain/entities/entities.dart';

class VariationMapper {
  static List<VariationEntity> fromList(Map json) {
    List<VariationEntity> list = [];

    for (int i = 0; i < json["timestamp"].length; i++) {
      list.add(VariationEntity(
        date: DateTime.fromMillisecondsSinceEpoch(json["timestamp"][i] * 1000),
        value: json["indicators"]["open"][i],
      ));
    }

    return list;
  }
}
