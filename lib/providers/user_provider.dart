import 'package:paypie_project/services/user_service.dart';
import 'package:provider/provider.dart';

final userServiceProvider = ChangeNotifierProvider<UserService>(
  create: (context) => UserService(),
);
