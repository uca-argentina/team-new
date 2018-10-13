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
MatchTest >> testAPlayerSkipMoreThanOneLapInASingleThrow [
| fabio match dices board players |
	board := Board with: 10.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: fabio.
	dices := Array
		with: (Dice deterministicWith: 13 throwing: #(13))
		with: (Dice deterministicWith: 12 throwing: #(10)).
	match := Match
		playedBy: players
		throwing: dices
		during: 4
		on: board.
	match
		playedBy: fabio.
	self assert: (match positionOf: fabio) currentSpace equals: 3.
	self assert: (match positionOf: fabio) currentLap equals: 3.

]

{ #category : #tests }
MatchTest >> testAPlayerWantsToPlayButHeIsNotPartOfTheMatch [
| fabio cristian match board dices players |
	dices := Array
		with: (Dice deterministicWith: 5 throwing: #(1 5))
		with: (Dice deterministicWith: 3 throwing: #(1 3)).
	board := Board with: 10.
	fabio := Player named: 'Fabio'.
	cristian := Player named: 'Cristian'.
	players := OrderedCollection with: fabio.
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match playedBy: fabio.
	self should:[match playedBy: cristian] raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'Player ' , cristian name , ' is not playing']
]

{ #category : #tests }
MatchTest >> testAPlayerWantsToPlayWhenItIsNotHisTurn [
	| match board martin juan dices players |
	board := Board with: 20.
	martin := Player named: 'Martin'.
	juan := Player named: 'Juan'.
	players := OrderedCollection with: martin with: juan.
	dices := Array
		with: (Dice deterministicWith: 6 throwing: #(1 3 4))
		with: (Dice deterministicWith: 5 throwing: #(4 5 1)).
	match := Match
		playedBy: players
		throwing: dices
		during: 1
		on: board.
	match
		playedBy: martin;
		playedBy: juan;
		playedBy: martin;
		playedBy: juan.
	self
		should: [ match playedBy: juan ]
		raise: AssertionFailure
		withExceptionDo:
			[ :exception | self assert: exception messageText equals: 'It is not Juan turn' ]
]

{ #category : #tests }
MatchTest >> testAPlayerWantsToPlayWhenMatchIsOver [
	| fabio match board players dices |
	board := Board with: 20.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: fabio.
	dices := Array
		with: (Dice deterministicWith: 5 throwing: #(4 5 3))
		with: (Dice deterministicWith: 6 throwing: #(6 5 4)).
	match := Match
		playedBy: players
		throwing: dices
		during: 1
		on: board.
	match
		playedBy: fabio;
		playedBy: fabio.
	self
		should: [ match playedBy: fabio ]
		raise: AssertionFailure
		withExceptionDo:
			[ :exception | self assert: exception messageText equals: 'The game is over' ]
]

{ #category : #tests }
MatchTest >> testAPlayerWins [
	| match board martin juan dices players |
	board := Board with: 15.
	martin := Player named: 'Martin'.
	juan := Player named: 'Juan'.
	players := OrderedCollection with: martin with: juan.
	dices := Array
		with: (Dice deterministicWith: 6 throwing: #(6 3 3))
		with: (Dice deterministicWith: 5 throwing: #(4 3 5)).
	match := Match
		playedBy: players
		throwing: dices
		during: 1
		on: board.
	match
		playedBy: martin;
		playedBy: juan;
		playedBy: martin.
	self assert: match winner name equals: 'Martin'
]

{ #category : #tests }
MatchTest >> testAPlayerWinsInAGameWithMoreThanOneLap [
	| fabio match dices board players |
	board := Board with: 10.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: fabio.
	dices := Array
		with: (Dice deterministicWith: 5 throwing: #(4))
		with: (Dice deterministicWith: 3 throwing: #(3)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match
		playedBy: fabio;
		playedBy: fabio;
		playedBy: fabio.
	self assert: (match positionOf: fabio) currentSpace equals: 10.
	self assert: (match positionOf: fabio) currentLap equals: 2.
	self assert: match winner equals: fabio
]

{ #category : #tests }
MatchTest >> testAskingAPositionOfPlayerThatIsNotPlaying [
	| fabio cristian andres match board dices players |
	dices := Array
		with: (Dice deterministicWith: 5 throwing: #(1 5))
		with: (Dice deterministicWith: 3 throwing: #(1 3)).
	board := Board with: 10.
	fabio := Player named: 'Fabio'.
	cristian := Player named: 'Cristian'.
	andres := Player named: 'Andres'.
	players := OrderedCollection with: fabio with: cristian.
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	self assert: (match positionOf: fabio) currentSpace equals: 0.
	self assert: (match positionOf: cristian) currentSpace equals: 0.
	self should:[match positionOf: andres] raise: AssertionFailure
		withExceptionDo: [ :exception | 
			self assert: exception messageText equals: 'Player ' , andres name , ' is not playing' ]
]

{ #category : #tests }
MatchTest >> testCreatingMatchAndAllPlayersStartAtSpace0 [
	| fabio cristian match board dices players |
	dices := Array
		with: (Dice deterministicWith: 5 throwing: #(1 2))
		with: (Dice deterministicWith: 3 throwing: #(1 3)).
	board := Board with: 10.
	fabio := Player named: 'Fabio'.
	cristian := Player named: 'Cristian'.
	players := OrderedCollection with: fabio with: cristian.
	match := Match
		playedBy: players
		throwing: dices
		during: 1
		on: board.
	self assert: (match positionOf: fabio) currentSpace equals: 0.
	self assert: (match positionOf: cristian) currentSpace equals: 0
]

{ #category : #tests }
MatchTest >> testNoPlayerPlaysAndThereIsNoWinner [
	| match board mateo marcos players dices |
	board := Board with: 30.
	mateo := Player named: 'Mateo'.
	marcos := Player named: 'Marcos'.
	players := OrderedCollection with: mateo with: marcos.
	dices := Array
		with: (Dice deterministicWith: 6 throwing: #(1 2 3))
		with: (Dice deterministicWith: 10 throwing: #(1 2 3)).
	match := Match
		playedBy: players
		throwing: dices
		during: 1
		on: board.
	self
		should: [ match winner ]
		raise: AssertionFailure
		withExceptionDo:
			[ :exception | self assert: exception messageText equals: 'There is no winner' ]
]

{ #category : #tests }
MatchTest >> testPlayerDoNotExceedLastSpace [
	| match board martin juan dices players |
	board := Board with: 50.
	martin := Player named: 'Martin'.
	juan := Player named: 'Juan'.
	players := OrderedCollection with: martin with: juan.
	dices := Array
		with: (Dice deterministicWith: 6 throwing: #(5 2 1 1 4))
		with: (Dice deterministicWith: 5 throwing: #(3 4 3 2 2))
		with: (Dice deterministicWith: 5 throwing: #(4 2 5 3 3))
		with: (Dice deterministicWith: 8 throwing: #(8 4 3 4 8))
		with: (Dice deterministicWith: 2 throwing: #(1 2 1 2 1)).
	match := Match
		playedBy: players
		throwing: dices
		during: 1
		on: board.
	match
		playedBy: martin;
		playedBy: juan;
		playedBy: martin;
		playedBy: juan;
		playedBy: martin.
	self assert: (match positionOf: martin) currentSpace equals: board spaces
]

{ #category : #tests }
MatchTest >> testPlayerMovesForwardOnBoard [
	| fabio match dices board players |
	board := Board with: 20.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: fabio.
	dices := Array
		with: (Dice deterministicWith: 5 throwing: #(4))
		with: (Dice deterministicWith: 3 throwing: #(3)).
	match := Match
		playedBy: players
		throwing: dices
		during: 1
		on: board.
	match playedBy: fabio.
	self assert: (match positionOf: fabio) currentSpace equals: 7
]

{ #category : #tests }
MatchTest >> testPlayersRankings [
	| luciana micaela carolina victoria match board dices players |
	dices := Array with: (Dice deterministicWith: 5 throwing: #(1 3 5 4)) with: (Dice deterministicWith: 6 throwing: #(3 2 5 2)).
	board := Board with: 20.
	luciana := Player named: 'Luciana'.
	micaela := Player named: 'Micaela'.
	carolina := Player named: 'Carolina'.
	victoria := Player named: 'Victoria'.
	players := OrderedCollection
		with: luciana
		with: micaela
		with: carolina
		with: victoria.
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match
		playedBy: luciana;
		playedBy: micaela;
		playedBy: carolina;
		playedBy: victoria.
	self
		assert: (match rankingOf: luciana) equals: 4;
		assert: (match rankingOf: micaela) equals: 3;
		assert: (match rankingOf: carolina) equals: 1;
		assert: (match rankingOf: victoria) equals: 2
]

{ #category : #tests }
MatchTest >> testPlayersSequenceOnMatch [
	| board martin juan match players dices |
	board := Board with: 20.
	martin := Player named: 'Martin'.
	juan := Player named: 'Juan'.
	dices := Array with: (Dice deterministicWith: 6 throwing: #(1 2 3 4)).
	players := OrderedCollection with: martin with: juan.
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	self assert: match nextPlayer name equals: 'Martin'.
	match playedBy: martin.
	self assert: match nextPlayer name equals: 'Juan'.
	match playedBy: juan.
	self assert: match nextPlayer name equals: 'Martin'.
	match playedBy: martin.
	self assert: match nextPlayer name equals: 'Juan'.
	match playedBy: juan.
	self assert: match nextPlayer name equals: 'Martin'
]

{ #category : #tests }
MatchTest >> testPositionOfPlayers [
	| match board martin juan dices players |
	board := Board with: 20.
	martin := Player named: 'Martin'.
	juan := Player named: 'Juan'.
	players := OrderedCollection with: martin with: juan.
	dices := Array
		with: (Dice deterministicWith: 6 throwing: #(3 2 5))
		with: (Dice deterministicWith: 5 throwing: #(2 5 4))
		with: (Dice deterministicWith: 5 throwing: #(1 2 3))
		with: (Dice deterministicWith: 8 throwing: #(7 6 1))
		with: (Dice deterministicWith: 2 throwing: #(1 2 1)).
	match := Match
		playedBy: players
		throwing: dices
		during: 9
		on: board.
	match
		playedBy: martin;
		playedBy: juan;
		playedBy: martin;
		playedBy: juan;
		playedBy: martin;
		playedBy: juan;
		playedBy: martin;
		playedBy: juan;
		playedBy: martin;
		playedBy: juan;
		playedBy: martin.
	self
		assert: (match positionOf: juan) currentSpace equals: 16;
		assert: (match positionOf: juan) currentLap equals: 4;
		assert: (match positionOf: martin) currentSpace equals: 10;
		assert: (match positionOf: martin) currentLap equals: 5
]

{ #category : #tests }
MatchTest >> testWhenMatchIsCreatedWithOnePlayerItIsHisTurn [
	| matias match dices board players |
	dices := Array with: (Dice deterministicWith: 5 throwing: #(1 3 3)).
	board := Board with: 10.
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	match := Match
		playedBy: players
		throwing: dices
		during: board
		on: 2.
	self assert: match nextPlayer name equals: 'Matias'
]
