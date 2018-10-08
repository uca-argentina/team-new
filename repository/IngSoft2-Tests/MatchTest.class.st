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
MatchTest >> testAPlayerWantsToPlayWhenItIsNotHisTurn [
	| match board martin juan dices players |
	board := Board with: 15.
	martin := Player named: 'Martin'.
	juan := Player named: 'Juan'.
	players := OrderedCollection with: martin with: juan.
	dices := Array with: (Dice deterministicWith: 6) with: (Dice deterministicWith: 5).
	match := Match playedBy: players throwing: dices on: board.
	match
		playedBy: martin;
		playedBy: juan;
		playedBy: martin;
		playedBy: juan.
	self
		should: [ match playedBy: juan ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'It is not Juan turn']
]

{ #category : #tests }
MatchTest >> testAPlayerWantsToPlayWhenMatchIsOver [
	| fabio match board players dices |
	board := Board with: 5.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: fabio.
	dices := Array
		with: (Dice deterministicWith: 5)
		with: (Dice deterministicWith: 3).
	match := Match playedBy: players throwing: dices on: board.
	match
		playedBy: fabio;
		playedBy: fabio.
	self
		should: [ match playedBy: fabio]
		raise: AssertionFailure
		withExceptionDo:
			[ :exception | self assert: exception messageText equals: 'The game is over' ]
]

{ #category : #tests }
MatchTest >> testAPlayerWins [
	| match board martin juan dices players |
	board := Board with: 7.
	martin := Player named: 'Martin'.
	juan := Player named: 'Juan'.
	players := OrderedCollection with: martin with: juan.
	dices := Array
		with: (Dice deterministicWith: 6)
		with: (Dice deterministicWith: 5).
	match := Match playedBy: players throwing: dices on: board.
	match
		playedBy: martin;
		playedBy: juan;
		playedBy: martin.
	self assert: match winner name equals: 'Martin'
]

{ #category : #tests }
MatchTest >> testAskingAPositionOfPlayerThatIsNotPlaying [
	| fabio cristian andres match board dices players |
	dices := Array
		with: (Dice deterministicWith: 5)
		with: (Dice deterministicWith: 3).
	board := Board with: 10.
	fabio := Player named: 'Fabio'.
	cristian := Player named: 'Cristian'.
	andres := Player named: 'Andres'.
	players := OrderedCollection with: fabio with: cristian.
	match := Match playedBy: players throwing: dices on: board.
	self assert: (match positionOf: fabio) equals: 0.
	self assert: (match positionOf: cristian) equals: 0.
	self
		assert: (match positionOf: andres)
		equals: 'Player ' , andres name , ' is not playing'
]

{ #category : #tests }
MatchTest >> testCreatingMatchAndAllPlayersStartAtSpace0 [
	| fabio cristian match board dices players |
	dices := Array
		with: (Dice deterministicWith: 5)
		with: (Dice deterministicWith: 3).
	board := Board with: 10.
	fabio := Player named: 'Fabio'.
	cristian := Player named: 'Cristian'.
	players := OrderedCollection with: fabio with: cristian.
	match := Match playedBy: players throwing: dices on: board.
	self assert: (match positionOf: fabio) equals: 0.
	self assert: (match positionOf: cristian) equals: 0
]

{ #category : #tests }
MatchTest >> testNoPlayerPlaysAndThereIsNoWinner [
	| match board mateo marcos players dices |
	board := Board with: 30.
	mateo := Player named: 'Mateo'.
	marcos := Player named: 'Marcos'.
	players := OrderedCollection with: mateo with: marcos.
	dices := Array
		with: (Dice deterministicWith: 6)
		with: (Dice deterministicWith: 10).
	match := Match playedBy: players throwing: dices on: board.
	self assert: match winner equals: 'None'
]

{ #category : #tests }
MatchTest >> testPlayerDoNotExceedLastSpace [
	| match board martin juan dices players |
	board := Board with: 14.
	martin := Player named: 'Martin'.
	juan := Player named: 'Juan'.
	players := OrderedCollection with: martin with: juan.
	dices := Array
		with: (Dice deterministicWith: 6)
		with: (Dice deterministicWith: 5)
		with: (Dice deterministicWith: 5)
		with: (Dice deterministicWith: 8)
		with: (Dice deterministicWith: 2).
	match := Match playedBy: players throwing: dices on: board.
	match
		playedBy: martin;
		playedBy: juan;
		playedBy: martin.
	self assert: (match positionOf: martin) equals: board spaces
]

{ #category : #tests }
MatchTest >> testPlayerMovesForwardOnBoard [
	| fabio match dices board players |
	board := Board with: 10.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: fabio.
	dices := Array
		with: (Dice deterministicWith: 5)
		with: (Dice deterministicWith: 3).
	match := Match playedBy: players throwing: dices on: board.
	match playedBy: fabio.
	self assert: (match positionOf: fabio) equals: 2
]

{ #category : #tests }
MatchTest >> testPlayersSequenceOnMatch [
	| board martin juan match players dices |
	board := Board with: 20.
	martin := Player named: 'Martin'.
	juan := Player named: 'Juan'.
	dices := Array with: (Dice deterministicWith: 6).
	players := OrderedCollection with: martin with: juan.
	match := Match playedBy: players throwing: dices on: board.
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
	board := Board with: 30.
	martin := Player named: 'Martin'.
	juan := Player named: 'Juan'.
	players := OrderedCollection with: martin with: juan.
	dices := Array
		with: (Dice deterministicWith: 6)
		with: (Dice deterministicWith: 5)
		with: (Dice deterministicWith: 5)
		with: (Dice deterministicWith: 8)
		with: (Dice deterministicWith: 2).
	match := Match playedBy: players throwing: dices on: board.
	match
		playedBy: martin;
		playedBy: juan;
		playedBy: martin.
	self assert: (match positionOf: juan) equals: 10.
	self assert: (match positionOf: martin) equals: 18
]

{ #category : #tests }
MatchTest >> testWhenMatchIsCreatedWithOnePlayerItIsHisTurn [
	| matias match dices board players |
	dices := Array with: (Dice deterministicWith: 5).
	board := Board with: 10.
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	match := Match playedBy: players throwing: dices on: board.
	self assert: match nextPlayer name equals: 'Matias'
]
