import 'package:equatable/equatable.dart';

final class ProvinceModel extends Equatable {
  const ProvinceModel({
    required this.value,
    required this.name,
    required this.districts,
  });

  factory ProvinceModel.fromMap(Map<String, dynamic> json) {
    return ProvinceModel(
      value: json['value'] as int,
      name: json['text'] as String,
      districts: (json['districts'] as List).map(
        (e) {
          final data = e as Map<String, dynamic>;
          return DistrictModel(data['value'] as int, data['text'] as String);
        },
      ).toList(),
    );
  }
  final int value;
  final String name;
  final List<DistrictModel> districts;

  @override
  List<Object?> get props => [value, name, districts];
}

final class DistrictModel extends Equatable {
  const DistrictModel(this.value, this.districtName);
  final int value;
  final String districtName;

  @override
  List<Object?> get props => [value, districtName];
}
