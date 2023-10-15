import 'dart:async';

import 'package:flame_game/game_elements/ball.dart';
import 'package:flame_game/game_elements/player.dart';
import 'package:flame_game/game_pages/cover_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //ball moment variables
  double ballX =0;
  double ballY =0;

  // player variables
  double playerX = 0;
  double playerWidth = 0.3; // out of 2

  // game settings 
  bool hasGameStarted = false;
  // Start Game
  void startGame(){
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) { 
      setState(() {
        ballY -= 0.01;
      });
    });
  }

  // Move Player Left
  void moveLeft(){
    setState(() {
      if(!(playerX -0.2 <= -1)){
        playerX -= 0.2;
      }
    });
  }

  // Move Player Right
  void moveRight(){
    setState(() {
      if(!(playerX +0.2 >= 1)){
        playerX += 0.2;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event){
        if(event.isKeyPressed(LogicalKeyboardKey.arrowLeft)){
          moveLeft();
        }
        else if(event.isKeyPressed(LogicalKeyboardKey.arrowRight)){
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Stack(
              children: [
                //tap to play 
                CoverScreen(hasGameStarted: hasGameStarted),            
                //ball
                MyBall(
                  ballX: ballX,
                  ballY: ballY,
                ),
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ) 
              ],
            ),
          ),
        ),
      ),
    );
  }
}