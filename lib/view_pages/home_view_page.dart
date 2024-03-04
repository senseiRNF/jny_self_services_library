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
      body: InkWell(
        onTap: () => controller.interactWithPage(),
        child: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/welcome.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ) :
    Scaffold(
      body: OrientationBuilder(
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
                child: Column(
                  children: [
                    controller.carouselOptions != null ?
                    CarouselSlider(
                      items: controller.carouselWidget,
                      options: controller.carouselOptions!,
                    ) :
                    const Material(),
                    Expanded(
                      child: GridView.builder(
                        controller: controller.scrollController,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: orientation == Orientation.portrait ? 1 : 1/0.53,
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
            ],
          ),
        ),
      ),
    );
  }
}