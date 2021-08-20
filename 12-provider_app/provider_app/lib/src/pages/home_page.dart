import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:provider_app/src/widgets/super_text.dart';
import 'package:provider_app/src/widgets/super_floatingaction.dart';
import 'package:provider_app/src/providers/heroesinfo.dart';
import 'package:provider_app/src/providers/villanosinfo.dart';

class HomePage extends StatelessWidget {
  final route = 'home';

  @override
  Widget build(BuildContext context) {
    final heroesInfo    = Provider.of<HeroesInfo>(context);
    final villanosInfo  = Provider.of<VillanosInfo>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(heroesInfo.heroe + ' | ' + villanosInfo.villano),
      ),
      body: Center(child: SuperText()),
      floatingActionButton: SuperFloatingAction(),
    );
  }
}