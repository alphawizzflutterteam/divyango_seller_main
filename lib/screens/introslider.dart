import 'package:divyango_user/screens/auth/mobile_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/AppBtn.dart';
import '../services/colors.dart';

class IntroSlider extends StatefulWidget {
  const IntroSlider({super.key});

  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<IntroSlider>
    with TickerProviderStateMixin {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  List<Slide> slideList = [];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        setState(
          () {
            slideList = [
              Slide(
                imgUrl: 'assets/images/intro1.jpg',
                title: 'Welcome Real Estate Professionals',
                description:
                    'Grow your real estate business with our all-in-one platform. Sign up today and discover seamless experience of lead generation.',
              ),
              Slide(
                imgUrl: 'assets/images/intro2.png',
                title: 'Real-Time Insights & Free CRM',
                description:
                    'Stay on top of your marketing with live insights and detailed reports. Plus, manage all your leads effortlessly with our free, built-in CRM.',
              ),
              Slide(
                  imgUrl: 'assets/images/intro3.png',
                  title: 'Dedicated Support & Easy Payments',
                  description:
                      'Enjoy dedicated support from your personal relationship manager. Easily handle your payments within the app with our secure and simple options.'),
            ];
          },
        );
      },
    );

    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    buttonSqueezeanimation = Tween(
      begin: deviceWidth! * 0.9,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    buttonController!.dispose();

    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  _onPageChanged(int index) {
    if (mounted) {
      setState(
        () {
          _currentPage = index;
        },
      );
    }
  }

  List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(
        handler(i, list[i]),
      );
    }

    return result;
  }

  Widget _slider() {
    return Expanded(
      child: PageView.builder(
        itemCount: slideList.length,
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * .4,
                  child: Image.asset(
                    slideList[index].imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  color: colors.whiteTemp,
                  margin: const EdgeInsetsDirectional.only(
                    top: 20,
                  ),
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    slideList[index].title ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                    // style: Theme.of(context).textTheme.headline5!.copyWith(
                    //     color: Theme.of(context).colorScheme.fontColor,
                    //     fontWeight: FontWeight.bold)
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: colors.whiteTemp,
                  padding:
                      const EdgeInsetsDirectional.only(start: 18.0, end: 15.0),
                  child: Text(
                    slideList[index].description ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _btn() {
    return Container(
      color: colors.whiteTemp,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: getList()),
            Center(
                child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 40.0),
              child: AppBtn(
                  title: _currentPage == 0 || _currentPage == 1
                      ? 'Next'
                      : 'Get Start',
                  btnAnim: buttonSqueezeanimation,
                  btnCntrl: buttonController,
                  onBtnSelected: () {
                    if (_currentPage == 2) {
                      // setPrefrenceBool(ISFIRSTTIME, true);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    } else {
                      _currentPage = _currentPage + 1;
                      _pageController.animateToPage(_currentPage,
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 300));
                    }
                  }),
            )),
          ],
        ),
      ),
    );
  }

  List<Widget> getList() {
    List<Widget> childs = [];

    for (int i = 0; i < slideList.length; i++) {
      childs.add(Container(
          width: 10.0,
          height: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == i ? colors.blackTemp : colors.darkgrey)));
    }
    return childs;
  }

  skipBtn() {
    return _currentPage == 0 || _currentPage == 1
        ? Padding(
            padding: const EdgeInsetsDirectional.only(top: 20.0, end: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    // setPrefrenceBool(ISFIRSTTIME, true);
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignInUpAcc()),
                    // );
                  },
                  child: Row(children: [
                    Text('Skip',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.fontColor,
                            )),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.fontColor,
                      size: 12.0,
                    ),
                  ]),
                ),
              ],
            ))
        : Container(
            margin: const EdgeInsetsDirectional.only(top: 50.0),
            height: 15,
          );
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    // SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      backgroundColor: colors.whiteTemp,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // skipBtn(),
          _slider(),
          _btn(),
          Container(
            height: 90,
            color: colors.whiteTemp,
          ),
        ],
      ),
    );
  }
}

class Slide {
  final String imgUrl;
  final String? title;
  final String? description;

  Slide({
    required this.imgUrl,
    required this.title,
    required this.description,
  });
}
