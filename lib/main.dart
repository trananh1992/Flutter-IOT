import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:charge/config/amap.dart';
import 'package:charge/tools/permission.dart';
import 'package:charge/tools/spUtil.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import './config/index.dart';
import './provide/theme_provide.dart';
import './provide/currnet_index_provide.dart';
import './pages/logins/login_page.dart';

// ignore: missing_return
Future<void> main() {
  realRunApp();
}

void realRunApp() async {
  //如果需要在runapp之前初始化其它模块
  WidgetsFlutterBinding.ensureInitialized();
  // 禁用多余的log
  await enableFluttifyLog(false);

  //初始化本地储存同步方法
  await SpUtil.getInstance();
  var currentIndexProvide = CurrentIndexProvide();
  var themeProvide = ThemeProvide();
  var providers = Providers();
  providers
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<ThemeProvide>.value(themeProvide));
  runApp(ProviderNode(child: MyApp(), providers: providers));
  //高德地图初始化-ios
  await AmapService.init(
      iosKey: KMap.iosKey,
      androidKey: KMap.androidKey,
      webApiKey: KMap.webApiKey);
  KPermission.check();
}

///Users/lihaitao
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProvideMulti(
      requestedValues: [ThemeProvide],
      builder: (context, child, model) {
        String lastThemeValue = SpUtil.preferences.getString("lastThemeValue");
        String currentThemeValue = model.get<ThemeProvide>().currentThemeValue;
        if (currentThemeValue != lastThemeValue) {
          model.get<ThemeProvide>().changeTheme(lastThemeValue);
        }
        Map currentTheme = model.get<ThemeProvide>().currentTheme;
        return Container(
            child: MaterialApp(
                title: KString.mainTitle, //通用主标题
                debugShowCheckedModeBanner: true,
                //主题
                theme: ThemeData(
                  primaryColor: currentTheme['color'],
                ),
                home: LoginPage()));
      },
    );
  }
}
