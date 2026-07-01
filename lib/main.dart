import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blueAccent,
            height: MediaQuery.of(context).size.height/2,
            width: double.infinity,
            child: Center(
              child: MaterialButton(
                shape: CircleBorder(),
                height: 100,
                minWidth: 100,
                color: Colors.blueAccent.shade100,
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder:(context)=>GamePage())
                  );
                },
                child: Text("START",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
          ),
          Container(
            color: Colors.redAccent,
            height: MediaQuery.of(context).size.height/2,
            width: double.infinity,
            child: Center(
              child: MaterialButton(
                color: Colors.redAccent.shade100,
                shape: CircleBorder(),
                height: 100,
                minWidth: 100,
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder:(context)=>GamePage())
                  );
                },
                child: Text("START", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GamePage extends StatefulWidget{
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  double bluecardheight = 0;
  double redcardheight = 0;
  
  String winner = '';

  int playerAscore = 0;
  int playerBscore = 0;

  bool intialized = false;
  @override
  Widget build(BuildContext context) {
    if(intialized == false){
      bluecardheight = MediaQuery.of(context).size.height/2;
      redcardheight = MediaQuery.of(context).size.height/2;

      intialized = true;
    }
    return Scaffold(
      body: Column(
        children: [
          MaterialButton(
            onPressed: (){
              setState(() {
                bluecardheight+=30;
                redcardheight-=30;
                playerBscore+=5;
              });

              double screenheight = MediaQuery.of(context).size.height;
              double winningheight = screenheight - 60;

              if(bluecardheight > winningheight){
                winner = 'blue';
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>ResultPage(winner: winner, winnerscore: playerBscore,)) 
                );
              }
            },
            padding: EdgeInsets.zero,
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              color: Colors.blueAccent,
              height: bluecardheight,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(child: Text("Player B",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),),
                  Text(playerBscore.toString(),style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: (){
              setState(() {
                bluecardheight-=30;
                redcardheight+=30;
                playerAscore+=5;
              });
              
              double screenheight = MediaQuery.of(context).size.height;
              double winningheight = screenheight - 60;

              if(redcardheight > winningheight){
                winner = 'red';
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>ResultPage(winner: winner, winnerscore: playerAscore, )) 
                );

              }
            },
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.bottomLeft,
              color: Colors.redAccent,
              height: redcardheight,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(child:Text("Player A",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
                  Text(playerAscore.toString(),style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class ResultPage extends StatelessWidget{
  final String winner;
  final int winnerscore;
  const ResultPage({super.key, required this.winner, required this.winnerscore});

  @override
  Widget build(BuildContext context) {
    String winningplayer = '';

    if(winner == "red"){
      winningplayer = 'Player A';
    }
    else{
      winningplayer = 'Player B';
    }
    return Scaffold(
      body: Container(
        color: winner == "red" ? Colors.redAccent : Colors.blueAccent,
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("The winner is", style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text(winningplayer, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Score: ",style: TextStyle(fontSize: 15),),
                Text(winnerscore.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
              ],
            ),
            SizedBox(height: 20,),
            MaterialButton(
              color: winner == "red" ? Colors.redAccent.shade100 : Colors.blueAccent.shade100,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              }, child: Text('Restart',style: TextStyle(fontSize: 15),),
            ),
          ],
        ),
      ),
    );
  }
}
