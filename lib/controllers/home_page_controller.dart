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
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/home_menu_json.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:jny_self_services_library/services/networks/main_services.dart';
import 'package:jny_self_services_library/services/networks/pocket_base_config.dart';
import 'package:jny_self_services_library/view_pages/home_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted) {
        setState(() {
          scrollController.addListener(() => interactWithPage());

          homeMenu = [
            HomeMenuJson(
              menuTitle: 'Borrow',
              menuIcon: 'assets/images/icons/borrow.png',
              onPressed: () {
                if(mounted && gestureTimer != null) {
                  setState(() {
                    gestureTimer!.cancel();
                  });
                }

                LocalRouteNavigator.moveTo(
                  context: context,
                  target: const QRScanPage(),
                  callbackFunction: (String? qrCode) async {
                    if(qrCode != null) {
                      LibraryMemberJson? libraryMemberJson = await MainServices.showLibraryMember(
                        context: context,
                        qr: qrCode,
                      );

                      if(mounted && libraryMemberJson?.libraryMemberData != null) {
                        LocalRouteNavigator.moveTo(
                          context: context,
                          target: BorrowPage(
                            libraryMemberData: libraryMemberJson!.libraryMemberData!,
                          ),
                          callbackFunction: (_) {
                            if(mounted && gestureTimer != null && gestureTimer!.isActive == false) {
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
                        );
                      } else {
                        if(mounted && gestureTimer != null && gestureTimer!.isActive == false) {
                          setState(() {
                            gestureTimer = Timer.periodic(
                              const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
                            );
                          });
                        }
                      }
                    } else {
                      if(mounted && gestureTimer != null && gestureTimer!.isActive == false) {
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
                );
              },
            ),
            HomeMenuJson(
              menuTitle: 'Renew',
              menuIcon: 'assets/images/icons/renew.png',
              onPressed: () {
                if(mounted && gestureTimer != null) {
                  setState(() {
                    gestureTimer!.cancel();
                  });
                }

                LocalRouteNavigator.moveTo(
                  context: context,
                  target: const QRScanPage(),
                  callbackFunction: (String? qrCode) async {
                    if(qrCode != null) {
                      LibraryMemberJson? libraryMemberJson = await MainServices.showLibraryMember(
                        context: context,
                        qr: qrCode,
                      );

                      if(mounted && libraryMemberJson?.libraryMemberData != null) {
                        LocalRouteNavigator.moveTo(
                          context: context,
                          target: RenewPage(
                            libraryMemberData: libraryMemberJson!.libraryMemberData!,
                          ),
                          callbackFunction: (_) {
                            if(mounted && gestureTimer != null && gestureTimer!.isActive == false) {
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
                        );
                      } else {
                        if(mounted && gestureTimer != null && gestureTimer!.isActive == false) {
                          setState(() {
                            gestureTimer = Timer.periodic(
                              const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
                            );
                          });
                        }
                      }
                    } else {
                      if(mounted && gestureTimer != null && gestureTimer!.isActive == false) {
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
                );
              },
            ),
            HomeMenuJson(
              menuTitle: 'Return',
              menuIcon: 'assets/images/icons/return.png',
              onPressed: () {
                if(mounted && gestureTimer != null) {
                  setState(() {
                    gestureTimer!.cancel();
                  });
                }

                LocalRouteNavigator.moveTo(
                  context: context,
                  target: const QRScanPage(),
                  callbackFunction: (String? qrCode) async {
                    if(qrCode != null) {
                      LibraryMemberJson? libraryMemberJson = await MainServices.showLibraryMember(
                        context: context,
                        qr: qrCode,
                      );

                      if(mounted && libraryMemberJson?.libraryMemberData != null) {
                        LocalRouteNavigator.moveTo(
                          context: context,
                          target: ReturnPage(
                            libraryMemberData: libraryMemberJson!.libraryMemberData!,
                          ),
                          callbackFunction: (_) {
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
                        );
                      } else {
                        if(gestureTimer != null && gestureTimer!.isActive == false) {
                          setState(() {
                            gestureTimer = Timer.periodic(
                              const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
                            );
                          });
                        }
                      }
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
                );
              },
            ),
            HomeMenuJson(
              menuTitle: 'Account Info',
              menuIcon: 'assets/images/icons/account.png',
              onPressed: () {
                if(mounted && gestureTimer != null) {
                  setState(() {
                    gestureTimer!.cancel();
                  });
                }

                LocalRouteNavigator.moveTo(
                  context: context,
                  target: const QRScanPage(),
                  callbackFunction: (String? qrCode) async {
                    if(qrCode != null) {
                      LibraryMemberJson? libraryMemberJson = await MainServices.showLibraryMember(
                        context: context,
                        qr: qrCode,
                      );

                      if(mounted && libraryMemberJson?.libraryMemberData != null) {
                        LocalRouteNavigator.moveTo(
                          context: context,
                          target: AccountPage(
                            libraryMemberData: libraryMemberJson!.libraryMemberData!,
                          ),
                          callbackFunction: (_) {
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
                        );
                      } else {
                        if(mounted && gestureTimer != null && gestureTimer!.isActive == false) {
                          setState(() {
                            gestureTimer = Timer.periodic(
                              const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
                            );
                          });
                        }
                      }
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
                );
              },
            ),
            HomeMenuJson(
              menuTitle: 'Book Search',
              menuIcon: 'assets/images/icons/search.png',
              onPressed: () {
                if(mounted && gestureTimer != null) {
                  setState(() {
                    gestureTimer!.cancel();
                  });
                }

                LocalRouteNavigator.moveTo(
                  context: context,
                  target: const BookListPage(),
                  callbackFunction: (_) {
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
                );
              },
            ),
            HomeMenuJson(
              menuTitle: 'Library Information',
              menuIcon: 'assets/images/icons/information.png',
              onPressed: () {
                if(mounted && gestureTimer != null) {
                  setState(() {
                    gestureTimer!.cancel();
                  });
                }

                LocalRouteNavigator.moveTo(
                  context: context,
                  target: const LibraryInformationPage(),
                  callbackFunction: (_) {
                    if(mounted && gestureTimer != null && gestureTimer!.isActive == false) {
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
                );
              },
            ),
          ];
        });
      }
    });
  }

  void interactWithPage() async {
    if(mounted && isOnScreensaver == true) {
      setState(() {
        isOnScreensaver = false;

        gestureTimer = Timer.periodic(
          const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
        );
      });
    } else if(mounted && gestureTimer != null && isOnScreensaver == false) {
      setState(() {
        gestureTimer!.cancel();

        gestureTimer = Timer.periodic(
          const Duration(seconds: 1), (timer) => checkTimeout(timer.tick),
        );
      });
    }
  }

  void checkTimeout(int tick) {
    if(mounted && tick == 60) {
      setState(() {
        if(gestureTimer != null) {
          gestureTimer!.cancel();
        }

        isOnScreensaver = true;
      });
    }
  }

  void openSettings() {
    if(mounted && gestureTimer != null) {
      setState(() {
        gestureTimer!.cancel();
      });
    }

    LocalRouteNavigator.moveTo(
      context: context,
      target: const LockSettingPage(),
      callbackFunction: (result) {
        if(result != null && result == true) {
          LocalRouteNavigator.moveTo(
            context: context,
            target: const SettingPage(),
            callbackFunction: (_) {
              if(mounted && gestureTimer != null && gestureTimer!.isActive == false) {
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
          );
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
    );
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

    pbConfig.collection(
      StaticVariables.pocketBaseKey,
    ).unsubscribe("*");

    super.dispose();
  }
}