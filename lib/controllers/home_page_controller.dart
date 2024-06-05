import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/account_page_controller.dart';
import 'package:jny_self_services_library/controllers/book_list_page_controller.dart';
import 'package:jny_self_services_library/controllers/borrow_page_controller.dart';
import 'package:jny_self_services_library/controllers/library_information_page_controller.dart';
import 'package:jny_self_services_library/controllers/lock_setting_page_controller.dart';
import 'package:jny_self_services_library/controllers/qr_scan_page_controller.dart';
import 'package:jny_self_services_library/controllers/renew_page_controller.dart';
import 'package:jny_self_services_library/controllers/return_page_controller.dart';
import 'package:jny_self_services_library/controllers/setting_page_controller.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/home_menu_json.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/main_services.dart';
import 'package:jny_self_services_library/services/networks/pocket_base_config.dart';
import 'package:jny_self_services_library/view_pages/home_view_page.dart';
import 'package:pocketbase/pocketbase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageController();
}

class HomePageController extends State<HomePage> {
  late List<HomeMenuJson> homeMenu;
  List<Widget> carouselWidget = [];

  bool isOnScreensaver = true;

  Timer? gestureTimer;

  ScrollController scrollController = ScrollController();

  PocketBase pbConfig = PocketBaseConfig.pb;

