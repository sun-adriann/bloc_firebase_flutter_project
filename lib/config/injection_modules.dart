import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_modules.config.dart';

/// A [GetIt] instance for locating respositories, blocs, services, etc.
///
/// GetIt docs: https://pub.dev/packages/get_it
///
/// Injectable docs: https://pub.dev/packages/injectable
final sl = GetIt.instance;

/// Configure injectable and getIt for the App.
@InjectableInit()
Future initializeDependencyInjection({String? env}) async {
  await $initGetIt(sl, environment: env);
}

@module
abstract class InjectionModules {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}
