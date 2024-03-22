import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_account_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/language_list_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/subjects_list_json.dart';
import 'package:jny_self_services_library/services/networks/network_options.dart';

class BookServices {
  BuildContext context;

  BookServices({required this.context});

  Future<List<BookDataJson>> showAllBook() async {
    List<BookDataJson> result = [];
    LocalAccountJson? account;

    await SharedPrefsFunctions.readData('account').then((accountResult) async {
      if(accountResult != null) {
        account = LocalAccountJson.fromJson(jsonDecode(accountResult));
      }

      await NetworkOption.init().then((dio) async {
        LoadingDialog(context: context).show();

        await dio.get(
          '/library/books',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${account?.accessToken}',
            },
          ),
        ).then((getResult) {
          CloseBack(context: context).go();

          if(getResult.statusCode == 200 || getResult.statusCode == 201) {
            if(getResult.data != null) {
              AllBookJson allBookJson = AllBookJson.fromJson(getResult.data);

              if(allBookJson.bookDataJson != null) {
                result = allBookJson.bookDataJson!;
              }
            }
          }
        }).catchError((dioExc) {
          CloseBack(context: context).go();

          if(dioExc.response != null && dioExc.response!.statusCode != 404) {
            ErrorHandler(context: context, dioExc: dioExc).show();
          }
        });
      });
    });

    return result;
  }

  Future<BookDataJson?> showBookByRFID(String rfid) async {
    BookDataJson? result;
    LocalAccountJson? account;

    await SharedPrefsFunctions.readData('account').then((accountResult) async {
      if(accountResult != null) {
        account = LocalAccountJson.fromJson(jsonDecode(accountResult));
      }

      await NetworkOption.init().then((dio) async {
        await dio.get(
          '/library/books/$rfid',
          queryParameters: {
            'type': 'rfid',
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer ${account?.accessToken}',
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
        }).catchError((dioExc) {
          if(dioExc.response != null && dioExc.response!.statusCode != 404) {
            ErrorHandler(context: context, dioExc: dioExc).show();
          }
        });
      });
    });

    return result;
  }

  Future<bool> borrowBook(String fromDate, String untilDate, String itemList, String? studentId, String? employeeId) async {
    bool result = false;
    LocalAccountJson? account;

    await SharedPrefsFunctions.readData('account').then((accountResult) async {
      if(accountResult != null) {
        account = LocalAccountJson.fromJson(jsonDecode(accountResult));
      }

      await NetworkOption.init().then((dio) async {
        LoadingDialog(context: context).show();

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
              'Authorization': 'Bearer ${account?.accessToken}',
            },
          ),
        ).then((getResult) {
          CloseBack(context: context).go();

          if(getResult.statusCode == 200 || getResult.statusCode == 201) {
            result = true;
          }
        }).catchError((dioExc) {
          CloseBack(context: context).go();

          if(dioExc.response != null && dioExc.response!.statusCode != 404) {
            ErrorHandler(context: context, dioExc: dioExc).show();
          }
        });
      });
    });

    return result;
  }

  Future<BorrowedDetailJson?> checkBorrowedBook(String? studentId, String? employeeId) async {
    BorrowedDetailJson? result;
    LocalAccountJson? account;

    await SharedPrefsFunctions.readData('account').then((accountResult) async {
      if(accountResult != null) {
        account = LocalAccountJson.fromJson(jsonDecode(accountResult));
      }

      await NetworkOption.init().then((dio) async {
        LoadingDialog(context: context).show();

        await dio.get(
          '/library/loan',
          queryParameters: studentId != null ? {
            'student_id': studentId,
          } : employeeId != null ? {
            'employee_id': employeeId,
          } : {},
          options: Options(
            headers: {
              'Authorization': 'Bearer ${account?.accessToken}',
            },
          ),
        ).then((getResult) {
          CloseBack(context: context).go();

          if(getResult.statusCode == 200 || getResult.statusCode == 201) {
            if(getResult.data != null) {
              result = BorrowedDetailJson.fromJson(getResult.data);
            }
          }
        }).catchError((dioExc) {
          CloseBack(context: context).go();

          if(dioExc.response != null && dioExc.response!.statusCode != 404) {
            ErrorHandler(context: context, dioExc: dioExc).show();
          }
        });
      });
    });

    return result;
  }

  Future<bool> extendPeriodBook(int borrowId, String untilDate, String itemList, String? studentId, String? employeeId) async {
    bool result = false;
    LocalAccountJson? account;

    await SharedPrefsFunctions.readData('account').then((accountResult) async {
      if(accountResult != null) {
        account = LocalAccountJson.fromJson(jsonDecode(accountResult));
      }

      await NetworkOption.init().then((dio) async {
        LoadingDialog(context: context).show();

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
              'Authorization': 'Bearer ${account?.accessToken}',
            },
          ),
        ).then((getResult) {
          CloseBack(context: context).go();

          if(getResult.statusCode == 200 || getResult.statusCode == 201) {
            result = true;
          }
        }).catchError((dioExc) {
          CloseBack(context: context).go();

          if(dioExc.response != null && dioExc.response!.statusCode != 404) {
            ErrorHandler(context: context, dioExc: dioExc).show();
          }
        });
      });
    });

    return result;
  }

  Future<bool> returnBook(int borrowId, String returnDate, String itemList, String? studentId, String? employeeId) async {
    bool result = false;
    LocalAccountJson? account;

    await SharedPrefsFunctions.readData('account').then((accountResult) async {
      if(accountResult != null) {
        account = LocalAccountJson.fromJson(jsonDecode(accountResult));
      }

      await NetworkOption.init().then((dio) async {
        LoadingDialog(context: context).show();

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
              'Authorization': 'Bearer ${account?.accessToken}',
            },
          ),
        ).then((getResult) {
          CloseBack(context: context).go();

          if(getResult.statusCode == 200 || getResult.statusCode == 201) {
            result = true;
          }
        }).catchError((dioExc) {
          CloseBack(context: context).go();

          if(dioExc.response != null && dioExc.response!.statusCode != 404) {
            ErrorHandler(context: context, dioExc: dioExc).show();
          }
        });
      });
    });

    return result;
  }

  Future<List<LanguageListDataJson>> showAllLanguage() async {
    List<LanguageListDataJson> result = [];
    LocalAccountJson? account;

    await SharedPrefsFunctions.readData('account').then((accountResult) async {
      if(accountResult != null) {
        account = LocalAccountJson.fromJson(jsonDecode(accountResult));
      }

      await NetworkOption.init().then((dio) async {
        LoadingDialog(context: context).show();

        await dio.get(
          '/library/language',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${account?.accessToken}',
            },
          ),
        ).then((getResult) {
          CloseBack(context: context).go();

          if(getResult.statusCode == 200 || getResult.statusCode == 201) {
            if(getResult.data != null) {
              LanguageListJson languageListJson = LanguageListJson.fromJson(getResult.data);

              if(languageListJson.languageListDataJson != null) {
                result = languageListJson.languageListDataJson!;
              }
            }
          }
        }).catchError((dioExc) {
          CloseBack(context: context).go();

          if(dioExc.response != null && dioExc.response!.statusCode != 404) {
            ErrorHandler(context: context, dioExc: dioExc).show();
          }
        });
      });
    });

    return result;
  }

  Future<List<SubjectListDataJson>> showAllSubjects() async {
    List<SubjectListDataJson> result = [];
    LocalAccountJson? account;

    await SharedPrefsFunctions.readData('account').then((accountResult) async {
      if(accountResult != null) {
        account = LocalAccountJson.fromJson(jsonDecode(accountResult));
      }

      await NetworkOption.init().then((dio) async {
        LoadingDialog(context: context).show();

        await dio.get(
          '/library/subjects',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${account?.accessToken}',
            },
          ),
        ).then((getResult) {
          CloseBack(context: context).go();

          if(getResult.statusCode == 200 || getResult.statusCode == 201) {
            if(getResult.data != null) {
              SubjectListJson subjectListJson = SubjectListJson.fromJson(getResult.data);

              if(subjectListJson.subjectListDataJson != null) {
                result = subjectListJson.subjectListDataJson!;
              }
            }
          }
        }).catchError((dioExc) {
          CloseBack(context: context).go();

          if(dioExc.response != null && dioExc.response!.statusCode != 404) {
            ErrorHandler(context: context, dioExc: dioExc).show();
          }
        });
      });
    });

    return result;
  }
}