  @override
  void initState() {
    super.initState();

    setState(() {
      scrollController.addListener(() => interactWithPage());

      homeMenu = [
        HomeMenuJson(
          menuTitle: 'Borrow',
          menuIcon: 'assets/images/icons/borrow.png',
          onPressed: () {
            if(gestureTimer != null) {
              setState(() {
                gestureTimer!.cancel();
              });
            }

            MoveTo(
              context: context,
              target: const QRScanPage(),
              callback: (String? qrCode) async {
                if(qrCode != null) {
                  await MainServices(context: context).showLibraryMember(qrCode).then((result) {
                    if(result != null && result.libraryMemberData != null) {
                      MoveTo(
                        context: context,
                        target: BorrowPage(
                          libraryMemberData: result.libraryMemberData!,
                        ),
                        callback: (_) {
                          if(gestureTimer != null && gestureTimer!.isActive == false) {
                            setState(() {
                              gestureTimer = Timer.periodic(
                                const Duration(seconds: 1), (timer) =>
                                  checkTimeout(timer.tick),
                              );
                            });
                          }

                          DisplayMonitorServices.sendStateToMonitor(
                            "IDLE",
                            {
                              "library_member": {},
                              "book_list": {},
                            },
                          );
                        },
                      ).go();
                    } else {
                      if(gestureTimer != null && gestureTimer!.isActive == false) {
                        setState(() {
                          gestureTimer = Timer.periodic(
                            const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
                          );
                        });
                      }
                    }
                  });
                } else {
                  if(gestureTimer != null && gestureTimer!.isActive == false) {
                    setState(() {
                      gestureTimer = Timer.periodic(
                        const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
                      );
                    });
                  }

                  DisplayMonitorServices.sendStateToMonitor(
                    "IDLE",
                    {
                      "library_member": {},
                      "book_list": {},
                    },
                  );
                }
              },
            ).go();
          },
        ),
        HomeMenuJson(
          menuTitle: 'Renew',
          menuIcon: 'assets/images/icons/renew.png',
          onPressed: () {
            if(gestureTimer != null) {
              setState(() {
                gestureTimer!.cancel();
              });
            }

            MoveTo(
              context: context,
              target: const QRScanPage(),
              callback: (String? qrCode) async {
                if(qrCode != null) {
                  await MainServices(context: context).showLibraryMember(qrCode).then((result) {
                    if(result != null && result.libraryMemberData != null) {
                      MoveTo(
                        context: context,
                        target: RenewPage(
                          libraryMemberData: result.libraryMemberData!,
                        ),
                        callback: (_) {
                          if(gestureTimer != null && gestureTimer!.isActive == false) {
                            setState(() {
                              gestureTimer = Timer.periodic(
                                const Duration(seconds: 1), (timer) =>
                                  checkTimeout(timer.tick),
                              );
                            });
                          }

                          DisplayMonitorServices.sendStateToMonitor(
                            "IDLE",
                            {
                              "library_member": {},
                              "book_list": {},
                            },
                          );
                        },
                      ).go();
                    } else {
                      if(gestureTimer != null && gestureTimer!.isActive == false) {
                        setState(() {
                          gestureTimer = Timer.periodic(
                            const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
                          );
                        });
                      }
                    }
                  });
                } else {
                  if(gestureTimer != null && gestureTimer!.isActive == false) {
                    setState(() {
                      gestureTimer = Timer.periodic(
                        const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
                      );
                    });
                  }

                  DisplayMonitorServices.sendStateToMonitor(
                    "IDLE",
                    {
                      "library_member": {},
                      "book_list": {},
                    },
                  );
                }
              },
            ).go();
          },
        ),
        HomeMenuJson(
          menuTitle: 'Return',
          menuIcon: 'assets/images/icons/return.png',
          onPressed: () {
            if(gestureTimer != null) {
              setState(() {
                gestureTimer!.cancel();
              });
            }

            MoveTo(
              context: context,
              target: const QRScanPage(),
              callback: (String? qrCode) async {
                if(qrCode != null) {
                  await MainServices(context: context).showLibraryMember(qrCode).then((result) {
                    if(result != null && result.libraryMemberData != null) {
                      MoveTo(
                        context: context,
                        target: ReturnPage(
                          libraryMemberData: result.libraryMemberData!,
                        ),
                        callback: (_) {
                          if(gestureTimer != null && gestureTimer!.isActive == false) {
                            setState(() {
                              gestureTimer = Timer.periodic(
                                const Duration(seconds: 1), (timer) =>
                                  checkTimeout(timer.tick),
                              );
                            });
                          }

                          DisplayMonitorServices.sendStateToMonitor(
                            "IDLE",
                            {
                              "library_member": {},
                              "book_list": {},
                            },
                          );
                        },
                      ).go();
                    } else {
                      if(gestureTimer != null && gestureTimer!.isActive == false) {
                        setState(() {
                          gestureTimer = Timer.periodic(
                            const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
                          );
                        });
                      }
                    }
                  });
                } else {
                  if(gestureTimer != null && gestureTimer!.isActive == false) {
                    setState(() {
                      gestureTimer = Timer.periodic(
                        const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
                      );
                    });
                  }

                  DisplayMonitorServices.sendStateToMonitor(
                    "IDLE",
                    {
                      "library_member": {},
                      "book_list": {},
                    },
                  );
                }
              },
            ).go();
          },
        ),
        HomeMenuJson(
          menuTitle: 'Account Info',
          menuIcon: 'assets/images/icons/account.png',
          onPressed: () {
            if(gestureTimer != null) {
              setState(() {
                gestureTimer!.cancel();
              });
            }

            MoveTo(
              context: context,
              target: const QRScanPage(),
              callback: (String? qrCode) async {
                if(qrCode != null) {
                  await MainServices(context: context).showLibraryMember(qrCode).then((result) {
                    if(result != null && result.libraryMemberData != null) {
                      MoveTo(
                        context: context,
                        target: AccountPage(
                          libraryMemberData: result.libraryMemberData!,
                        ),
                        callback: (_) {
                          if(gestureTimer != null && gestureTimer!.isActive == false) {
                            setState(() {
                              gestureTimer = Timer.periodic(
                                const Duration(seconds: 1), (timer) =>
                                  checkTimeout(timer.tick),
                              );
                            });
                          }

                          DisplayMonitorServices.sendStateToMonitor(
                            "IDLE",
                            {
                              "library_member": {},
                              "book_list": {},
                            },
                          );
                        },
                      ).go();
                    } else {
                      if(gestureTimer != null && gestureTimer!.isActive == false) {
                        setState(() {
                          gestureTimer = Timer.periodic(
                            const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
                          );
                        });
                      }
                    }
                  });
                } else {
                  DisplayMonitorServices.sendStateToMonitor(
                    "IDLE",
                    {
                      "library_member": {},
                      "book_list": {},
                    },
                  );

                  if(gestureTimer != null && gestureTimer!.isActive == false) {
                    setState(() {
                      gestureTimer = Timer.periodic(
                        const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
                      );
                    });
                  }
                }
              },
            ).go();
          },
        ),
        HomeMenuJson(
          menuTitle: 'Book Search',
          menuIcon: 'assets/images/icons/search.png',
          onPressed: () {
            if(gestureTimer != null) {
              setState(() {
                gestureTimer!.cancel();
              });
            }

            MoveTo(
              context: context,
              target: const BookListPage(),
              callback: (_) {
                if(gestureTimer != null && gestureTimer!.isActive == false) {
                  setState(() {
                    gestureTimer = Timer.periodic(
                      const Duration(seconds: 1), (timer) =>
                        checkTimeout(timer.tick),
                    );
                  });
                }

                DisplayMonitorServices.sendStateToMonitor(
                  "IDLE",
                  {
                    "library_member": {},
                    "book_list": {},
                  },
                );
              },
            ).go();
          },
        ),
        HomeMenuJson(
          menuTitle: 'Library Information',
          menuIcon: 'assets/images/icons/information.png',
          onPressed: () {
            if(gestureTimer != null) {
              setState(() {
                gestureTimer!.cancel();
              });
            }

            MoveTo(
              context: context,
              target: const LibraryInformationPage(),
              callback: (_) {
                if(gestureTimer != null && gestureTimer!.isActive == false) {
                  setState(() {
                    gestureTimer = Timer.periodic(
                      const Duration(seconds: 1), (timer) =>
                        checkTimeout(timer.tick),
                    );
                  });
                }

                DisplayMonitorServices.sendStateToMonitor(
                  "IDLE",
                  {
                    "library_member": {},
                    "book_list": {},
                  },
                );
              },
            ).go();
          },
        ),
      ];
    });
  }

