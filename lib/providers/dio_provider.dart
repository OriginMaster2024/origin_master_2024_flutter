import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider.autoDispose<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: "https://xoijttchvmcbwkocdera.supabase.co",
      connectTimeout: const Duration(milliseconds: 15000),
      sendTimeout: const Duration(milliseconds: 15000),
      receiveTimeout: const Duration(milliseconds: 30000),
      responseType: ResponseType.json,
    ),
  );
});
