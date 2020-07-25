import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping/provider/addres_Detils.dart';
import 'package:shoping/provider/badge_cololr.dart';
import 'package:shoping/provider/cart_item.dart';
import 'package:shoping/provider/modelHud.dart';
import 'package:shoping/servis/conectivti.dart';
import 'package:shoping/splash_screen.dart';
import 'package:shoping/theme/themeData.dart';

import 'Screens/admin/add_product.dart';
import 'Screens/admin/adminHome.dart';
import 'Screens/admin/editAndDelet.dart';
import 'Screens/admin/editProducts.dart';
import 'Screens/admin/productsInApp.dart';
import 'Screens/login_screen.dart';
import 'Screens/signup_screen.dart';
import 'enums/enum.dart';

//void main() => runApp(DevicePreview(builder: (context) => MyApp()));
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<ConnectivityStatus>(
          create: (context) =>
              ConnectivityService().connectionStatusController.stream,
        ),
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
//        ChangeNotifierProvider<AdminMode>(create: (context) => AdminMode()),
        //  ChangeNotifierProvider<LoginStat>(create: (context) => LoginStat()),
        ChangeNotifierProvider<BadgeCololr>(create: (context) => BadgeCololr()),
        ChangeNotifierProvider<CartItem>(create: (context) => CartItem()),
        ChangeNotifierProvider<SavedAdd>(create: (context) => SavedAdd()),
      ],
      child: MaterialApp(
//        builder: DevicePreview.appBuilder,
        theme: ThemeStyle,
        debugShowCheckedModeBanner: false,
        title: "Your Market",
        initialRoute: SplashScrren.id,
        routes: {
          SplashScrren.id: (c) => SplashScrren(),
          EditProductHome.id: (c) => EditProductHome(),
          AddProduct.id: (c) => AddProduct(),
          AdminHomeScreen.id: (context) => AdminHomeScreen(),
          EditAdmin.id: (context) => EditAdmin(),
          EditProduct.id: (context) => EditProduct(),
          LoginScrren.id: (c) => LoginScrren(),
          SignupScreen.id: (context) => SignupScreen(),
        },
      ),
    );
  }
}
