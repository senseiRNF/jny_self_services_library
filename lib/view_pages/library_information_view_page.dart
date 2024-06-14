import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/library_information_page_controller.dart';

class LibraryInformationViewPage extends StatelessWidget {
  final LibraryInformationPageController controller;

  const LibraryInformationViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Library Information",
      //   ),
      // ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? MediaQuery.of(context).size.height / 12
                : MediaQuery.of(context).size.height / 16,
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        "assets/images/library_info_3.png",
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 12,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).orientation == Orientation.landscape
                      ? MediaQuery.of(context).size.height / 12
                      : MediaQuery.of(context).size.height / 16,
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => controller.onBackPressed(),
                            customBorder: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.arrow_back,
                                size: 25.0,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      const Text(
                        "LIBRARY INFORMATION",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                Text(
                  "LIBRARY CONTRIBUTORS",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MediaQuery.of(context).orientation == Orientation.landscape ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.6,
                                height: MediaQuery.of(context).size.height / 2,
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width / 3,
                                          height: MediaQuery.of(context).size.height / 2.5,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff5d3267).withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width / 3,
                                          height: MediaQuery.of(context).size.height / 2.5,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff7c7ce1).withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width / 3,
                                              height: MediaQuery.of(context).size.height / 2.5,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30.0),
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/library_info_1.jpeg',
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "大均秀莲图书馆志",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 22.0,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                "    大均秀莲图书馆是雅华前知名人士, 汪大均先生、楊秀莲女士的子女:汪慕宁、颜玉丽伉俪、汪琼南、汪琼尼和汪琼红，为纪念和感恩双亲，传承母校新华的优良传统而捐赠的。",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              const Text(
                                "    汪大均先生是雅加达著名侨领之一，在侨界、文化界、教育界、工商界和金融界頗具知名度；毕生为促进印中友好合作和文化交流，促进印华族羣和谐和传播中华文化贡献良多。",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              const Text(
                                "    楊秀莲女士毕生刻己宽人，敦亲睦邻，亦为雅加达著名侨领之一。她倾力支持印华教育事业的发展，致力於争取和维护妇女的正当权益，广受社会各界的讚誉和爱戴。",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              const Text(
                                "    汪氏家族热爱国家，服务社羣，为众所推崇。为旌其德，扬其喜爱阅读的学习精神,爰将该图书馆命名为“大均秀莲图书馆”特铭文为志。",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                "雅加达南洋学校立",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              const Text(
                                "二零二四年七月十九日",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ) :
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 3.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.8,
                                height: MediaQuery.of(context).size.height / 4.5,
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width / 3,
                                          height: MediaQuery.of(context).size.height / 5.5,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff5d3267).withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width / 3,
                                          height: MediaQuery.of(context).size.height / 5.5,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff7c7ce1).withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width / 3,
                                              height: MediaQuery.of(context).size.height / 5.5,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20.0),
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/library_info_1.jpeg',
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 3.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "大均秀莲图书馆志",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 18.0,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                "    大均秀莲图书馆是雅华前知名人士, 汪大均先生、楊秀莲女士的子女:汪慕宁、颜玉丽伉俪、汪琼南、汪琼尼和汪琼红，为纪念和感恩双亲，传承母校新华的优良传统而捐赠的。",
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const Text(
                                "    汪大均先生是雅加达著名侨领之一，在侨界、文化界、教育界、工商界和金融界頗具知名度；毕生为促进印中友好合作和文化交流，促进印华族羣和谐和传播中华文化贡献良多。",
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const Text(
                                "    楊秀莲女士毕生刻己宽人，敦亲睦邻，亦为雅加达著名侨领之一。她倾力支持印华教育事业的发展，致力於争取和维护妇女的正当权益，广受社会各界的讚誉和爱戴。",
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const Text(
                                "    汪氏家族热爱国家，服务社羣，为众所推崇。为旌其德，扬其喜爱阅读的学习精神,爰将该图书馆命名为“大均秀莲图书馆”特铭文为志。",
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                "雅加达南洋学校立",
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const Text(
                                "二零二四年七月十九日",
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                MediaQuery.of(context).orientation == Orientation.landscape ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/library_info_9.png',
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "LIBRARY MEMBERSHIP",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                "Membership at the JNY library is available to students, teachers, and active staff who are part of the JNY community."
                                    "\nTo borrow a book, simply use the JNY-issued ID card.",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ) :
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/library_info_9.png',
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "LIBRARY MEMBERSHIP",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                "Membership at the JNY library is available to students, teachers, and active staff who are part of the JNY community."
                                    "\nTo borrow a book, simply use the JNY-issued ID card.",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                MediaQuery.of(context).orientation == Orientation.landscape ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "LIBRARY COLLECTION",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                "The JNY Library offers a diverse collection designed to meet the needs of readers from various backgrounds and interests. "
                                    "From academic textbooks to the latest fiction novels, we provide access to thousands of titles in various languages and genres."
                                    "\nOur collection is continuously updated to reflect the latest developments in the fields of science, technology, literature, and history.",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/library_info_10.png',
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ) :
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "LIBRARY COLLECTION",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                "The JNY Library offers a diverse collection designed to meet the needs of readers from various backgrounds and interests. "
                                    "From academic textbooks to the latest fiction novels, we provide access to thousands of titles in various languages and genres."
                                    "\nOur collection is continuously updated to reflect the latest developments in the fields of science, technology, literature, and history.",
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/library_info_10.png',
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Text(
                  "LIBRARY FACILITIES",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: MediaQuery.of(context).orientation == Orientation.landscape
                        ? 22.0 : 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CarouselSlider(
                  items: controller.libraryFacilityList,
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index, _) => controller.imageLibraryFacilitiesOnChange(index),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: SizedBox(
                    height: 20.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.libraryFacilityList.length,
                      itemBuilder: (indexContext, index) {
                        return Container(
                          width: 10.0,
                          height: 10.0,
                          margin: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == controller.imageIndex
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}