import 'platform_helper_stub.dart'
    if (dart.library.io) 'platform_helper_io.dart';

void initializePlatformOverrides() {
  setupHttpOverrides();
}

Future<void> initializeBackgroundTasks() async {
  await setupWorkmanager();
}
