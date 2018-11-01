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
MatchTest >> testAPlayerSkipsMoreThanOneLapInASingleThrow [
	| fabio match dices board players |
	board := Board deterministicWithSpaces: 5 andEffectsGeneratedFrom: {NoEffect new}.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: fabio.
	dices := OrderedCollection with: (Dice deterministicWithSpaces: 13 throwing: #(13)).
	match := Match
		playedBy: players
		throwing: dices
		during: 4
		on: board.
	match playedBy: fabio.
	self assert: (match positionOf: fabio) currentSpace equals: 4.
	self assert: (match positionOf: fabio) currentLap equals: 2
]

{ #category : #tests }
MatchTest >> testAPlayerWantsToPlayButHeIsNotPartOfTheMatch [
	| fabio cristian match board dices players |
	dices := OrderedCollection with: (Dice deterministicWithSpaces: 5 throwing: #(5)).
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			AtomicBombEffect new}.
	fabio := Player named: 'Fabio'.
	cristian := Player named: 'Cristian'.
	players := OrderedCollection with: fabio.
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match playedBy: fabio.
	self
		should: [ match playedBy: cristian ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'Player ' , cristian name , ' is not playing' ]
]

{ #category : #tests }
MatchTest >> testAPlayerWantsToPlayWhenItIsNotHisTurn [
	| match board martin juan dices players |
	board := Board
		deterministicWithSpaces: 20
		andEffectsGeneratedFrom:
			{NoEffect new.
			AtomicBombEffect new}.
	martin := Player named: 'Martin'.
	juan := Player named: 'Juan'.
	players := OrderedCollection with: martin with: juan.
	dices := OrderedCollection with: (Dice deterministicWithSpaces: 6 throwing: #(1 3)).
	match := Match
		playedBy: players
		throwing: dices
		during: 1
		on: board.
	match playedBy: martin.
	self assert: match nextPlayer equals: juan.
	match playedBy: juan.
	self
		should: [ match playedBy: juan ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'It is not Juan turn' ]
]

{ #category : #tests }
MatchTest >> testAPlayerWantsToPlayWhenMatchIsOver [
	| fabio match board players dices |
	board := Board deterministicWithSpaces: 8 andEffectsGeneratedFrom: {NoEffect new}.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: fabio.
	dices := OrderedCollection with: (Dice deterministicWithSpaces: 5 throwing: #(4 5)).
	match := Match
		playedBy: players
		throwing: dices
		during: 1
		on: board.
	match playedBy: fabio.
	self
		assert: (match positionOf: fabio) currentSpace equals: 5;
		assert: (match positionOf: fabio) currentLap equals: 0.
	match	playedBy: fabio.
	self
		should: [ match playedBy: fabio ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'The match is over' ].
]

{ #category : #tests }
MatchTest >> testAPlayerWins [
	| match board martin dices players |
	board := Board deterministicWithSpaces: 10 andEffectsGeneratedFrom: {NoEffect new}.
	martin := Player named: 'Martin'.
	players := OrderedCollection with: martin.
	dices := OrderedCollection with: (Dice deterministicWithSpaces: 6 throwing: #(6 4)).
	match := Match
		playedBy: players
		throwing: dices
		during: 1
		on: board.
	match playedBy: martin.
	self
		assert: (match positionOf: martin) currentSpace equals: 7;
		assert: (match positionOf: martin) currentLap equals: 0.
	match	playedBy: martin.
	match.
	self assert: match winner name equals: 'Martin'
]

{ #category : #tests }
MatchTest >> testAPlayerWinsInAGameWithMoreThanOneLap [
	| fabio match dices board players |
	board := Board deterministicWithSpaces: 10 andEffectsGeneratedFrom: {NoEffect new}.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: fabio.
	dices := OrderedCollection with: (Dice deterministicWithSpaces: 5 throwing: #(4 2 5)) with: (Dice deterministicWithSpaces: 6 throwing: #(3 6 1)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match playedBy: fabio.
	self
		assert: (match positionOf: fabio) currentSpace equals: 8;
		assert: (match positionOf: fabio) currentLap equals: 0.
	match 	playedBy: fabio.
	self
		assert: (match positionOf: fabio) currentSpace equals: 6;
		assert: (match positionOf: fabio) currentLap equals: 1.
	match	playedBy: fabio.
	self
		assert: (match positionOf: fabio) currentSpace equals: 2;
		assert: (match positionOf: fabio) currentLap equals: 2;
		assert: match winner equals: fabio
]

{ #category : #tests }
MatchTest >> testAllEffectsInOneMatch [
	| fabio cristian juan match board dices players |
	dices := OrderedCollection
		with: (Dice deterministicWithSpaces: 5 throwing: #(1 5 2 3 1))
		with: (Dice deterministicWithSpaces: 3 throwing: #(1 3 2 2 2)).
	board := Board
		deterministicWithSpaces: 20
		andEffectsGeneratedFrom:
			{NoEffect new.
			AtomicBombEffect new.
			(MoonWalkEffect moving: 2).
			SpeedUpEffect new.
			WormHoleEffect new}.
	fabio := Player named: 'Fabio'.
	cristian := Player named: 'Cristian'.
	juan := Player named: 'Juan'.
	players := OrderedCollection with: fabio with: cristian with: juan.
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match playedBy: fabio.
	self assert: (match positionOf: fabio) currentSpace equals: 7.
	match playedBy: cristian.
	self assert: (match positionOf: cristian) currentSpace equals: 5.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 5.
	match playedBy: fabio.
	self
		assert: (match positionOf: fabio) currentSpace equals: 12;
		assert: (match positionOf: cristian) currentSpace equals: 3;
		assert: (match positionOf: juan) currentSpace equals: 3.
	match playedBy: cristian.
	self
		assert: (match positionOf: fabio) currentSpace equals: 1;
		assert: (match positionOf: cristian) currentSpace equals: 1;
		assert: (match positionOf: juan) currentSpace equals: 1
]

{ #category : #tests }
MatchTest >> testAskingAPositionOfPlayerThatIsNotPlaying [
	| fabio andres match board dices players |
	dices := OrderedCollection with: (Dice deterministicWithSpaces: 5 throwing: #(5)).
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			AtomicBombEffect new}.
	fabio := Player named: 'Fabio'.
	andres := Player named: 'Andres'.
	players := OrderedCollection with: fabio.
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	self assert: (match positionOf: fabio) currentSpace equals: 1.
	self
		should: [ match positionOf: andres ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'Player ' , andres name , ' is not playing' ]
]

{ #category : #tests }
MatchTest >> testCreatingMatchAndAllPlayersStartAtSpace1 [
	| fabio cristian match board dices players |
	dices := OrderedCollection with: (Dice deterministicWithSpaces: 5 throwing: #(1)).
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			AtomicBombEffect new}.
	fabio := Player named: 'Fabio'.
	cristian := Player named: 'Cristian'.
	players := OrderedCollection with: fabio with: cristian.
	match := Match
		playedBy: players
		throwing: dices
		during: 1
		on: board.
	self assert: (match positionOf: fabio) currentSpace equals: 1.
	self assert: (match positionOf: cristian) currentSpace equals: 1
]

{ #category : #tests }
MatchTest >> testNoPlayerPlaysAndThereIsNoWinner [
	| match board mateo marcos players dices |
	board := Board
		deterministicWithSpaces: 30
		andEffectsGeneratedFrom:
			{NoEffect new.
			AtomicBombEffect new}.
	mateo := Player named: 'Mateo'.
	marcos := Player named: 'Marcos'.
	players := OrderedCollection with: mateo with: marcos.
	dices := OrderedCollection with: (Dice deterministicWithSpaces: 6 throwing: #(1)).
	match := Match
		playedBy: players
		throwing: dices
		during: 1
		on: board.
	self
		assert: (match positionOf: mateo) currentSpace equals: 1;
		assert: (match positionOf: mateo) currentLap equals: 0;
		assert: (match positionOf: marcos) currentSpace equals: 1;
		assert: (match positionOf: marcos) currentLap equals: 0.
	self
		should: [ match winner ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'There is no winner' ]
]

{ #category : #tests }
MatchTest >> testPlayerMovesForwardOnBoard [
	| fabio match dices board players |
	board := Board deterministicWithSpaces: 20 andEffectsGeneratedFrom: {NoEffect new}.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: fabio.
	dices := OrderedCollection
		with: (Dice deterministicWithSpaces: 5 throwing: #(4))
		with: (Dice deterministicWithSpaces: 3 throwing: #(3)).
	match := Match
		playedBy: players
		throwing: dices
		during: 1
		on: board.
	self assert: (match positionOf: fabio) currentSpace equals: 1.
	match playedBy: fabio.
	self assert: (match positionOf: fabio) currentSpace equals: 8
]

{ #category : #tests }
MatchTest >> testPlayersRankings [
	| luciana micaela carolina victoria match board dices players |
	dices := OrderedCollection
		with: (Dice deterministicWithSpaces: 5 throwing: #(1 3 5 4)).
	board := Board deterministicWithSpaces: 20 andEffectsGeneratedFrom: {NoEffect new}.
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
	board := Board
		deterministicWithSpaces: 20
		andEffectsGeneratedFrom:
			{NoEffect new.
			AtomicBombEffect new}.
	martin := Player named: 'Martin'.
	juan := Player named: 'Juan'.
	dices := OrderedCollection with: (Dice deterministicWithSpaces: 6 throwing: #(1 2 3 4)).
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
	board := Board deterministicWithSpaces: 20 andEffectsGeneratedFrom: {NoEffect new}.
	martin := Player named: 'Martin'.
	juan := Player named: 'Juan'.
	players := OrderedCollection with: martin with: juan.
	dices := OrderedCollection
		with: (Dice deterministicWithSpaces: 6 throwing: #(3 2 5))
		with: (Dice deterministicWithSpaces: 5 throwing: #(2 5 4))
		with: (Dice deterministicWithSpaces: 5 throwing: #(1 2 3))
		with: (Dice deterministicWithSpaces: 8 throwing: #(7 6 1))
		with: (Dice deterministicWithSpaces: 2 throwing: #(1 2 1)).
	match := Match
		playedBy: players
		throwing: dices
		during: 9
		on: board.
	match playedBy: martin.
	self
		assert: (match positionOf: martin) currentSpace equals: 15;
		assert: (match positionOf: martin) currentLap equals: 0.
	match playedBy: juan.
	self
		assert: (match positionOf: juan) currentSpace equals: 18;
		assert: (match positionOf: juan) currentLap equals: 0.
	match playedBy: martin.
	self
		assert: (match positionOf: martin) currentSpace equals: 9;
		assert: (match positionOf: martin) currentLap equals: 1.
	match playedBy: juan.
	self
		assert: (match positionOf: juan) currentSpace equals: 12;
		assert: (match positionOf: juan) currentLap equals: 1.
	match playedBy: martin.
	self
		assert: (match positionOf: martin) currentSpace equals: 6;
		assert: (match positionOf: martin) currentLap equals: 2.
	match playedBy: juan.
	self
		assert: (match positionOf: juan) currentSpace equals: 6;
		assert: (match positionOf: juan) currentLap equals: 2.
	match playedBy: martin.
	self
		assert: (match positionOf: martin) currentSpace equals: 20;
		assert: (match positionOf: martin) currentLap equals: 2.
	match playedBy: juan.
	self
		assert: (match positionOf: juan) currentSpace equals: 3;
		assert: (match positionOf: juan) currentLap equals: 3.
	match playedBy: martin.
	self
		assert: (match positionOf: martin) currentSpace equals: 14;
		assert: (match positionOf: martin) currentLap equals: 3.
	match playedBy: juan.
	self
		assert: (match positionOf: juan) currentSpace equals: 17;
		assert: (match positionOf: juan) currentLap equals: 3.
	match playedBy: martin.
	self
		assert: (match positionOf: juan) currentSpace equals: 17;
		assert: (match positionOf: juan) currentLap equals: 3;
		assert: (match positionOf: martin) currentSpace equals: 11;
		assert: (match positionOf: martin) currentLap equals: 4
]

{ #category : #tests }
MatchTest >> testWhenMatchIsCreatedWithOnePlayerItIsHisTurn [
	| matias match dices board players |
	dices := OrderedCollection with: (Dice deterministicWithSpaces: 5 throwing: #(1)).
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			AtomicBombEffect new}.
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	self assert: match nextPlayer name equals: 'Matias'
]
