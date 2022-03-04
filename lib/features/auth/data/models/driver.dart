import 'package:fixit/core/auth/authenticable.dart';
import 'package:fixit/core/models/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver.g.dart';

@JsonSerializable(explicitToJson: true)
class Driver extends Model implements Authenticable{
  final String? name;

  const Driver({
    required int id,
    required this.name,
  }) : super(id: id);

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DriverToJson(this);
}
