import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/view_pages/library_information_view_page.dart';

class LibraryInformationPage extends StatefulWidget {
  const LibraryInformationPage({super.key});

  @override
  State<LibraryInformationPage> createState() => LibraryInformationPageController();
}

class LibraryInformationPageController extends State<LibraryInformationPage> {
  late List<Widget> libraryFacilityList = [];

  int imageIndex = 0;

  @override
  void initState() {
    super.initState();

    for(int i = 2; i < 9; i++) {
      setState(() {
        libraryFacilityList.add(
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/library_info_$i.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      });
    }

    loadLibraryInformation();
  }

  loadLibraryInformation() async {
    DisplayMonitorServices.sendStateToMonitor(
      "INFORMATION",
      {
        "library_member": {},
        "book_list": {},
      },
    );
  }

  imageLibraryFacilitiesOnChange(int index) => setState(() {
    imageIndex = index;
  });

  onBackPressed() => CloseBack(context: context).go();

  @override
  Widget build(BuildContext context) {
    return LibraryInformationViewPage(controller: this);
  }
}