// // 여기 dto는 확장가능성을 위해 남겨둠! 지금은 안쓸거임


// class AppleResponseDto {
//   final String? email;
//   final String? fullName;
//   final String? idToken;
//   final String? authorizationCode;

//   AppleResponseDto({
//     this.email,
//     this.fullName,
//     this.idToken,
//     this.authorizationCode,
//   });

//   AppleResponseDto.fromJson(Map<String, dynamic> map)
//       : this(
//           email: map['email'] ?? '',
//           fullName: map['fullName'] ?? '',
//           idToken: map['idToken'] ?? '',
//           authorizationCode: map['authorizationCode'] ?? '',
//         );

//   Map<String, dynamic> toJson() {
//     return {
//       'email': email,
//       'fullName': fullName,
//       'idToken': idToken,
//       'authorizationCode': authorizationCode,
//     };
//   }
// }
