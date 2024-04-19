import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_weather/FavouriteNews/cubit/favourite_news_cubit.dart';
import 'package:news_weather/news/cubit/news_cubit.dart';
import 'package:news_weather/news/view/news_view.dart';
import 'package:news_weather/signUp/cubit/sign_up_cubit.dart';
import 'package:news_weather/signUp/sign_up_start.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}


class TestWidget extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        body: BlocProvider(
            create: (context) => NewsCubit(),
            child: NewsView(cityname: "Bangalore",),
        ),
        ),
        navigatorObservers: [MockNavigatorObserver()],
    );
    }
}

// Test initial state
testWidgets('Initial state is MyInitial', tester) async {
    await tester.pumpWidget(TestWidget());
    expect(FavouriteNewsCubit().of(tester.element).state, AuthState());
}
// Test state change after event
testWidgets('EmitMyEvent changes state to MyLoaded', tester) async {
    await tester.pumpWidget(TestWidget());
    SignUpCubit.of(tester.element).emitMyEvent();
    expect(MyCubit.of(tester.element).state, MyLoaded());
}
// Test navigation to new screen
testWidgets('EmitNavigateEvent navigates to new screen', tester) async {
    await tester.pumpWidget(TestWidget());
    MockNavigatorObserver mockObserver = MockNavigatorObserver();
    tester.binding.removeObserver(mockObserver);
    tester.binding.addObserver(mockObserver);

    MyCubit.of(tester.element).emitNavigateEvent();
    await tester.pumpAndSettle();

    verify(mockObserver.didPush(any, any));
}