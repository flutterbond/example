import 'package:get_it/get_it.dart';

import 'config/app.dart';
import 'features/app/bloc/app_bloc.dart';

final sl = GetIt.instance;
App appBloc = App();

Future<void> init() async {
  for (var provider in providers) {
    await provider.register();
  }
}
