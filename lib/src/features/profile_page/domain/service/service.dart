import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:poll_dao/src/core/constants/server_constants.dart';
import 'package:poll_dao/src/features/profile_page/data/models/change_password.dart';
import 'package:poll_dao/src/features/profile_page/data/models/profile_model.dart';
import 'package:poll_dao/src/features/widget_servers/loger_service/loger.dart';
import 'package:poll_dao/src/features/widget_servers/repositories/storage_repository.dart';
import 'package:poll_dao/src/features/widget_servers/universal_data/universaldata.dart';

class Service {
  final _dio = Dio(
    BaseOptions(
      headers: {"Content-Type": "application/json"},
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
    ),
  );

  Service() {
    _init();
  }

  _init() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          debugPrint("AN ERROR HAS OCCURRED:${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint("REQUEST HAS BEEN SENT :${requestOptions.path}");
          final token = StorageRepository.getString("token");
          requestOptions.headers.addAll({"access-token": token});
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("ANSWER HAS COME :${response.requestOptions.path}");
          return handler.next(response);
        },
      ),
    );
  }

  Future<UniversalData> fetchProfileData() async {
    Response response;
    try {
      response = await _dio.get("http://94.131.10.253:3000/settings/profile/me");
      LoggerService.i("Response=>$response");
      return UniversalData(data: ProfileModel.fromJson(response.data));
    } on DioException catch (e) {
      LoggerService.e("Response=>${e.message}");
      return UniversalData(error: e.response!.data.toString());
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> putProfileData({
    required String location,
    required int age,
    required String name,
    required String education,
    required String gender,
    required String nationality,
  }) async {
    Response response;
    try {
      response = await _dio.put("http://94.131.10.253:3000/settings/profile/update",
          data: {
            "location": location,
            "age": age,
            "name": name,
            "education": education,
            "gender": gender,
            "nationality": nationality,
          },
          options: Options(
            headers: {"access-token": StorageRepository.getString("token")},
          ));
      debugPrint("TOKEN=>${StorageRepository.getString("token")}");

      LoggerService.i("Response=>$response");
      //LoggerService.e("Response=>${response.data}");
      LoggerService.d("Response=>${response.data.hashCode}");
      return UniversalData(data: ProfileModel.fromJson(response.data));
    } on DioException catch (e) {
      debugPrint("DIO ERROR=>${e.response!.data}");
      return UniversalData(error: e.response!.data.toString());
    } catch (e) {
      debugPrint("DIO ERROR=>$e");
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> sendProfileData({required String oldPassword, required String newPassword}) async {
    Response response;
    try {
      response = await _dio.put("http://94.131.10.253:3000/settings/profile/change-password",
          data: {
            "old_password": oldPassword,
            "new_password": newPassword,
          },
          options: Options(
            headers: {"access-token": StorageRepository.getString("token")},
          ));
      LoggerService.i("Response=>$response");
      LoggerService.e("Response=>${response.data}");
      LoggerService.d("Response=>${response.data.hashCode}");
      debugPrint("Response=>${response.data}");
      return UniversalData(data: ChangePasswordModel.fromJson(response.data));
    } on DioException catch (e) {
      debugPrint("DIO ERROR=>${e.response!.data}");
      return UniversalData(error: e.response!.data.toString());
    } catch (e) {
      debugPrint("ASOLUT POXUY ERROR=>$e");
      return UniversalData(error: e.toString());
    }
  }

  //delete account
  Future<void> deleteAccount() async {
    Response response;
    response = await _dio.delete(
      "http://94.131.10.253:3000/settings/delete",
      options: Options(
        headers: {"access-token": StorageRepository.getString("token")},
      ),
    );
    LoggerService.i("Response=>$response");
  }
}

UniversalData getDioCustomError(DioException exception) {
  debugPrint("DIO ERROR TYPE: ${exception.type}");
  if (exception.response != null) {
    return UniversalData(error: exception.response!.data["message"]);
  }
  switch (exception.type) {
    case DioExceptionType.sendTimeout:
      {
        return UniversalData(error: "sendTimeout");
      }
    case DioExceptionType.receiveTimeout:
      {
        return UniversalData(error: "receiveTimeout");
      }
    case DioExceptionType.cancel:
      {
        return UniversalData(error: "cancel");
      }
    case DioExceptionType.badCertificate:
      {
        return UniversalData(error: "badCertificate");
      }
    case DioExceptionType.badResponse:
      {
        return UniversalData(error: "badResponse");
      }
    case DioExceptionType.connectionError:
      {
        return UniversalData(error: "connectionError");
      }
    case DioExceptionType.connectionTimeout:
      {
        return UniversalData(error: "connectionTimeout");
      }
    default:
      {
        return UniversalData(error: "unknown");
      }
  }
}
