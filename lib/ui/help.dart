import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:folding_cell/folding_cell.dart';

// Start HelpPage
class HelpPage extends StatefulWidget{
  @override
  _HelpPageState createState()=> _HelpPageState();
}
// End HelpPage

// Start _HelpPageState
class _HelpPageState extends State<HelpPage>{
  final _foldingCellKey1 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey2 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey3 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey4 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey5 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey6 = GlobalKey<SimpleFoldingCellState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:PageTheme().pageTheme('Help', context, null,
          ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    // How Can I Find New Shows to Watch ?
                    SimpleFoldingCell(
                        key: _foldingCellKey1,
                        frontWidget: _buildFrontWidget(_foldingCellKey1, "How Can I Find \nNew Shows to Watch ?"),
                        innerTopWidget: _buildInnerTopWidget("1. Open the app.\n\n2. Locate the 'TV' Icon in the bottom bar \n     of you screen. \n\n3. Here you can view your trending shows"),
                        innerBottomWidget: _buildInnerBottomWidget(_foldingCellKey1),
                        cellSize: Size(MediaQuery.of(context).size.width, 125),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 35.0, bottom: 10.0),
                        animationDuration: Duration(milliseconds: 300),
                        borderRadius: 10,
                        onOpen: () => print('cell 1 opened'),
                        onClose: () => print('cell 1 closed')),

                    // How Do I Follow a Show ?
                    SimpleFoldingCell(
                        key: _foldingCellKey2,
                        frontWidget: _buildFrontWidget(_foldingCellKey2, "How Do I Follow \na Show ?"),
                        innerTopWidget: _buildInnerTopWidget("1. Tap the title of the show. \n\n2. There will be a blue botton at the bottom \n    of the page that says 'Add to Watchlist. \n\n3.Tap the button to follow thw show.'"),
                        innerBottomWidget: _buildInnerBottomWidget(_foldingCellKey2),
                        cellSize: Size(MediaQuery.of(context).size.width, 125),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
                        animationDuration: Duration(milliseconds: 300),
                        borderRadius: 10,
                        onOpen: () => print('cell 2 opened'),
                        onClose: () => print('cell 2 closed')),

                    // How Do I Unfollow a Show ?
                    SimpleFoldingCell(
                        key: _foldingCellKey3,
                        frontWidget: _buildFrontWidget(_foldingCellKey3, "How Do I Unfollow \na Show ?"),
                        innerTopWidget: _buildInnerTopWidget("1. Locate the 'Watchlist' page icon in the \nbottom bar. \n\n2. Tap the '...' icon in the upper right corner \nof the show's image. \n\n3. Tap 'Remove'."),
                        innerBottomWidget: _buildInnerBottomWidget(_foldingCellKey3),
                        cellSize: Size(MediaQuery.of(context).size.width, 125),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
                        animationDuration: Duration(milliseconds: 300),
                        borderRadius: 10,
                        onOpen: () => print('cell 3 opened'),
                        onClose: () => print('cell 3 closed')),

                    // How Do I Set my Reminder ?
                    SimpleFoldingCell(
                        key: _foldingCellKey4,
                        frontWidget: _buildFrontWidget(_foldingCellKey4, "How Do I Set \nmy Reminder ?"),
                        innerTopWidget: _buildInnerTopWidget("1. Locate the 'Watchlist' page icon in the \nbottom bar. \n\n2. Tap the '...' icon in the upper right corner \nof the show's image. \n\n3. Tap 'Add Reminder'."),
                        innerBottomWidget: _buildInnerBottomWidget(_foldingCellKey4),
                        cellSize: Size(MediaQuery.of(context).size.width, 125),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
                        animationDuration: Duration(milliseconds: 300),
                        borderRadius: 10,
                        onOpen: () => print('cell 4 opened'),
                        onClose: () => print('cell 4 closed')),

                    // How Do I Remove my Reminder ?
                    SimpleFoldingCell(
                        key: _foldingCellKey5,
                        frontWidget: _buildFrontWidget(_foldingCellKey5, "How Do I Remove \nmy Reminder ?"),
                        innerTopWidget: _buildInnerTopWidget("1. Locate the 'Reminder' page icon in the \nbottom bar. \n\n2. Tap the title of the show. \n\n3. Tap 'Delete' button."),
                        innerBottomWidget: _buildInnerBottomWidget(_foldingCellKey5),
                        cellSize: Size(MediaQuery.of(context).size.width, 125),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
                        animationDuration: Duration(milliseconds: 300),
                        borderRadius: 10,
                        onOpen: () => print('cell 5  opened'),
                        onClose: () => print('cell 5 closed')),

                    // How Do I Edit my Reminder ?
                    SimpleFoldingCell(
                        key: _foldingCellKey6,
                        frontWidget: _buildFrontWidget(_foldingCellKey6, "How Do I Edit \nmy Reminder ?"),
                        innerTopWidget: _buildInnerTopWidget("1. Locate the 'Reminder' page icon in the \nbottom bar. \n\n2. Tap the title of the show. \n\n3. Tap 'Edit' button."),
                        innerBottomWidget: _buildInnerBottomWidget(_foldingCellKey6),
                        cellSize: Size(MediaQuery.of(context).size.width, 125),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
                        animationDuration: Duration(milliseconds: 300),
                        borderRadius: 10,
                        onOpen: () => print('cell 5  opened'),
                        onClose: () => print('cell 5 closed')),
                  ],
                ),
              )
            ],

          ),
        )
    );
  }

  Widget _buildFrontWidget(GlobalKey<SimpleFoldingCellState> key, String title) {
    return Container(
        color: Color(0xFFB2EBF2),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title,textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF2e282a),
                    fontFamily: 'OpenSans',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800)),
            FlatButton(
              onPressed: () => key?.currentState?.toggleFold(),
              child: Text(
                "Read More",
              ),
              textColor: Colors.white,
              color: Color(0xFFB2EBF2),
              splashColor: Colors.white.withOpacity(0.5),
            )
          ],
        )
    );
  }

  Widget _buildInnerTopWidget(String title) {
    return Container(
        color: Color(0xFF4DD0E1),
        alignment: Alignment.center,
        child: Text(title,
            style: TextStyle(
                color: Color(0xFF2e282a),
                fontFamily: 'OpenSans',
                fontSize: 10.0,
                fontWeight: FontWeight.w800)));
  }

  Widget _buildInnerBottomWidget(GlobalKey<SimpleFoldingCellState> key) {
    return Container(
      color: Color(0xFFE0F7FA),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: FlatButton(
          onPressed: () => key?.currentState?.toggleFold(),
          child: Text(
            "Close",
          ),
          textColor: Colors.black,
          color: Color(0xFFE0F7FA),
          splashColor: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }


}

// Start _HelpPageState