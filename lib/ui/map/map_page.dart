import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowmanlabs_challenge/bloc/map_bloc.dart';
import 'package:snowmanlabs_challenge/common_widgets/base_body.dart';
import 'package:snowmanlabs_challenge/ui/map/map_body.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
  
  static show(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapPage()));
  }
}

class _MapPageState extends State<MapPage> {
  MapBLoC _mapBLoC;

  @override
  void dispose() {
    _mapBLoC?.dispose();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    _mapBLoC ??= MapBLoC();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return BaseBody(child: Provider(create: (_)=>_mapBLoC ,child: MapBody()));
  }
}
