import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jny_self_services_library/controllers/account_page_controller.dart';

class AccountViewPage extends StatelessWidget {
  final AccountPageController controller;

  const AccountViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Info',
        ),
      ),
      body: controller.showLoading == false ?
      DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    controller.widget.libraryMemberData.nis != null ? 'Student Data' : 'Employee Data',
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black54,
                                    thickness: 1.5,
                                    height: 0.0,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width / 12,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black54,
                                            ),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: controller.widget.libraryMemberData.photoUrl ?? '',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              controller.widget.libraryMemberData.name ?? '',
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            controller.widget.libraryMemberData.nis != null ?
                                            Text(
                                              controller.widget.libraryMemberData.nis!,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ) :
                                            const Material(),
                                            controller.widget.libraryMemberData.className != null ?
                                            Text(
                                              controller.widget.libraryMemberData.className!,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ) :
                                            const Material(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 50.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 6,
                              child: Image.asset(
                                'assets/images/jny_logo_hd.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TabBar(
                          labelColor: Theme.of(context).colorScheme.primary,
                          indicatorColor: Theme.of(context).colorScheme.primary,
                          unselectedLabelColor: Colors.grey,
                          tabs: const [
                            Tab(
                              text: "Currently Borrowed",
                            ),
                            Tab(
                              text: "Histories",
                            ),
                          ],
                          onTap: (index) {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              controller.borrowedList.isNotEmpty ?
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.borrowedList.length,
                                itemBuilder: (BuildContext listContext, int index) {
                                  return Card(
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Borrow Date: ${controller.borrowedList[index].fromDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.borrowedList[index].fromDate!)) : "Unknown"}',
                                          ),
                                          Text(
                                            'Return Date: ${controller.borrowedList[index].untilDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.borrowedList[index].untilDate!)) : "Unknown"}',
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          controller.borrowedList[index].books != null ?
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: controller.borrowedList[index].books!.length,
                                            separatorBuilder: (separatorContext, separatorIndex) {
                                              return const SizedBox(
                                                height: 5.0,
                                              );
                                            },
                                            itemBuilder: (subListContext, subIndex) {
                                              return Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 80.0,
                                                    height: 80.0,
                                                    child: CachedNetworkImage(
                                                      imageUrl: controller.borrowedList[index].books![subIndex].url ?? "",
                                                      fit: BoxFit.contain,
                                                      errorWidget: (errContext, _, errObj) {
                                                        return Icon(
                                                          Icons.book,
                                                          color: Theme.of(context).colorScheme.primary,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: [
                                                        Text(
                                                          controller.borrowedList[index].books![subIndex].bibliography!.title ?? 'Unknown',
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text(
                                                          "ISBN/ISSN: ${controller.borrowedList[index].books![subIndex].bibliography!.isbnOrIssn ?? 'Unknown'}",
                                                        ),
                                                        const SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text(
                                                              'Authors: ',
                                                            ),
                                                            Text(
                                                              controller.borrowedList[index].books![subIndex].bibliography != null ?
                                                              controller.borrowedList[index].books![subIndex].bibliography!.authorNames ?? 'Unknown' :
                                                              'Unknown',
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                'Publisher: ${controller.borrowedList[index].books![subIndex].bibliography != null
                                                                    && controller.borrowedList[index].books![subIndex].bibliography!.publisher != null ?
                                                                controller.borrowedList[index].books![subIndex].bibliography!.publisher!.name ?? 'Unknown' :
                                                                "Unknown"} ',
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                'Publishing Year: ${controller.borrowedList[index].books![subIndex].bibliography != null ?
                                                                controller.borrowedList[index].books![subIndex].bibliography!.publishingYear ?? 'Unknown' :
                                                                "Unknown"} ',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ) :
                                          const Material(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                controller.borrowedList[index].status ?? "Unknown Status",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ) :
                              const Center(
                                child: Text(
                                  'Currently, no books are being borrowed',
                                ),
                              ),
                              controller.historyList.isNotEmpty ?
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.historyList.length,
                                itemBuilder: (BuildContext listContext, int index) {
                                  return Card(
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Borrow Date: ${controller.historyList[index].fromDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.historyList[index].fromDate!)) : "Unknown"}',
                                          ),
                                          Text(
                                            'Return Date: ${controller.historyList[index].untilDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.historyList[index].untilDate!)) : "Unknown"}',
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          controller.historyList[index].books != null ?
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: controller.historyList[index].books!.length,
                                            separatorBuilder: (separatorContext, separatorIndex) {
                                              return const SizedBox(
                                                height: 5.0,
                                              );
                                            },
                                            itemBuilder: (subListContext, subIndex) {
                                              return Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 80.0,
                                                    height: 80.0,
                                                    child: CachedNetworkImage(
                                                      imageUrl: controller.historyList[index].books![subIndex].url ?? "",
                                                      fit: BoxFit.contain,
                                                      errorWidget: (errContext, _, errObj) {
                                                        return Icon(
                                                          Icons.book,
                                                          color: Theme.of(context).colorScheme.primary,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: [
                                                        Text(
                                                          controller.historyList[index].books![subIndex].bibliography!.title ?? 'Unknown',
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text(
                                                          "ISBN/ISSN: ${controller.historyList[index].books![subIndex].bibliography!.isbnOrIssn ?? 'Unknown'}",
                                                        ),
                                                        const SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text(
                                                              'Authors: ',
                                                            ),
                                                            Text(
                                                              controller.historyList[index].books![subIndex].bibliography != null ?
                                                              controller.historyList[index].books![subIndex].bibliography!.authorNames ?? 'Unknown' :
                                                              'Unknown',
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                'Publisher: ${controller.historyList[index].books![subIndex].bibliography != null
                                                                    && controller.historyList[index].books![subIndex].bibliography!.publisher != null ?
                                                                controller.historyList[index].books![subIndex].bibliography!.publisher!.name ?? 'Unknown' :
                                                                "Unknown"} ',
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                'Publishing Year: ${controller.historyList[index].books![subIndex].bibliography != null ?
                                                                controller.historyList[index].books![subIndex].bibliography!.publishingYear ?? 'Unknown' :
                                                                "Unknown"} ',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ) :
                                          const Material(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                controller.historyList[index].status ?? "Unknown Status",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.lightGreen,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ) :
                              const Center(
                                child: Text(
                                  'There is no history recorded',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ) :
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Please wait...',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Image.asset(
              'assets/images/gifs/book_loading.gif',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}