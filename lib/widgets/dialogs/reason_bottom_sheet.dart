// import 'package:flutter/material.dart';
// import 'package:tres_connect/core/bloc/bloc.dart';
// import 'package:tres_connect/core/database/entity/health_rating_entity.dart';
// import 'package:tres_connect/features/main/presentation/health_rating/bloc/health_rating_bloc.dart';
// import 'package:tres_connect/widgets/tres_btn.dart';

// class ReasonBottomSheetWidget extends StatefulWidget {
//   ReasonBottomSheetWidget({super.key});

//   @override
//   State<ReasonBottomSheetWidget> createState() =>
//       _ReasonBottomSheetWidgetState();
// }

// class _ReasonBottomSheetWidgetState extends State<ReasonBottomSheetWidget> {
//   List<String> reasons = [];
//   String selectedReason = "";
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HealthRatingBloc, HealthRatingState>(
//         builder: (context, state) {
//       if (state is HealthRatingLoaded) {
//         populateReasons(state.healthRatingEntity);
//         return Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemBuilder: (context, index) {
//                   return RadioListTile(
//                     value: reasons[index],
//                     groupValue: selectedReason,
//                     onChanged: (str) {
//                       setState(() {
//                         selectedReason = str.toString();
//                       });
//                     },
//                     title: Text(reasons[index]),
//                   );
//                 },
//                 itemCount: reasons.length,
//               ),
//             ),
//             MyButton(
//                 text: "Save",
//                 onClick: () {
//                   final rating = state.healthRatingEntity.copyWith(
//                     remarks: selectedReason,
//                   );
//                   saveReason(rating);
//                 })
//           ],
//         );
//       } else {
//         return Container();
//       }
//     });
//   }

//   void saveReason(HealthRatingEntity ratingEntity) {
//     BlocProvider.of<HealthRatingBloc>(context).add(
//       SaveHealthReasonEvent(
//         ratingEntity: ratingEntity,
//       ),
//     );
//     Navigator.pop(context);
//   }

//   void populateReasons(HealthRatingEntity entity) {
//     reasons.clear();
//     if (entity.travelReason?.toUpperCase() == "BT") {
//       if (entity.riskRating?.toUpperCase() == "RED") {
//         reasons.add("Yes, I had fever for these 3 days");
//         reasons.add("I was doing exercise during this time.");
//         reasons.add("I don't think I had fever during these days");
//         reasons.add("I was in the sun for a long duration.");
//         reasons.add("I was cooking near the stove.");
//         reasons.add("I was having a hot shower.");
//         reasons.add("Not Sure - None  of the above");
//       } else if (entity.riskRating?.toUpperCase() == "ORANGE") {
//         reasons.add("I was in the sun for a long duration.");
//         reasons.add("I was doing exercise during this time.");
//         reasons.add("I was cooking near the stove.");
//         reasons.add("I was having a hot shower.");
//         reasons.add("I think I had fever.");
//         reasons.add("I don’t think I had fever during this time.");
//         reasons.add("I was not wearing the smart band during this time");
//         reasons.add("Not Sure - None  of the above");
//       }
//     } else {
//       reasons.add("I was doing excercise during this time");
//       reasons.add("I was hiking during this time");
//       reasons.add("I was not wearing the smart band during this time");
//       reasons.add("Not Sure - None Of The Above");
//     }
//   }
// }
