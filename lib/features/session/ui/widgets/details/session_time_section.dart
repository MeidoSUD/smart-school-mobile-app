// import 'package:geniuses_school/core/utils/date_time_helper.dart';
// import 'package:geniuses_school/data/models/session_model.dart';
// import 'package:flutter/material.dart';

// class SessionTimeSection extends StatelessWidget {
//   final StudentSession session;
//   const SessionTimeSection({super.key, required this.session});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final duration = DateTimeHelper.getDuration(
//       session.startTime,
//       session.endTime,
//     );

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: theme.primaryColor.withOpacity(0.08),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: theme.primaryColor.withOpacity(0.2),
//                   ),
//                 ),
//                 child: Icon(Icons.timer_outlined, color: theme.primaryColor),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "مدة الجلسة",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       duration.isNotEmpty ? duration : "-- دقيقة",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: theme.primaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
