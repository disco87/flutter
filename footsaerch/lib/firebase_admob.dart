// import 'dart:io' show Platform;
// import 'package:firebase_admob/firebase_admob.dart';

// class AdMobManager {
//   BannerAd _bannerAd;
//   InterstitialAd _interstitialAd;

//   String appID = Platform.isIOS
//       // iOS Test App ID
//       ? 'ca-app-pub-3940256099942544~3347511713'
//       // Android Test App ID
//       : 'ca-app-pub-3940256099942544~3347511713';

//   String bannerID = BannerAd.testAdUnitId;
//   String interstitialID = InterstitialAd.testAdUnitId;

//   static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//     keywords: <String>['flutter', 'firebase', 'admob'],
//     testDevices: <String>[],
//   );

//   init() async {
//     FirebaseAdMob.instance.initialize(appId: appID);
//     _bannerAd = createBannerAd();
//     _interstitialAd = createInterstitialAd();
//     _bannerAd
//       ..load()
//       ..show();
//   }

//   BannerAd createBannerAd() {
//     return BannerAd(
//       adUnitId: bannerID,
//       size: AdSize.banner,
//       targetingInfo: targetingInfo,
//       listener: (MobileAdEvent event) {
//         print("BannerAd event is $event");
//       },
//     );
//   }

//   InterstitialAd createInterstitialAd() {
//     return InterstitialAd(
//       adUnitId: interstitialID,
//       targetingInfo: targetingInfo,
//       listener: (MobileAdEvent event) {
//         print("BannerAd event is $event");
//       },
//     );
//   }

//   showInterstitialAd() {
//     _interstitialAd
//       ..load()
//       ..show();
//   }
// }
