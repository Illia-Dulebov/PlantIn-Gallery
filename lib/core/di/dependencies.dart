import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gallery/core/network/dio_client.dart';
import 'package:gallery/features/authentication/repositories/dio_auth_repository.dart';
import 'package:gallery/features/gallery/repositories/dio_pictures_repository.dart';
import 'package:gallery/features/authentication/state/authentication_notifier.dart';
import 'package:gallery/features/gallery/state/pictures_notifier.dart';

class AppDependencies {
  final SharedPreferences prefs;
  final Dio dio;
  final DioAuthRepository authRepository;
  final DioPicturesRepository picturesRepository;
  final AuthenticationNotifier authNotifier;
  final PicturesNotifier picturesNotifier;

  AppDependencies({
    required this.prefs,
    required this.dio,
    required this.authRepository,
    required this.picturesRepository,
    required this.authNotifier,
    required this.picturesNotifier,
  });
}

class AppDiService {
  static Future<AppDependencies> init() async {
    final prefs = await SharedPreferences.getInstance();
    final dio = DioClient.create();

    final authRepository = DioAuthRepository(dio, prefs);
    final picturesRepository = DioPicturesRepository(dio);

    final authNotifier = AuthenticationNotifier(authRepository);
    final picturesNotifier = PicturesNotifier(picturesRepository);

    authNotifier.checkAuthentication();

    return AppDependencies(
      prefs: prefs,
      dio: dio,
      authRepository: authRepository,
      picturesRepository: picturesRepository,
      authNotifier: authNotifier,
      picturesNotifier: picturesNotifier,
    );
  }
}
