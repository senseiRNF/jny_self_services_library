import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_account_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_history_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/language_list_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/subjects_list_json.dart';
import 'package:local_function_collections/local_function_collections.dart';

class BookServices {
  static Future<List<BookDataJson>> showBookByFilter({
    required BuildContext context,
    required String parameter,
  }) async {
    List<BookDataJson> result = [];

    LocalAccountJson? account;

    CancelToken cancelToken = CancelToken();

    String? encodedAccount = await LocalSecureStorage.readKey(
      key: StaticVariables.accountKey,
    );

    if(encodedAccount != null) {
      account = LocalAccountJson.fromJson(
        jsonDecode(encodedAccount),
      );
    }

    if(!context.mounted) return [];

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.get,
      apisURL: StaticVariables.mainURL("library/books"),
      headerRequest: {
        "Accept": "application/json",
        "Authorization": "Bearer ${account?.accessToken}",
      },
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      if(response?.data is Map<String, dynamic>) {
        AllBookJson allBookJson = AllBookJson.fromJson(
          response?.data ?? {},
        );

        result = allBookJson.bookDataJson ?? [];
      }
    } else {
      String errMessage = response?.data?['message']
          ?? "Couldn't retrieve data from server, please try again!";

      if(context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: errMessage,
        );
      }
    }

    return result;
  }

  static Future<BookDataJson?> showBookByRFID({
    required BuildContext context,
    required String rfid,
  }) async {
    BookDataJson? result;

    LocalAccountJson? account;

    CancelToken cancelToken = CancelToken();

    String? encodedAccount = await LocalSecureStorage.readKey(
      key: StaticVariables.accountKey,
    );

    if(encodedAccount != null) {
      account = LocalAccountJson.fromJson(
        jsonDecode(encodedAccount),
      );
    }

    if(!context.mounted) return null;

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.get,
      apisURL: StaticVariables.mainURL("library/books/$rfid"),
      headerRequest: {
        "Accept": "application/json",
        "Authorization": "Bearer ${account?.accessToken}",
      },
      parameters: {
        'type': 'rfid',
      },
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      if(response?.data is Map<String, dynamic>) {
        SpecificBookJson specificBookJson = SpecificBookJson.fromJson(
          response?.data ?? {},
        );

        result = specificBookJson.bookDataJson;
      }
    } else {
      String errMessage = response?.data?['message']
          ?? "Couldn't retrieve data from server, please try again!";

      if(context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: errMessage,
        );
      }
    }

    return result;
  }

  static Future<bool> borrowBook({
    required BuildContext context,
    required String fromDate,
    required String untilDate,
    required String itemList,
    String? studentId,
    String? employeeId,
  }) async {
    bool result = false;

    LocalAccountJson? account;

    CancelToken cancelToken = CancelToken();

    String? encodedAccount = await LocalSecureStorage.readKey(
      key: StaticVariables.accountKey,
    );

    if(encodedAccount != null) {
      account = LocalAccountJson.fromJson(
        jsonDecode(encodedAccount),
      );
    }

    if(!context.mounted) return false;

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.post,
      apisURL: StaticVariables.mainURL("library/loan"),
      headerRequest: {
        "Accept": "application/json",
        "Authorization": "Bearer ${account?.accessToken}",
      },
      bodyData: studentId != null ?
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
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      result = true;
    } else {
      String errMessage = response?.data?['message']
          ?? "Couldn't retrieve data from server, please try again!";

      if (context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: errMessage,
        );
      }
    }

    return result;
  }

  static Future<BorrowedDetailJson?> checkCurrentBorrow({
    required BuildContext context,
    String? studentId,
    String? employeeId,
    String? status,
  }) async {
    BorrowedDetailJson? result;

    LocalAccountJson? account;

    Map<String, String> query = studentId != null ?
    status != null ? {
      'student_id': studentId,
      'status': status,
    } : {
      'student_id': studentId,
    } :
    employeeId != null ?
    status != null ? {
      'employee_id': employeeId,
      'status': status,
    } :
    {
      'employee_id': employeeId,
    } : {};

    CancelToken cancelToken = CancelToken();

    String? encodedAccount = await LocalSecureStorage.readKey(
      key: StaticVariables.accountKey,
    );

    if(encodedAccount != null) {
      account = LocalAccountJson.fromJson(
        jsonDecode(encodedAccount),
      );
    }

    if(!context.mounted) return null;

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.get,
      apisURL: StaticVariables.mainURL("library/loan"),
      headerRequest: {
        "Accept": "application/json",
        "Authorization": "Bearer ${account?.accessToken}",
      },
      parameters: query,
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      if(response?.data is Map<String, dynamic>) {
        result = BorrowedDetailJson.fromJson(
          response?.data ?? {},
        );
      }
    } else {
      String errMessage = response?.data?['message']
          ?? "Couldn't retrieve data from server, please try again!";

      if (context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: errMessage,
        );
      }
    }

    return result;
  }

  static Future<bool> extendPeriodBook({
    required BuildContext context,
    int? borrowId,
    required String untilDate,
    String? itemList,
    String?studentId,
    String? employeeId,
  }) async {
    bool result = false;

    LocalAccountJson? account;

    CancelToken cancelToken = CancelToken();

    String? encodedAccount = await LocalSecureStorage.readKey(
      key: StaticVariables.accountKey,
    );

    if(encodedAccount != null) {
      account = LocalAccountJson.fromJson(
        jsonDecode(encodedAccount),
      );
    }

    if(!context.mounted) return false;

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.post,
      apisURL: StaticVariables.mainURL(
        "library/extend-loan/$borrowId",
      ),
      headerRequest: {
        "Accept": "application/json",
        "Authorization": "Bearer ${account?.accessToken}",
      },
      bodyData: studentId != null ?
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
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      result = true;
    } else {
      String errMessage = response?.data?['message']
          ?? "Couldn't retrieve data from server, please try again!";

      if (context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: errMessage,
        );
      }
    }

    return result;
  }

  static Future<bool> returnBook({
    required BuildContext context,
    int? borrowId,
    required String returnDate,
    String? itemList,
    String? studentId,
    String? employeeId,
  }) async {
    bool result = false;

    LocalAccountJson? account;

    CancelToken cancelToken = CancelToken();

    String? encodedAccount = await LocalSecureStorage.readKey(
      key: StaticVariables.accountKey,
    );

    if(encodedAccount != null) {
      account = LocalAccountJson.fromJson(
        jsonDecode(encodedAccount),
      );
    }

    if(!context.mounted) return false;

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.post,
      apisURL: StaticVariables.mainURL(
        "library/return-loan/$borrowId",
      ),
      headerRequest: {
        "Accept": "application/json",
        "Authorization": "Bearer ${account?.accessToken}",
      },
      bodyData: studentId != null ?
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
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      result = true;
    } else {
      String errMessage = response?.data?['message']
          ?? "Couldn't retrieve data from server, please try again!";

      if (context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: errMessage,
        );
      }
    }

    return result;
  }

  static Future<List<LanguageListDataJson>> showAllLanguage({
    required BuildContext context,
  }) async {
    List<LanguageListDataJson> result = [];

    LocalAccountJson? account;

    CancelToken cancelToken = CancelToken();

    String? encodedAccount = await LocalSecureStorage.readKey(
      key: StaticVariables.accountKey,
    );

    if(encodedAccount != null) {
      account = LocalAccountJson.fromJson(
        jsonDecode(encodedAccount),
      );
    }

    if(!context.mounted) return [];

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.get,
      apisURL: StaticVariables.mainURL("library/language"),
      headerRequest: {
        "Accept": "application/json",
        "Authorization": "Bearer ${account?.accessToken}",
      },
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      if(response?.data is Map<String, dynamic>) {
        LanguageListJson languageListJson = LanguageListJson.fromJson(
          response?.data ?? {},
        );

        result = languageListJson.languageListDataJson ?? [];
      }
    } else {
      String errMessage = response?.data?['message']
          ?? "Couldn't retrieve data from server, please try again!";

      if(context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: errMessage,
        );
      }
    }

    return result;
  }

  static Future<List<SubjectListDataJson>> showAllSubjects({
    required BuildContext context,
  }) async {
    List<SubjectListDataJson> result = [];

    LocalAccountJson? account;

    CancelToken cancelToken = CancelToken();

    String? encodedAccount = await LocalSecureStorage.readKey(
      key: StaticVariables.accountKey,
    );

    if(encodedAccount != null) {
      account = LocalAccountJson.fromJson(
        jsonDecode(encodedAccount),
      );
    }

    if(!context.mounted) return [];

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.get,
      apisURL: StaticVariables.mainURL("library/subjects"),
      headerRequest: {
        "Accept": "application/json",
        "Authorization": "Bearer ${account?.accessToken}",
      },
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      if(response?.data is Map<String, dynamic>) {
        SubjectListJson subjectListJson = SubjectListJson.fromJson(
          response?.data ?? {},
        );

        result = subjectListJson.subjectListDataJson ?? [];
      }
    } else {
      String errMessage = response?.data?['message']
          ?? "Couldn't retrieve data from server, please try again!";

      if(context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: errMessage,
        );
      }
    }

    return result;
  }

  static Future<String?> showUntilDate({
    required BuildContext context,
    required String startDate,
    required int duration,
  }) async {
    String? result;

    CancelToken cancelToken = CancelToken();

    if(!context.mounted) return null;

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.get,
      apisURL: StaticVariables.mainURL("library/calendar"),
      headerRequest: {
        "Accept": "application/json",
      },
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      if(response?.data is Map<String, dynamic>) {
        result = response?.data['date'];
      }
    } else {
      String errMessage = response?.data?['message']
          ?? "Couldn't retrieve data from server, please try again!";

      if(context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: errMessage,
        );
      }
    }

    return result;
  }

  static Future<BookHistoryDataJson?> showBookHistory({
    required BuildContext context,
    required String rfid,
  }) async {
    BookHistoryDataJson? result;

    LocalAccountJson? account;

    CancelToken cancelToken = CancelToken();

    String? encodedAccount = await LocalSecureStorage.readKey(
      key: StaticVariables.accountKey,
    );

    if(encodedAccount != null) {
      account = LocalAccountJson.fromJson(
        jsonDecode(encodedAccount),
      );
    }

    if(!context.mounted) return null;

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.get,
      apisURL: StaticVariables.mainURL(
        "library/book-loan-histories/$rfid",
      ),
      headerRequest: {
        "Accept": "application/json",
        "Authorization": "Bearer ${account?.accessToken}",
      },
      parameters: {
        'type': 'rfid',
      },
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      if(response?.data is Map<String, dynamic>) {
        BookHistoryJson bookHistoryJson = BookHistoryJson.fromJson(
          response?.data ?? {},
        );

        result = bookHistoryJson.bookHistoryDataJson;
      }
    } else {
      String errMessage = response?.data?['message']
          ?? "Couldn't retrieve data from server, please try again!";

      if(context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: errMessage,
        );
      }
    }

    return result;
  }
}