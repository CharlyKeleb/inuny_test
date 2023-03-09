import 'package:inuny_test/view_models/auth/login_view_model.dart';
import 'package:inuny_test/view_models/auth/sign_up_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => SignUpViewModel()),
];
