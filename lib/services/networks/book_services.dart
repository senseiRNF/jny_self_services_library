import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_account_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';
import 'package:jny_self_services_library/services/networks/network_options.dart';

class BookServices {
  BuildContext context;

  BookServices({required this.context});

  Future<BookDataJson?> showBookByRFID(String rfid) async {
    BookDataJson? result;

    await SharedPrefsFunctions.readData('account').then((accountResult) async {
      if(accountResult != null) {
        LocalAccountJson account = LocalAccountJson.fromJson(jsonDecode(accountResult));

        await NetworkOption.init().then((dio) async {
          try {
            await dio.get(
              '/library/books/$rfid',
              queryParameters: {
                'type': 'rfid',
              },
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${account.accessToken}',
                },
              ),
            ).then((getResult) {
              if(getResult.statusCode == 200 || getResult.statusCode == 201) {
                if(getResult.data != null) {
                  SpecificBookJson specificBookJson = SpecificBookJson.fromJson(getResult.data);

                  if(specificBookJson.bookDataJson != null) {
                    result = specificBookJson.bookDataJson!;
                  }
                }
              }
            });
          } on DioException catch(dioExc) {
            if(dioExc.response != null && dioExc.response!.statusCode != 404) {
              ErrorHandler(context: context, dioExc: dioExc).show();
            }
          }
        });
      }
    });

    return result;
  }

  Future<bool> borrowBook(String fromDate, String untilDate, String itemList, String? studentId, String? employeeId) async {
    bool result = false;

    await SharedPrefsFunctions.readData('account').then((accountResult) async {
      if(accountResult != null) {
        LocalAccountJson account = LocalAccountJson.fromJson(jsonDecode(accountResult));

        await NetworkOption.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.post(
              '/library/loan',
              data: studentId != null ?
              {
                'from_date': fromDate,
                'until_date': untilDate,
                'item_list_id': itemList,
                'student_id': studentId,
              } : employeeId != null ?
              {
                'from_date': fromDate,
                'until_date': untilDate,
                'item_list_id': itemList,
                'employee_id': employeeId,
              } :
              {},
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${account.accessToken}',
                },
              ),
            ).then((getResult) {
              CloseBack(context: context).go();

              if(getResult.statusCode == 200 || getResult.statusCode == 201) {
                result = true;
              }
            });
          } on DioException catch(dioExc) {
            CloseBack(context: context).go();

            if(dioExc.response != null && dioExc.response!.statusCode != 404) {
              ErrorHandler(context: context, dioExc: dioExc).show();
            }
          }
        });
      }
    });

    return result;
  }

  Future<BorrowedDetailJson?> checkBorrowedBook(String? studentId, String? employeeId) async {
    BorrowedDetailJson? result;

    await SharedPrefsFunctions.readData('account').then((accountResult) async {
      if(accountResult != null) {
        LocalAccountJson account = LocalAccountJson.fromJson(jsonDecode(accountResult));

        await NetworkOption.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.get(
              '/library/loan',
              queryParameters: studentId != null ? {
                'student_id': studentId,
              } : employeeId != null ? {
                'employee_id': employeeId,
              } : {},
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${account.accessToken}',
                },
              ),
            ).then((getResult) {
              CloseBack(context: context).go();

              if(getResult.statusCode == 200 || getResult.statusCode == 201) {
                if(getResult.data != null) {
                  result = BorrowedDetailJson.fromJson(getResult.data);
                }
              }
            });
          } on DioException catch(dioExc) {
            CloseBack(context: context).go();

            if(dioExc.response != null && dioExc.response!.statusCode != 404) {
              ErrorHandler(context: context, dioExc: dioExc).show();
            }
          }
        });
      }
    });

    return result;
  }

  Future<bool> extendPeriodBook(int borrowId, String untilDate, String itemList, String? studentId, String? employeeId) async {
    bool result = false;

    await SharedPrefsFunctions.readData('account').then((accountResult) async {
      if(accountResult != null) {
        LocalAccountJson account = LocalAccountJson.fromJson(jsonDecode(accountResult));

        await NetworkOption.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.post(
              '/library/extend-loan/$borrowId',
              data: studentId != null ?
              {
                'until_date': untilDate,
                'item_list_id': itemList,
                'student_id': studentId,
              } : employeeId != null ?
              {
                'until_date': untilDate,
                'item_list_id': itemList,
                'employee_id': employeeId,
              } :
              {},
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${account.accessToken}',
                },
              ),
            ).then((getResult) {
              CloseBack(context: context).go();

              if(getResult.statusCode == 200 || getResult.statusCode == 201) {
                result = true;
              }
            });
          } on DioException catch(dioExc) {
            CloseBack(context: context).go();

            if(dioExc.response != null && dioExc.response!.statusCode != 404) {
              ErrorHandler(context: context, dioExc: dioExc).show();
            }
          }
        });
      }
    });

    return result;
  }

  Future<bool> returnBook(int borrowId, String returnDate, String itemList, String? studentId, String? employeeId) async {
    bool result = false;

    await SharedPrefsFunctions.readData('account').then((accountResult) async {
      if(accountResult != null) {
        LocalAccountJson account = LocalAccountJson.fromJson(jsonDecode(accountResult));

        await NetworkOption.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.post(
              '/library/return-loan/$borrowId',
              data: studentId != null ?
              {
                'return_date': returnDate,
                'item_list_id': itemList,
                'student_id': studentId,
              } : employeeId != null ?
              {
                'return_date': returnDate,
                'item_list_id': itemList,
                'employee_id': employeeId,
              } :
              {},
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${account.accessToken}',
                },
              ),
            ).then((getResult) {
              CloseBack(context: context).go();

              if(getResult.statusCode == 200 || getResult.statusCode == 201) {
                result = true;
              }
            });
          } on DioException catch(dioExc) {
            CloseBack(context: context).go();

            if(dioExc.response != null && dioExc.response!.statusCode != 404) {
              ErrorHandler(context: context, dioExc: dioExc).show();
            }
          }
        });
      }
    });

    return result;
  }
}