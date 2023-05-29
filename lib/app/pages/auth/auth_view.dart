import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/custom_navigation_drawer.dart';
import 'package:affairs/core/auth/local_auth_service.dart';
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
          TopBar(
              showCalendar: false,
              showFilter: false,
              showDatePicker: false,
              showDrawer: false,
              title: context.l()!.authentication,
              filterDefault: context.l()!.noFilter,
              dateDefault: context.l()!.noDate),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: context.screenHeight() > context.screenWidth() ? 10 : 0, horizontal: 20),
              child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                InkWell(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: Image.asset('assets/images/goose_640.jpg').image,
                    //backgroundColor: Colors.pink,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, MainNavigatorRouteNames.groups);
                  },
                ),
                SizedBox(height: context.screenHeight() > context.screenWidth() ? 10 : 3,),
                Text(context.l()!.welcomeBack, style: medium),
                Text('Anatoliy', style: bold.copyWith(fontSize: titleSize)),
                SizedBox(height: context.screenHeight() > context.screenWidth() ? 30 : 5,),
                Card(
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.fingerprint),
                        const SizedBox(width: 10,),
                        Text(context.l()!.localizedReason, style: bold),
                      ],
                    )),
                    //leading: const Icon(Icons.fingerprint),
                    onTap: () async {
                      final isAuthenticate = await LocalAuthService(authReason: context.l()!.localizedReason).authenticate();

                      if (isAuthenticate) {
                        Navigator.pushReplacementNamed(context, MainNavigatorRouteNames.groups);
                      }

                    },
                  ),
                ),

                 // FilledButton(onPressed: () async {
                 //   final isAuthenticate = await LocalAuthService(authReason: context.l()!.localizedReason).authenticate();
                 //   if (isAuthenticate) {
                 //     Navigator.pushReplacementNamed(context, MainNavigatorRouteNames.groups);
                 //   }
                 //   }, child: Text(context.l()!.localizedReason)),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
