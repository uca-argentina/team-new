"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testAPlayerWantsToPlayWhenGameIsOver [
	| player match dice1 dice2 board |
	dice1 := Dice deterministicWithAmountOfFaces: 5.
	dice2 := Dice deterministicWithAmountOfFaces: 3.
	board := Board withAmountOfSpaces: 5.
	player := Player withName: 'Fabio'.
	match := Match
		withPlayers: {player}
		withDices:
			{dice1.
			dice2}
		onBoard: board.
	match
		play;
		play;
		play.
	self should:[ match play] raise: AssertionFailure withExceptionDo: [ :exception | self assert: exception messageText equals: 'The game is over' ]
]

{ #category : #tests }
GameTest >> testCreatingMatchAndAllPlayersStartAtSpace0 [
	| player1 player2 match dice1 dice2 board |
	dice1 := Dice deterministicWithAmountOfFaces: 5.
	dice2 := Dice deterministicWithAmountOfFaces: 3.
	board := Board withAmountOfSpaces: 10.
	player1 := Player withName: 'Fabio'.
	player2 := Player withName: 'Cristian'.
	match := Match withPlayers:
			{player1.player2}
		withDices:
			{dice1.dice2}
		onBoard: board.
	self assert: (match positionOf: player1 )equals:0.
	self assert: (match positionOf: player2 )equals:0.
]

{ #category : #tests }
GameTest >> testCreatingMatchAndAskAPositionOfPlayerThatIsNotPlaying [
	| player1 player2 player3 match dice1 dice2 board |
	dice1 := Dice deterministicWithAmountOfFaces: 5.
	dice2 := Dice deterministicWithAmountOfFaces: 3.
	board := Board withAmountOfSpaces: 10.
	player1 := Player withName: 'Fabio'.
	player2 := Player withName: 'Cristian'.
	player3:= Player withName: 'Andres'.
	match := Match withPlayers: {player1 . player2} withDices: {dice1.dice2} onBoard: board.
	self assert: (match positionOf: player1 )equals:0.
	self assert: (match positionOf: player2 )equals:0.
	self assert: (match positionOf: player3 ) equals:'Player ',player3 name,' is not playing'.
]

{ #category : #tests }
GameTest >> testCreatingMatchWithPlayerMatiasAndFirstTurnIsMatias [
	| player match dice board |
	dice := Dice deterministicWithAmountOfFaces: 5.
	board := Board withAmountOfSpaces: 10.
	player := Player withName: 'Matias'.
	match := Match withPlayers:
			{player}
		withDices:
			{dice}
		onBoard: board.
	self assert: match nextPlayer name equals:'Matias'.
]

{ #category : #tests }
GameTest >> testMatchWith2Players2DeterministicDicesOf6FacesAnd5FacesANdABoardOf7Spaces [
	| match board player1 player2 dice1 dice2 |
	board := Board withAmountOfSpaces: 7.
	player1 := Player withName: 'Martin'.
	player2 := Player withName: 'Juan'.
	dice1 := Dice deterministicWithAmountOfFaces: 6.
	dice2 := Dice deterministicWithAmountOfFaces: 5.
	match := Match withPlayers: {player1.player2} withDices: {dice1.dice2} onBoard: board.
	match play;
	play;
	play;
	play;
	play;
	play;
	play.
	self assert: match winner name equals: 'Martin'.

]

{ #category : #tests }
GameTest >> testNonePlayerPlaysAndThereIsNoWinner [
	| match board player1 player2 player3 player4 dice1 dice2 dice3 |
	board := Board withAmountOfSpaces: 30.
	player1 := Player withName: 'Mateo'.
	player2 := Player withName: 'Marcos'.
	player3 := Player withName: 'Lucas'.
	player4 := Player withName: 'Juan'.
	dice1 := Dice deterministicWithAmountOfFaces: 6.
	dice2 := Dice deterministicWithAmountOfFaces: 5.
	dice3 := Dice deterministicWithAmountOfFaces: 10.
	match := Match withPlayers:{player1.player2.player3.player4}withDices:{dice1.dice2.dice3}onBoard: board.
	self assert: (match winner) equals:'None'.
]

{ #category : #tests }
GameTest >> testPlayer1RollPlayer2RollAndPlayer1RollAgainPlayer2RollAgain [
	| board player1 player2 dice match |
	board := Board withAmountOfSpaces: 20.
	player1 := Player withName: 'Martin'.
	player2 := Player withName: 'Juan'.
	dice := Dice deterministicWithAmountOfFaces: 6.
	match := Match withPlayers: { player1 . player2 } withDices: { dice } onBoard: board. 
	self assert: match nextPlayer name equals: 'Martin'.
	match play.
	self assert: match nextPlayer name equals: 'Juan'.
	match play.
	self assert: match nextPlayer name equals: 'Martin'.
	match play.
	self assert: match nextPlayer name equals: 'Juan'.
	match play.
	self assert: match nextPlayer name equals: 'Martin'
]

{ #category : #tests }
GameTest >> testPlayerMovesForwardOnGameBoard [
	| player match dice1 dice2 board |
	dice1 := Dice deterministicWithAmountOfFaces: 5.
	dice2 := Dice deterministicWithAmountOfFaces: 3.
	board := Board withAmountOfSpaces: 10.
	player := Player withName: 'Fabio'.
	match := Match withPlayers:
			{player}
		withDices:
			{dice1.dice2}
		onBoard: board.
	match play.
	self assert: (match positionOf: player ) equals:2.

]

{ #category : #tests }
GameTest >> testPlayerRolls5DicesAtOnceAndMovesToSpaceNumber5 [
	| player dice1 dice2 dice3 dice4 dice5 board  match |
	player := Player withName: 'Nico'.
	dice1:= Dice deterministicWithAmountOfFaces: 5.
	dice2:= Dice deterministicWithAmountOfFaces: 4.
	dice3:= Dice deterministicWithAmountOfFaces: 8.
	dice4:= Dice deterministicWithAmountOfFaces: 2.
	dice5:= Dice deterministicWithAmountOfFaces: 3.
	board := Board withAmountOfSpaces: 20.
	match:= Match withPlayers: { player } withDices: {dice1.dice2.dice3.dice4.dice5} onBoard: board.
	match play.
	self assert: (match positionOf: player )equals: 5.
]

{ #category : #tests }
GameTest >> testPlayerThrowsDicesAndResultIndicatesMovingFurtherThanTheAmountOfSpacesOfBoardButPlayerMovesToTheLastSpace [
| match board player1 player2 dice1 dice2 dice3 dice4 dice5|
	board := Board withAmountOfSpaces: 8.
	player1 := Player withName: 'Martin'.
	player2 := Player withName: 'Juan'.
	dice1 := Dice deterministicWithAmountOfFaces: 6.
	dice2 := Dice deterministicWithAmountOfFaces: 5.
	dice3 := Dice deterministicWithAmountOfFaces: 5.
	dice4 := Dice deterministicWithAmountOfFaces: 8.
	dice5 := Dice deterministicWithAmountOfFaces: 2.
	match := Match withPlayers: {player1.player2} withDices: {dice1.dice2.dice3.dice4.dice5} onBoard: board.
	match play;
	play;
	play.
	self assert: (match positionOf: player1  )equals: board spaces.
]
