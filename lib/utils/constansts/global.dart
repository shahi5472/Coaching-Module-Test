import 'dart:io';

import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

bool get isAndroid => Platform.isAndroid;

bool get isIOS => Platform.isIOS;

/// Default Scroll Physics

ScrollPhysics get scrollPhysics => const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics());
