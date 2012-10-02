<h1>Welcome to Robodrome!</h1>
---------------------
This little dungeon-crawler was created during the last two weeks of App Academy as a personal project. I had a lot of fun creating it, and I hope you enjoy playing/looking at it!


What I Used
-----------
* CoreData to store character stats and level progress
* AVFoundation for sound effects
* QuartzCore for animations
* Parse for a global scoreboard


How to Create Your Own Level
----------------------------
The game uses a grid system for locations and movement. Right now, the level is a 6x6 grid surrounded by walls. If you want to change the level around, go to the createGrid method inside of Level.m. Each square on the grid is a new square object with item, enemy, X and Y properties. All you have to do is create new square objects with X and Y coordinates, add items if desired, and add the new square to the squareSet. Now, when you start a new game, you can explore the new map you created!


Cool Stuff to Implement
-----------------------
* Random map generation or multiple levels
* Different movement control system rather than traditional D-pad
* Animations from the right arm