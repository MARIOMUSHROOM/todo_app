import 'package:flutter/material.dart';
import 'package:todo_app_2/core/constants/theme.dart';
import 'package:todo_app_2/presentation/doing/pages/doing_page.dart';
import 'package:todo_app_2/presentation/done/pages/done_page.dart';
import 'package:todo_app_2/presentation/todo/pages/todo_page.dart';
import 'package:todo_app_2/presentation/widgets/image_circle_widget.dart';
import 'package:todo_app_2/presentation/widgets/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int lenght = 3;
  int currentIndex = 0;
  List<Widget> pages = [
    TodoPage(),
    DoingPage(),
    DonePage(),
  ];

  tab(int value) {
    currentIndex = value;
    tabController!.animateTo(value);
    setState(() {});
  }

  @override
  void initState() {
    tabController = TabController(length: lenght, vsync: this, initialIndex: 0);
    super.initState();
    tabController!.addListener(() {
      tab(tabController!.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageCircleWidget(
                  imagePath: "",
                  height: 40,
                  width: 40,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: Sizer(context).h,
              width: Sizer(context).w,
              color: Colors.transparent,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: TabBarView(
                controller: tabController,
                children: pages.map<Widget>((e) => e).toList(),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 150,
              color: Colors.transparent,
              child: Stack(
                children: [
                  IgnorePointer(
                    ignoring: true,
                    child: Container(
                      height: 120,
                      width: Sizer(context).w,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi! User",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "This is just a simple UI.",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Open to create your style :D",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 320,
                      height: 55,
                      margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: TabBar(
                        // tabAlignment: TabAlignment.fill,
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        controller: tabController,
                        labelPadding: const EdgeInsets.all(4),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Colors.transparent,
                        physics: const NeverScrollableScrollPhysics(),
                        onTap: (value) {
                          tab(value);
                        },
                        tabs: [
                          tabController!.index == 0
                              ? boxSelected("To do")
                              : boxUnselected("To do"),
                          tabController!.index == 1
                              ? boxSelected("Doing")
                              : boxUnselected("Doing"),
                          tabController!.index == 2
                              ? boxSelected("Done")
                              : boxUnselected("Done"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget boxUnselected(String text) {
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints.expand(width: 100),
      height: 10,
      padding: const EdgeInsets.all(5),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget boxSelected(String text) {
    return Stack(
      key: Key(text),
      children: [
        Container(
          alignment: Alignment.center,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: primaryColor,
            gradient: gradientStyle,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