  interactWithPage() async {
    if(isOnScreensaver == true) {
      setState(() {
        isOnScreensaver = false;

        gestureTimer = Timer.periodic(
          const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
        );
      });
    } else if(gestureTimer != null && isOnScreensaver == false) {
      setState(() {
        gestureTimer!.cancel();

        gestureTimer = Timer.periodic(
          const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
        );
      });
    }
  }

  checkTimeout(int tick) {
    if(tick == 60) {
      setState(() {
        if(gestureTimer != null) {
          gestureTimer!.cancel();
        }

        isOnScreensaver = true;
      });
    }
  }

  openSettings() {
    if(gestureTimer != null) {
      setState(() {
        gestureTimer!.cancel();
      });
    }

    MoveTo(
      context: context,
      target: const LockSettingPage(),
      callback: (result) {
        if(result != null && result == true) {
          MoveTo(
            context: context,
            target: const SettingPage(),
            callback: (_) {
              if(gestureTimer != null && gestureTimer!.isActive == false) {
                setState(() {
                  gestureTimer = Timer.periodic(
                    const Duration(seconds: 1), (timer) =>
                      checkTimeout(timer.tick),
                  );
                });
              }

              DisplayMonitorServices.sendStateToMonitor(
                "IDLE",
                {
                  "library_member": {},
                  "book_list": {},
                },
              );
            },
          ).go();
        } else {
          if(gestureTimer != null && gestureTimer!.isActive == false) {
            setState(() {
              gestureTimer = Timer.periodic(
                const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
              );
            });
          }

          DisplayMonitorServices.sendStateToMonitor(
            "IDLE",
            {
              "library_member": {},
              "book_list": {},
            },
          );
        }
      },
    ).go();
  }

  @override
  Widget build(BuildContext context) {
    return HomeViewPage(controller: this);
  }

  @override
  void dispose() {
    if(gestureTimer != null) {
      gestureTimer!.cancel();
    }

    pbConfig.collection("testing").unsubscribe("*");

    super.dispose();
  }
}