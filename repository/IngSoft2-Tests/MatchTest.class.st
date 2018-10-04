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
	#name : #MatchTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
MatchTest >> testAPlayerWantsToPlayWhenGameIsOver [
	| fabio match board players dices |
	board := Board withAmountOfSpaces: 5.
	fabio := Player withName: 'Fabio'.
	players := OrderedCollection with: fabio.
	dices := Array
		with: (Dice deterministicWithAmountOfFaces: 5)
		with: (Dice deterministicWithAmountOfFaces: 3).
	match := Match withPlayers: players withDices: dices onBoard: board.
	match
		play;
		play;
		play.
	self
		should: [ match play ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'The game is over' ]
]

{ #category : #tests }
MatchTest >> testAPlayerWins [
	| match board martin juan  dices players |
	board := Board withAmountOfSpaces: 7.
	martin := Player withName: 'Martin'.
	juan := Player withName: 'Juan'.
	players := OrderedCollection with: martin with: juan.
	dices := Array
		with: (Dice deterministicWithAmountOfFaces: 6)
		with: (Dice deterministicWithAmountOfFaces: 5).
	match := Match withPlayers: players withDices: dices onBoard: board.
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
MatchTest >> testAskingAPositionOfPlayerThatIsNotPlaying [
	| fabio cristian andres match board dices players |
	dices := Array
		with: (Dice deterministicWithAmountOfFaces: 5)
		with: (Dice deterministicWithAmountOfFaces: 3).
	board := Board withAmountOfSpaces: 10.
	fabio := Player withName: 'Fabio'.
	cristian := Player withName: 'Cristian'.
	andres := Player withName: 'Andres'.
	players := OrderedCollection with: fabio with: cristian.
	match := Match
		withPlayers:
			players
		withDices: dices
		onBoard: board.
	self assert: (match positionOf: fabio) equals: 0.
	self assert: (match positionOf: cristian) equals: 0.
	self assert: (match positionOf: andres) equals: 'Player ' , andres name , ' is not playing'
]

{ #category : #tests }
MatchTest >> testCreatingMatchAndAllPlayersStartAtSpace0 [
	| fabio cristian match board dices players |
	dices := Array
		with: (Dice deterministicWithAmountOfFaces: 5)
		with: (Dice deterministicWithAmountOfFaces: 3).
	board := Board withAmountOfSpaces: 10.
	fabio := Player withName: 'Fabio'.
	cristian := Player withName: 'Cristian'.
	players := OrderedCollection with: fabio with: cristian.
	match := Match
		withPlayers:
			players
		withDices: dices
		onBoard: board.
	self assert: (match positionOf: fabio) equals: 0.
	self assert: (match positionOf: cristian) equals: 0
]

{ #category : #tests }
MatchTest >> testNoPlayerPlaysAndThereIsNoWinner [
	| match board mateo marcos players dices |
	board := Board withAmountOfSpaces: 30.
	mateo := Player withName: 'Mateo'.
	marcos := Player withName: 'Marcos'.
	players := OrderedCollection with: mateo with: marcos.
	dices := Array
		with: (Dice deterministicWithAmountOfFaces: 6)
		with: (Dice deterministicWithAmountOfFaces: 10).
	match := Match withPlayers: players withDices: dices onBoard: board.
	self assert: match winner equals: 'None'
]

{ #category : #tests }
MatchTest >> testPlayerDoNotExceedLastSpace [
	| match board martin juan dices players |
	board := Board withAmountOfSpaces: 8.
	martin := Player withName: 'Martin'.
	juan := Player withName: 'Juan'.
	players := OrderedCollection with: martin with: juan.
	dices := Array
		with: (Dice deterministicWithAmountOfFaces: 6)
		with: (Dice deterministicWithAmountOfFaces: 5)
		with: (Dice deterministicWithAmountOfFaces: 5)
		with: (Dice deterministicWithAmountOfFaces: 8)
		with: (Dice deterministicWithAmountOfFaces: 2).
	match := Match withPlayers: players withDices: dices onBoard: board.
	match
		play;
		play;
		play.
	self assert: (match positionOf: martin) equals: board spaces
]

{ #category : #tests }
MatchTest >> testPlayerMovesForwardOnGameBoard [
	| fabio match dices board players |
	board := Board withAmountOfSpaces: 10.
	fabio := Player withName: 'Fabio'.
	players := OrderedCollection with: fabio.
	dices := Array
		with: (Dice deterministicWithAmountOfFaces: 5)
		with: (Dice deterministicWithAmountOfFaces: 3).
	match := Match withPlayers: players withDices: dices onBoard: board.
	match play.
	self assert: (match positionOf: fabio) equals: 2
]

{ #category : #tests }
MatchTest >> testPlayersSequenceOnMatch [
	| board martin juan match players dices |
	board := Board withAmountOfSpaces: 20.
	martin := Player withName: 'Martin'.
	juan := Player withName: 'Juan'.
	dices := Array with: (Dice deterministicWithAmountOfFaces: 6).
	players := OrderedCollection with: martin with: juan.
	match := Match withPlayers: players withDices: dices onBoard: board.
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
MatchTest >> testWhenMatchIsCreatedWithOnePlayerItIsHisTurn [
	| matias match dices board players |
	dices := Array with: (Dice deterministicWithAmountOfFaces: 5).
	board := Board withAmountOfSpaces: 10.
	matias := Player withName: 'Matias'.
	players := OrderedCollection with: matias.
	match := Match withPlayers: players withDices: dices onBoard: board.
	self assert: match nextPlayer name equals: 'Matias'
]
