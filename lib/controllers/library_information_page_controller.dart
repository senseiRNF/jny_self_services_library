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
          InkWell(
            onTap: () => showFullImage('assets/images/library_info_$i.png'),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/library_info_$i.png",
                  ),
                  fit: BoxFit.cover,
                ),
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

  showFullImage(String assetPath) => showDialog(
    context: context,
    builder: (dialogContext) {
      String selectedAsset;

      switch(assetPath) {
        case "assets/images/library_info_1.jpeg":
          selectedAsset = "INFO_1";
          break;
        case "assets/images/library_info_2.png":
          selectedAsset = "INFO_2";
          break;
        case "assets/images/library_info_3.png":
          selectedAsset = "INFO_3";
          break;
        case "assets/images/library_info_4.png":
          selectedAsset = "INFO_4";
          break;
        case "assets/images/library_info_5.png":
          selectedAsset = "INFO_5";
          break;
        case "assets/images/library_info_6.png":
          selectedAsset = "INFO_6";
          break;
        case "assets/images/library_info_7.png":
          selectedAsset = "INFO_7";
          break;
        case "assets/images/library_info_8.png":
          selectedAsset = "INFO_8";
          break;
        default:
          selectedAsset = "INFORMATION";
          break;
      }

      DisplayMonitorServices.sendStateToMonitor(
        selectedAsset,
        {
          "library_member": {},
          "book_list": {},
        },
      );

      return Dialog(
        backgroundColor: Colors.transparent,
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
        ),
      );
    },
  ).then((_) => loadLibraryInformation());

  @override
  Widget build(BuildContext context) {
    return LibraryInformationViewPage(controller: this);
  }
}