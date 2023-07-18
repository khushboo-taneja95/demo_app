// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tres_connect/core/bloc/configuration_bloc/bloc/configuration_bloc.dart';
// import 'package:tres_connect/core/database/entity/health_rating_entity.dart';
// import 'package:tres_connect/core/di/injection.dart';
// import 'package:tres_connect/core/themes/palette.dart';
// import 'package:tres_connect/core/utility/ColorUtils.dart';
// import 'package:tres_connect/core/utility/EncodeUtils.dart';
// import 'package:tres_connect/core/utility/utils.dart';
// import 'package:tres_connect/features/main/presentation/health_rating/bloc/health_rating_bloc.dart';
// import 'package:tres_connect/gen/assets.gen.dart';
// import 'package:tres_connect/global_configuration.dart';

// enum HealthRating { normal, cautious, danger }

// class ProfilePhotoWidget extends StatelessWidget {
//   final double size;
//   final bool showRing;
//   const ProfilePhotoWidget({Key? key, this.size = 100, this.showRing = true})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HealthRatingBloc, HealthRatingState>(
//       builder: (context, state) {
//         return Container(
//             width: size,
//             height: size,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.all(Radius.circular(size)),
//                 border: Border.all(
//                     color: getRingColor(
//                         healthRating: state is HealthRatingLoaded
//                             ? state.healthRatingEntity
//                             : null),
//                     width: showRing ? 3 : 0),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.grey,
//                     blurRadius: 3.0,
//                   ),
//                 ]),
//             child: Padding(
//               padding: EdgeInsets.all(showRing ? 2.0 : 0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(size)),
//                 child: getImageWidget(),
//               ),
//             ));
//       },
//     );
//   }

//   Widget getImageWidget() {
//     return BlocBuilder<ConfigurationBloc, ConfigurationState>(
//         builder: (context, state) {
//       if (state is ConfigurationLoaded) {
//         String? photoUrl =
//             state.globalConfiguration.profile.cropUserProfilePicture;
//         if (photoUrl != null && photoUrl != "") {
//           return Image.network(
//             photoUrl,
//             height: size,
//             width: size,
//             fit: BoxFit.cover,
//           );
//         } else {
//           return Container(
//               width: size,
//               height: size,
//               decoration: BoxDecoration(
//                   color: ColorUtils.generateColorFromString(
//                       EncodeUtils.decodeBase64(
//                           getIt<GlobalConfiguration>().profile.firstName)),
//                   borderRadius: BorderRadius.all(Radius.circular(size))),
//               child: Center(
//                   child: Text(
//                 Utils.getInitials(EncodeUtils.decodeBase64(
//                     getIt<GlobalConfiguration>().profile.firstName)),
//                 style: TextStyle(color: Colors.white, fontSize: size / 4),
//                 textAlign: TextAlign.center,
//               )));
//         }
//       } else {
//         return Assets.images.groupIcon
//             .image(height: size, width: size, fit: BoxFit.cover);
//       }
//     });
//   }

//   Color getRingColor({HealthRatingEntity? healthRating}) {
//     switch (healthRating?.riskRating) {
//       case "Green":
//         return Colors.green;
//       case "Orange":
//         return Colors.orange;
//       case "Red":
//         return Palette.red;
//       default:
//         return Colors.grey;
//     }
//   }
// }
