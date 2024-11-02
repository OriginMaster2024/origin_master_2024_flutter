import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/domain_object/etude_result.dart';
import 'package:origin_master_2024_flutter/domain_object/personality_type.dart';
import 'package:origin_master_2024_flutter/providers/dio_provider.dart';

class PersonalDiagnosisResponse {
  PersonalDiagnosisResponse._({
    required this.type,
    required this.description,
  });

  final PersonalityType type;
  final String description;

  factory PersonalDiagnosisResponse.fromJson(Map<String, dynamic> json) {
    return PersonalDiagnosisResponse._(
      type: PersonalityType.values.byName(json['type']),
      description: json['description'],
    );
  }

  @override
  String toString() {
    return 'PersonalDiagnosisResponse(type: $type, description: $description)';
  }
}

final personalDiagnosisProvider = AsyncNotifierProvider<
    PersonalDiagnosisNotifier, PersonalDiagnosisResponse?>(
  PersonalDiagnosisNotifier.new,
);

class PersonalDiagnosisNotifier
    extends AsyncNotifier<PersonalDiagnosisResponse?> {
  @override
  PersonalDiagnosisResponse? build() {
    return null;
  }

  Dio get _dio => ref.read(dioProvider);

  Future<void> call({
    required String situation,
    required EtudeResult result,
    required List<double> centerPercentages,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        "/functions/v1/personality_diagnosis",
        data: {
          "situation": situation,
          "result": result.name,
          "center_percentages":
              "[${centerPercentages.map((e) => '${(e * 100).round()}%').join(',')}]",
        },
      );

      if (response.data != null) {
        return PersonalDiagnosisResponse.fromJson(response.data!);
      }
      return null;
    });

    _dio.close();
  }
}
