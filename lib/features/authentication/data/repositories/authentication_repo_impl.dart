import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:planitly/features/authentication/data/remote/token_dto.dart';
import 'package:planitly/features/authentication/domain/entity/token_entity.dart';
import 'package:planitly/features/authentication/domain/repositories/authentication_repo.dart';
import 'package:planitly/shared/bases/base_repo.dart';
import 'package:planitly/shared/networking/failures.dart';
import '../../../../../shared/configs/endpoints.dart';
import '../../../../../shared/local_storage_manager.dart';

class AuthenticationRepositoryImpl extends BaseRepository implements AuthenticationRepository {
  final LocalStorageManager _storageManager;

  AuthenticationRepositoryImpl(super.dio, this._storageManager);

  @override
  Future<Either<NetworkException, TokenEntity>> login({
    required String email,
    required String password,
  }) async {
    return await tryToExecute(
      () => dio.post(
        EndPoints.login,
        data: {
          "email": email,
          "password": password,
        },
      ),
      (response) {
        // final token = TokenDto().fromJson(response).toEntity();
        // _storageManager.saveLoginToken(token);
        // return token;
      },
    );
  }

  @override
  Future<Either<NetworkException, bool>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    return await tryToExecute(
      () => dio.post(
        EndPoints.register,
        data: {
          "username": username,
          "email": email,
          "password": password,
        },
      ),
      (response) {
        return true;
      } ,
    );
  }

  // @override
  // Future<Either<NetworkException, bool>> checkPhoneNumber(
  //     {required String phone}) async {
  //   final result = await login(phone: phone);
  //   return result.fold((l) => left(l), (r) => right(true));
  // }

  // @override
  // Future<Either<NetworkException, bool>> getUserFromQR(
  //     {required String userId, required String phoneNumber}) async {
  //   String phone = phoneNumber;
  //   if (phoneNumber.startsWith("0")) {
  //     phone = phoneNumber.replaceFirst("0", "+964");
  //   }

  //   final result = await tryToExecute<String>(
  //     () => dio.post(EndPoints.getUserInfo(userId), data: "\"$phone\""),
  //     (response) => response,
  //   );
  //   return result.fold(
  //     (l) => left(l),
  //     (accessToken) {
  //       _storageManager.saveLoginToken(
  //           TokenEntity(accessToken: accessToken, refreshToken: ''));
  //       return right(accessToken.isNotEmpty);
  //     },
  //   );
  // }

  // @override
  // Future<Either<NetworkException, bool>> verifyOtp({
  //   required String phone,
  //   required String code,
  // }) async {
  //   String phoneNumber = phone;
  //   if (phone.startsWith("0")) {
  //     phoneNumber = phone.replaceFirst("0", "+964");
  //   }
  //   final result = await tryToExecute<String>(
  //     () => dio.post(
  //       EndPoints.verifyOtp,
  //       data: {
  //         "phoneNumber": phoneNumber,
  //         "otp": code,
  //       },
  //     ),
  //     (response) => response,
  //   );
  //   return result.fold((l) => left(l), (accessToken) {
  //     _storageManager.saveLoginToken(
  //         TokenEntity(accessToken: accessToken, refreshToken: ''));
  //     return right(accessToken.isNotEmpty);
  //   });
  // }



  // @override
  // Future<Either<NetworkException, bool>> registerPhoneNumber(
  //     {required String phone}) async {
  //   String phoneNumber = phone;
  //   if (phoneNumber.startsWith("0")) {
  //     phoneNumber = phone.replaceFirst("0", "+964");
  //   }
  //   final result = await tryToExecute(
  //     () => dio.post(EndPoints.registerPhoneNumber,
  //         data: FormData.fromMap({'phoneNumber': phoneNumber})),
  //     (response) => response,
  //   );
  //   return result.fold(
  //     (l) => left(l),
  //     (result) {
  //       if(result is int) {
  //         return right(true);
  //       }else{
  //         _storageManager.saveLoginToken(TokenEntity(accessToken: result, refreshToken: ''));
  //         return right(false);
  //       }
  //     },
  //   );
  // }

  // @override
  // Future<Either<NetworkException, bool>> setPassword({
  //   required String password,
  // }) async {
  //   final result = await tryToExecute(
  //     () => dio.post(EndPoints.setPassword, data: "\"$password\""),
  //     (accessToken) {
  //       logout();
  //     },
  //   );
  //   return result.fold((l) => left(l), (r) => right(true));
  // }

  @override
  Future<Either<NetworkException, TokenEntity>> refreshToken(
      String token, String refreshToken) async {
    final result = await tryToExecute<TokenEntity>(
      () => dio.post(EndPoints.refreshToken, data: {
        "accessToken": token,
        "refreshToken": refreshToken,
      }),
      (response) => TokenDto().fromJson(response).toEntity(),
    );
    return result.fold(
      (l) => left(l),
      (token) {
        _storageManager.saveLoginToken(token);
        return right(token);
      },
    );
  }

