

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
const String testDevice = 'YOUR_DEVICE_ID';
const int maxFailedLoadAttempts = 3;

class MyAppScreen extends StatefulWidget {
  @override
  _MyAppScreenState createState() => _MyAppScreenState();
}

class _MyAppScreenState extends State<MyAppScreen> {
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  RewardedInterstitialAd? _rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    _createRewardedAd();
    _createRewardedInterstitialAd();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-7251435050939922~6667703323'
          : 'ca-app-pub-7251435050939922/5389199100',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-7251435050939922~6667703323'
          : 'ca-app-pub-7251435050939922/5389199100',
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

  void _createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-7251435050939922~6667703323'
          : 'ca-app-pub-7251435050939922/5389199100',
        request: request,
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            print('$ad loaded.');
            _rewardedInterstitialAd = ad;
            _numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedInterstitialAd failed to load: $error');
            _rewardedInterstitialAd = null;
            _numRewardedInterstitialLoadAttempts += 1;
            if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedInterstitialAd();
            }
          },
        ));
  }

  void _showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
    );

    _rewardedInterstitialAd!.setImmersiveMode(true);
    _rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedInterstitialAd = null;
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _rewardedInterstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('AdMob Plugin example app'),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (String result) {
                  switch (result) {
                    case 'InterstitialAd':
                      _showInterstitialAd();
                      break;
                    case 'RewardedAd':
                      _showRewardedAd();
                      break;
                    case 'RewardedInterstitialAd':
                      _showRewardedInterstitialAd();
                      break;
                    case 'Fluid':
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FluidExample()),
                      ); */
                      break;
                    case 'Inline adaptive':
                     /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InlineAdaptiveExample()),
                      ); */
                      break;
                    case 'Anchored adaptive':
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnchoredAdaptiveExample()),
                      ); */
                      break;
                    default:
                      throw AssertionError('unexpected button: $result');
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'InterstitialAd',
                    child: Text('InterstitialAd'),
                  ),
                  PopupMenuItem<String>(
                    value: 'RewardedAd',
                    child: Text('RewardedAd'),
                  ),
                  PopupMenuItem<String>(
                    value: 'RewardedInterstitialAd',
                    child: Text('RewardedInterstitialAd'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Fluid',
                    child: Text('Fluid'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Inline adaptive',
                    child: Text('Inline adaptive'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Anchored adaptive',
                    child: Text('Anchored adaptive'),
                  ),
                ],
              ),
            ],
          ),
          body: SafeArea(child: ReusableInlineExample()),
        );
      }),
    );
  }
}

class ReusableInlineExample extends StatefulWidget {
  @override
  _ReusableInlineExampleState createState() => _ReusableInlineExampleState();
}

class _ReusableInlineExampleState extends State<ReusableInlineExample> {
  BannerAd? _bannerAd;
  bool _bannerAdIsLoaded = false;

  AdManagerBannerAd? _adManagerBannerAd;
  bool _adManagerBannerAdIsLoaded = false;

  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.separated(
            itemCount: 20,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 40,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              final BannerAd? bannerAd = _bannerAd;
              if (index == 5 && _bannerAdIsLoaded && bannerAd != null) {
                return Container(
                    height: bannerAd.size.height.toDouble(),
                    width: bannerAd.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd));
              }

              final AdManagerBannerAd? adManagerBannerAd = _adManagerBannerAd;
              if (index == 10 &&
                  _adManagerBannerAdIsLoaded &&
                  adManagerBannerAd != null) {
                return Container(
                    height: adManagerBannerAd.sizes[0].height.toDouble(),
                    width: adManagerBannerAd.sizes[0].width.toDouble(),
                    child: AdWidget(ad: _adManagerBannerAd!));
              }

              final NativeAd? nativeAd = _nativeAd;
              if (index == 15 && _nativeAdIsLoaded && nativeAd != null) {
                return Container(
                    width: 250, height: 350, child: AdWidget(ad: nativeAd));
              }

              return Text(
                "dhurv",
                style: TextStyle(fontSize: 24),
              );
            },
          ),
        ),
      );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Create the ad objects and load ads.
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-7251435050939922~6667703323'
          : 'ca-app-pub-7251435050939922/5389199100',
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            print('$BannerAd loaded.');
            setState(() {
              _bannerAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('$BannerAd failedToLoad: $error');
            ad.dispose();
          },
          onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
        ),
        request: AdRequest())
      ..load();

    _nativeAd = NativeAd(
      adUnitId: Platform.isAndroid
         ? 'ca-app-pub-7251435050939922~6667703323'
          : 'ca-app-pub-7251435050939922/5389199100',
      request: AdRequest(),
      factoryId: 'adFactoryExample',
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
    )..load();

    _adManagerBannerAd = AdManagerBannerAd(
      adUnitId: '/6499/example/banner',
      request: AdManagerAdRequest(nonPersonalizedAds: true),
      sizes: <AdSize>[AdSize.largeBanner],
      listener: AdManagerBannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$AdManagerBannerAd loaded.');
          setState(() {
            _adManagerBannerAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$AdManagerBannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$AdManagerBannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$AdManagerBannerAd onAdClosed.'),
      ),
    )..load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose(); 
    _adManagerBannerAd?.dispose();
    _nativeAd?.dispose();
  }
}