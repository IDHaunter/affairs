import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/custom_navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/service_locator.dart';
import '../../../core/auth/auth_service.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthView();
}

class _AuthView extends State<AuthView> {
  final AuthEnum? _authEnum = getIt<AuthService>().currentAuth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(showCalendar: false, showFilter: false, showDatePicker: false, title: context.l()!.authentication, filterDefault: context.l()!.noFilter, dateDefault: context.l()!.noDate),
          Padding(
            padding:
            EdgeInsets.symmetric(vertical: context.screenHeight() > context.screenWidth() ? 10 : 0, horizontal: 10),
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Icon(Icons.perm_identity),
              FilledButton(onPressed: () {}, child: const Text('Done!')),
            ]),
          )

        ],
      ),
    );
  }
}
