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
      ListView(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 6),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              Text(
                                controller.widget.libraryMemberData.nis ?? controller.widget.libraryMemberData.nik ?? '',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                controller.widget.libraryMemberData.className ?? controller.widget.libraryMemberData.email ?? '',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      'Library Book Borrowing Records',
                      style: TextStyle(
                        fontSize: 18.0,
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
                    controller.listBorrowedDetail.isNotEmpty ?
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.listBorrowedDetail.length,
                      itemBuilder: (BuildContext listContext, int index) {
                        return Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: InkWell(
                            onTap: () => controller.listBorrowedDetail[index].books != null ?
                            controller.openListOfBorrowedBook(controller.listBorrowedDetail[index].books!) : {},
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Borrow Date: ${controller.listBorrowedDetail[index].fromDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.listBorrowedDetail[index].fromDate!)) : "Unknown"}',
                                        ),
                                        Text(
                                          'Return Date: ${controller.listBorrowedDetail[index].untilDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.listBorrowedDetail[index].untilDate!)) : "Unknown"}',
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Status: ${controller.listBorrowedDetail[index].status ?? "Unknown"}',
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Number Of Books Borrowed: ${controller.listBorrowedDetail[index].books != null ? controller.listBorrowedDetail[index].books!.length : "Unknown"}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  const Icon(
                                    Icons.navigate_next,
                                    size: 35.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ) :
                    const Text(
                      'Currently, no books are being borrowed',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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