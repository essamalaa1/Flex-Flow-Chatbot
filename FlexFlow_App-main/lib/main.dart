import 'helper/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_flow_app/Themes/themes_provider.dart';
import 'package:flex_flow_app/Cuibts/Message%20Cubit/message_cubit.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        BlocProvider<MessageCubit>(
          create: (context) =>
              MessageCubit.getInstance(), // Use the singleton instance
        ),
      ],
      child: FlexFlow(
        appRouter: AppRouter(),
      ),
    ),
  );
}

class FlexFlow extends StatelessWidget {
  final AppRouter appRouter;
  const FlexFlow({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeData = themeProvider.getThemeData();

    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
