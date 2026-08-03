import 'package:freezed_annotation/freezed_annotation.dart';
part 'area.freezed.dart';
part 'area.g.dart';

@freezed
abstract class Area with _$Area {
  const factory Area({
    @JsonKey(name: 'strArea') required String area,
    @JsonKey(name: 'strCountry') required String country,
  }) = _Area;

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);
}
