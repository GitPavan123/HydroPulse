import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reservoir_startuptn/Screens/Login_screen/technician_consumer_page.dart';

bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

  int _pageindex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    bool dark = isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? Colors.grey.shade900 : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _pageindex = index;
                    });
                  },
                  itemCount: demo_data.length,
                  controller: _pageController,
                  itemBuilder: (context, index) => OnBoardingContent(
                      image: demo_data[index].image,
                      title: demo_data[index].title,
                      description: demo_data[index].description),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                      demo_data.length,
                      (index) => Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: DotIndicator(isActive: index == _pageindex),
                          )),
                  Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        _pageController.nextPage(
                          curve: Curves.ease,
                          duration: Duration(milliseconds: 300),
                        );
                        if (_pageindex == demo_data.length - 1) {
                          // Navigate to the LoginScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DecisionTree(),
                            ),
                          );
                        } else {
                          _pageController.nextPage(
                            curve: Curves.ease,
                            duration: Duration(milliseconds: 300),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade900,
                        shape: CircleBorder(),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Arrow - right.svg",
                        color: Colors.white,
                        height: 22,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}

class Onboard {
  final String image, title, description;

  Onboard(
      {required this.image, required this.title, required this.description});
}

final List<Onboard> demo_data = [
  Onboard(
      image: "assets/on_boarding_screen/efficient_academic_management.png",
      title: "Efficient Academic Management",
      description:
          "Streamline tasks, grades and resources for \n optimized academic performance"),
  Onboard(
      image: "assets/on_boarding_screen/track_engage_assess.png",
      title: "Track, Engage and  Assess",
      description:
          "Simplify your daily college chores, from assignments to errands, with our user-friendly app"),
  Onboard(
    image: "assets/on_boarding_screen/intellectual_apptitude_metric.png",
    title: "Intellectual Aptitude Metric",
    description:
        "Assess overall student conduct and engagement for \ncomprehensive credit evaluation",
  )
];

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent(
      {super.key,
      required this.image,
      required this.title,
      required this.description});

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        if (image == demo_data[2].image)
          Image.asset(
            image,
            width: 320, // Adjust the width as per your requirement
            height: 500, // Adjust the height as per your requirement
          )
        else if (image == demo_data[1].image)
          Padding(
            padding: const EdgeInsets.only(
                top: 0), // Adjust the top padding for the second image
            child: Image.asset(
              image,
              width: 320, // Decrease the width for the second image
              height: 500, // Decrease the height for the second image
            ),
          )
        else
          Container(
            child: Image.asset(
              image,
              width: 300, // Default width for other screens
              height: 500, // Default height for other screens
            ),
          ),
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
