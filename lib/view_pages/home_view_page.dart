import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/home_page_controller.dart';

class HomeViewPage extends StatelessWidget {
  final HomePageController controller;

  const HomeViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return controller.isOnScreensaver == true ?
    Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvoked: (_) {},
        child: InkWell(
          onTap: () => controller.interactWithPage(),
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: IgnorePointer(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: MediaQuery.of(context).orientation == Orientation.landscape ? 1/1 : 1/2,
                      viewportFraction: 1,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      enlargeCenterPage: true,
                    ),
                    items: [
                      MediaQuery.of(context).orientation == Orientation.landscape ?
                      Image.asset(
                        'assets/images/welcome_ls.png',
                        fit: BoxFit.cover,
                      ) :
                      Image.asset(
                        'assets/images/welcome_pt.png',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      MediaQuery.of(context).orientation == Orientation.landscape ?
                      Image.asset(
                        'assets/images/ss_1_ls.png',
                        fit: BoxFit.cover,
                      ) :
                      Image.asset(
                        'assets/images/ss_1_pt.png',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      MediaQuery.of(context).orientation == Orientation.landscape ?
                      Image.asset(
                        'assets/images/ss_2_ls.png',
                        fit: BoxFit.cover,
                      ) :
                      Image.asset(
                        'assets/images/ss_2_pt.png',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ) :
    Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvoked: (_) {},
        child: OrientationBuilder(
          builder: (build, orientation) => GestureDetector(
            onTap: () => controller.interactWithPage(),
            onDoubleTap: () => controller.interactWithPage(),
            onLongPress: () => controller.interactWithPage(),
            onVerticalDragStart: (_) => controller.interactWithPage(),
            onVerticalDragUpdate: (_) => controller.interactWithPage(),
            onVerticalDragEnd: (_) => controller.interactWithPage(),
            onHorizontalDragStart: (_) => controller.interactWithPage(),
            onHorizontalDragUpdate: (_) => controller.interactWithPage(),
            onHorizontalDragEnd: (_) => controller.interactWithPage(),
            child: Column(
              children: [
                AppBar(
                  title: const Text(
                    'JNY Self Service Library',
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => controller.openSettings(),
                      icon: const Icon(
                        Icons.settings,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    controller: controller.scrollController,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                      childAspectRatio: orientation == Orientation.portrait ? 1 : 1/0.80,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    itemCount: controller.homeMenu.length,
                    itemBuilder: (menuContext, menuIndex) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: InkWell(
                          onTap: () => controller.homeMenu[menuIndex].onPressed != null ?
                          controller.homeMenu[menuIndex].onPressed!() : {},
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                controller.homeMenu[menuIndex].menuIcon != null ?
                                Image.asset(
                                  controller.homeMenu[menuIndex].menuIcon!,
                                  width: MediaQuery.of(context).size.width / 6,
                                  fit: BoxFit.contain,
                                ) :
                                const Material(),
                                Text(
                                  controller.homeMenu[menuIndex].menuTitle ?? 'Unknown Title',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}