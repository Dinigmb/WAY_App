import 'package:flow_app/application/flow/flow_bloc.dart';
import 'package:flow_app/common/flow_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeet/yeet.dart';

import 'bottom_navbar.dart';
import 'dart:ui';

import 'package:flow_app/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeet/yeet.dart';
import 'package:google_fonts/google_fonts.dart';

import 'demo_page.dart';
import 'flow_scaffold.dart';
import 'home_page.dart';

const myBlue = Color(0xFF3D7EAA);
const myYellow = Color(0xFFFFE47A);
const myRed = Color(0xFFEE2233);

final counterProvider = StateProvider((_) => 0);
final doubleProvider = Provider((ref) => ref.watch(counterProvider).state * 2);
final tripleProvider = Provider<int>((ref) {
  final counter = ref.watch(counterProvider).state;
  final doubleCounter = ref.watch(doubleProvider);
  return counter + doubleCounter;
});

class DemoPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final flowState = useProvider(flowBlocProvider.state);
    return MaterialApp(
      title: 'Flow',
      home: FlowScaffold(
        child: FlowBackground(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(
                          'Your Flow',
                          style: GoogleFonts.roboto(
                              fontSize: 40.0, color: Colors.brown[50]),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.bookmark_border_rounded,
                          ),
                          color: Colors.brown[50],
                          iconSize: 50.0,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    ...flowState.selectedAsanas
                        .map((e) => Card(
                              color: Colors.brown[50],
                              child: Row(
                                children: [
                                  AsanaWidget(e),
                                  Center(
                                    child: Text(
                                      e.name,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink[900],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                    SizedBox(
                      height: 80.0,
                    )
                  ],
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}

class GlassBar extends AppBar {
  final String text;
  GlassBar(this.text)
      : super(
          title: Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(color: Colors.white.withOpacity(0.001)),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: GoogleFonts.kaushanScript(fontSize: 36),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
}

class Asanastyps extends StatelessWidget {
  final String name;

  const Asanastyps(this.name);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              name,
              style:
                  GoogleFonts.montserrat(fontSize: 25.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class Asanasimages extends StatelessWidget {
  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              height: 150.0,
              width: 410.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            SizedBox(
              width: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
