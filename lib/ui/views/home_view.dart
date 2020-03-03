import 'package:flutter/material.dart';
import 'package:realtimestatsmonitor/enums/view_state.dart';
import 'package:realtimestatsmonitor/scoped_models/home_view_model.dart';
import 'package:realtimestatsmonitor/ui/shared/app_colors.dart';
import 'package:realtimestatsmonitor/ui/shared/app_colors.dart';
import 'package:realtimestatsmonitor/ui/shared/ui_reducers.dart';
import 'package:realtimestatsmonitor/ui/widgets/indicator_button.dart';
import 'package:realtimestatsmonitor/ui/widgets/stats_counter.dart';
import 'package:realtimestatsmonitor/ui/widgets/watcher_toolbar.dart';

import 'base_view.dart';
import 'feedback_view.dart';


class HomeView extends StatelessWidget {
  static const BoxDecoration topLineBorderDecoration = BoxDecoration(

      border:Border(
           top: BorderSide(
             color: Colors.grey  ,
               style: BorderStyle.solid, width: 5.0
           ),
      ));

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        builder: (context, child, model) => Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: _getBody(model, context)));
  }

  Widget _getBody(HomeViewModel model, BuildContext context) {
    switch (model.state) {
      case ViewState.Busy:
      case ViewState.Idle:
        return Center(child: CircularProgressIndicator());
      default:
        return _getStatsUi(model, context);
    }
  }

  Widget _getStatsUi(HomeViewModel model, BuildContext context) {
    return Column(children: [
       WatcherToolbar(title: 'SKELETON-WATCHER'),
        _getHeightContainer(
          context: context,
          height: screenHeight(context, dividedBy: 2, decreasedBy: toolbarHeight),
          child: StatsCounter(
            size: screenHeight(context, dividedBy: 2, decreasedBy: toolbarHeight) - 60, // 60 margins
            count: model.appStats.errorCount,
            title: 'Errors',
            titleColor: Colors.red,
          ),
        ),
         _getHeightContainer(
          context: context,
          height:screenHeight(context, dividedBy: 3, decreasedBy: toolbarHeight),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              StatsCounter(
                size: screenHeight(context, dividedBy: 3, decreasedBy: toolbarHeight) - 60,
                count: model.appStats.userCount,
                title: 'Users',
              ),
              StatsCounter(
                size: screenHeight(context,dividedBy: 3, decreasedBy: toolbarHeight) - 60,
                count: model.appStats.appCount,
                title: 'Apps Created',
              )
          ])
         ),
         _getHeightContainer(
          height:screenHeight(context, dividedBy: 6, decreasedBy: toolbarHeight),
          child: IndicatorButton(
            title: 'FEEDBACK',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedbackView()));
            }
          ))
    ]);
  }

  Widget _getHeightContainer(
      {double height,
      BuildContext context,
      Widget child,
      bool hasTopStroke = false}) {
    return Container(
        height: height,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: hasTopStroke? topLineBorderDecoration : null,
        child: child);
  }
}
