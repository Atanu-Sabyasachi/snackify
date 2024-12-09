// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:snackify/src/snackify_widget.dart';

// void main() {
//   testWidgets('Snackify displays a custom Snackbar',
//       (WidgetTester tester) async {
//     // Define a test key for the ElevatedButton
//     const testButtonKey = Key('testButton');

//     // Build the test widget
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: Builder(
//             builder: (BuildContext context) {
//               return ElevatedButton(
//                 key: testButtonKey,
//                 onPressed: () {
//                   Snackify.show(
//                     context: context,
//                     message: "This is a customizable Snackify Snackbar !",
//                     backgroundColor: Colors.indigo,
//                     textStyle: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     iconColor: Colors.yellow,
//                     icon: Icons.info_outline,
//                     elevation: 10.0,
//                     margin: const EdgeInsets.all(16.0),
//                     borderRadius: BorderRadius.circular(12.0),
//                     duration: const Duration(seconds: 5),
//                     animationDuration: const Duration(milliseconds: 1000),
//                     offset: const Offset(0, 50),
//                     animationBuilder: (context, animation, child) {
//                       return ScaleTransition(
//                         scale: animation,
//                         child: child,
//                       );
//                     },
//                     progressIndicator: const CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation(Colors.yellow),
//                     ),
//                     customWidget: null, // Leave null to use default content
//                     stackSnackbars: true,
//                     persistent: false,
//                     backgroundGradient: const LinearGradient(
//                       colors: [Colors.blue, Colors.purple],
//                     ),
//                     position: SnackifyPosition.bottom,
//                     delay: const Duration(seconds: 1),
//                     useTheme: false,
//                   );
//                 },
//                 child: const Text('Show Snackbar'),
//               );
//             },
//           ),
//         ),
//       ),
//     );

//     // Verify the button is present in the widget tree
//     expect(find.byKey(testButtonKey), findsOneWidget);

//     // Tap the button to show the Snackbar
//     await tester.tap(find.byKey(testButtonKey));
//     await tester.pump(); // Trigger the SnackBar animation

//     // Verify the Snackbar message is displayed
//     expect(find.text('Test Snackbar Message'), findsOneWidget);

//     // Verify the Snackbar's background color and icon
//     expect(
//       find.byWidgetPredicate((widget) =>
//           widget is SnackBar && widget.backgroundColor == Colors.blue),
//       findsOneWidget,
//     );

//     expect(find.byIcon(Icons.info), findsOneWidget);

//     // Wait for the Snackbar to disappear
//     await tester.pumpAndSettle(const Duration(seconds: 3));
//     expect(find.text('Test Snackbar Message'), findsNothing);
//   });
// }
