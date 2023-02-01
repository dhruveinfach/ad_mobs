import 'package:ad_demo/view/copy_code.dart';
import 'package:ad_demo/view/home_view.dart';
import 'package:ad_demo/view/home_view_copy.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //________________________________Mobile Ads initialize
  await MobileAds.instance.initialize();
  loadAppOpenAd();
  runApp(const MyApp());
  // runApp(const MyApp());
}

AppOpenAd? myAppOpenAd;

loadAppOpenAd() {
  AppOpenAd.load(
      adUnitId:
          'ca-app-pub-7251435050939922/7495609385', //Your ad Id from admob
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            myAppOpenAd = ad;
            myAppOpenAd!.show();
          },
          onAdFailedToLoad: (error) {}),
      orientation: AppOpenAd.orientationPortrait);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CopyCode(),
    );
  }
}
