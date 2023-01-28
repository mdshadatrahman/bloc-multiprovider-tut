import 'package:bloc_multiprovider_tut/bloc/app_bloc.dart';
import 'package:bloc_multiprovider_tut/bloc/app_state.dart';
import 'package:bloc_multiprovider_tut/bloc/bloc_events.dart';
import 'package:flutter/material.dart';
import 'package:bloc_multiprovider_tut/extensions/streme/starts_with.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocView<T extends AppBloc> extends StatelessWidget {
  const AppBlocView({super.key});

  void startUpdatingBloc(BuildContext context) {
    Stream.periodic(const Duration(seconds: 10), (_) => const LoadNextUrlEvent()).startWith(const LoadNextUrlEvent()).forEach((event) {
      context.read<T>().add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return Expanded(
      child: BlocBuilder<T, AppState>(
        builder: (context, appState) {
          //we have an error
          if (appState.error != null) {
            return const Text('An error occured. Please try again in a moment.');
          } else if (appState.data != null) {
            //we have data
            return Image.memory(
              appState.data!,
              fit: BoxFit.fitHeight,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