// @override
// Future<Either<NetworkException, bool>> register(RegisterModel data) async {
//   String? phoneNumber = data.phoneNumber;
//   if (phoneNumber!.startsWith("0")) {
//     phoneNumber = phoneNumber.replaceFirst("0", "+964");
//   }
//   String? deviceToken = "";
//   try {
//     deviceToken = await firebaseMessaging.getToken();
//   } catch (e) {
//     print("Error fetching device token: $e");
//   }
//   final result = await tryToExecute<bool>(
//     () async => dio.post(EndPoints.registerWithCar,
//         data: FormData.fromMap({
//           'CitizenImage':await MultipartFile.fromFile(data.citizenImage?.path ?? ''),
//           'IdFrontImage': await MultipartFile.fromFile(data.idFrontImage?.path ?? ''),
//           'IdBackImage':  await MultipartFile.fromFile(data.idBackImage?.path ?? ''),
//           'ResidenceCardFrontImage': await MultipartFile.fromFile(data.residenceCardFrontImage?.path ?? ''),
//           'ResidenceCardBackImage':await MultipartFile.fromFile(data.residenceCardBackImage?.path ?? ''),
//           'RationCardImage': await MultipartFile.fromFile(data.rationCardImage?.path ?? ''),
//           'PassportImage': data.passportImage != null ? await MultipartFile.fromFile(data.passportImage?.path ?? '') : null,
//           'ModelName': data.modelName,
//           'ModelYear': data.modelYear,
//           'PlateNumber': data.plateNumber,
//           'Letter': data.letter,
//           'ProvinceId': data.provinceId,
//           'CarTypeId': data.carTypeId,
//           'Cylinders': data.cylinders,
//           'CarRegistrationIdFrontImage':await MultipartFile.fromFile(data.carRegistrationIdFrontImage?.path ?? ""),
//           'CarRegistrationIdBackImage':await MultipartFile.fromFile(data.carRegistrationIdBackImage?.path ?? ""),
//           'CarImage': await MultipartFile.fromFile(data.carImage?.path ?? ""),
//           'EnglishName': data.englishName,
//           'CarAuthorizationImage':  data.carAuthorizationImage != null ? await MultipartFile.fromFile(data.carAuthorizationImage?.path ?? "") : null,
//           'DeviceId': deviceToken,
//           'PhoneNumber': phoneNumber,
//           'Gender':data.gender,
//           'DateOfBirth': data.dateOfBirth,
//           'Email': data.email,
//           'IsNationalCardId': data.isNationalCardId,
//           'Address': data.address,
//           'CardIdNumber': data.cardIdNumber,
//           'RationCardNumber': data.rationCardNumber,
//           'FamilyHeadName': data.familyHeadName,
//           'SupplyCenterNumber': data.supplyCenterNumber,
//           'FirstName': data.firstName,
//           'MiddleName': data.middleName,
//           'LastName': data.lastName,
//           'MotherFirstName': data.motherFirstName,
//           'MotherLastName': data.motherLastName,
//           'Surname': data.surname,
//           'LivingProvince': data.province,
//           'City': data.city,
//           'EnCity': data.enCity,
//           'Neighborhood': "0",
//           'Alley': "0",
//           'House': data.house,
//           'FamilyId': data.familyId,
//           'IdIssueDate': data.idIssueDate,
//           'IdExpireDate': data.idExpireDate,
//           'IdIssuePlace': data.idIssuePlace,
//           'BirthPlace': data.birthPlace,
//           'BirthCountry': data.birthCountry,
//           'Job': data.job,
//           'MonthlyIncome': data.monthlyIncome,
//           'HasOtherNationality': data.hasOtherNationality,
//           'OtherNationality': data.otherNationality,
//           'IsPolExpo': data.isPolExpo,
//           'WillUseCardInternationally': data.willUseCardInternationally,
//           'EnSurname': data.enSurname,
//           'EnMotherName': data.enMotherName,
//           'PassportNumber': data.passportNumber,
//           'PassportIssueDate': data.passportIssueDate,
//           'PassportExpireDate': data.passportExpireDate,
//         })),
//     (response) => true,
//   );
//   return result.fold((l) => left(l), (result) {
//     logout();
//     return right(true);
//   });
// }

  @override
  void logout() {
    _storageManager.clearLoginToken();
  }
}
