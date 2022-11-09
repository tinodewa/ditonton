// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/presentation/pages/tvseries/top_rated_tvseries_page.dart';
import 'package:core/presentation/provider/tvseries/top_rated_tvseries_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_tvseries_page_test.mocks.dart';

@GenerateMocks([TopRatedTvseriesNotifier])
void main() {
  late MockTopRatedTvseriesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTvseriesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvseriesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvseriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvseries).thenReturn(<TvSeries>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvseriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvseriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
