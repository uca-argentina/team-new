Class {
	#name : #Match,
	#superclass : #Object,
	#instVars : [
		'board',
		'players',
		'dices',
		'orderOfPlayers',
		'positionOfPlayers',
		'playerIndex',
		'totalLaps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Match class >> playedBy: thePlayers throwing: gameDices during: aNumberOfLaps on: aBoard [
	^ self new
		initializePlayedBy: thePlayers
		throwing: gameDices
		during: aNumberOfLaps
		on: aBoard
]

{ #category : #playing }
Match >> assertMatchHasEnded [
	self matchNotEnded
		ifFalse: [ AssertionFailure signal: 'The match is over' ]
]

{ #category : #description }
Match >> assertMatchIncludes: aPlayer [
	(players includes: aPlayer)
		ifFalse: [ AssertionFailure signal: 'Player ' , aPlayer name , ' is not playing' ]
]

{ #category : #description }
Match >> assertTurnBelongsTo: aPlayer [
	aPlayer = self nextPlayer
		ifFalse: [ AssertionFailure signal: 'It is not ' , aPlayer name , ' turn' ]
]

{ #category : #accessing }
Match >> board [
	^ board
]

{ #category : #playing }
Match >> changeTurn [
	playerIndex := (playerIndex rem: players size) + 1
]

{ #category : #initialization }
Match >> initializePlayedBy: thePlayers throwing: theDices during: aNumberOfLaps on: aBoard [
	players := thePlayers asOrderedCollection.
	playerIndex := 1.
	dices := theDices.
	totalLaps := aNumberOfLaps.
	board := aBoard.
	positionOfPlayers := Dictionary new.
	players do: [ :player | positionOfPlayers at: player put: Position atStart ]
]

{ #category : #description }
Match >> isTheLastSpaceWithFinalLapCrossedBy: aPlayer [
	| position |
	position := self positionOf: aPlayer.
	^ position currentLap > (totalLaps - 1)
]

{ #category : #playing }
Match >> matchNotEnded [
	^ players
		noneSatisfy: [ :player | self isTheLastSpaceWithFinalLapCrossedBy: player ]
]

{ #category : #playing }
Match >> move: aPlayer [
	self assertTurnBelongsTo: aPlayer.
	positionOfPlayers at: aPlayer put: self nextPlayerPosition
]

{ #category : #playing }
Match >> moveByEffectTo: aPlayer spaces: anAmountOfSpaces [
	positionOfPlayers
		at: aPlayer
		put:
			(Position
				whenMoving: anAmountOfSpaces
				from: (self positionOf: aPlayer)
				onBoardOfSize: board spaces)
]

{ #category : #description }
Match >> nextPlayer [
	^ players at: playerIndex
]

{ #category : #playing }
Match >> nextPlayerPosition [
	| newPosition nextPlayer |
	nextPlayer := self nextPlayer.
	^ Position
		whenMoving: (nextPlayer throw: dices)
		from: (self positionOf: nextPlayer)
		onBoardOfSize: board spaces
]

{ #category : #playing }
Match >> playedBy: aPlayer [
	self assertMatchIncludes: aPlayer.
	self assertMatchHasEnded.
	self move: aPlayer.
	board applyEffectOf: (self positionOf: aPlayer) currentSpace on: self activatedBy: aPlayer.
	self changeTurn
]

{ #category : #accesing }
Match >> players [
	^ players
]

{ #category : #description }
Match >> positionOf: aPlayer [
	^ positionOfPlayers at: aPlayer ifAbsent: [ AssertionFailure signal: 'Player ' , aPlayer name , ' is not playing' ]
]

{ #category : #description }
Match >> rankingOf: aPlayer [
	^ (players asSortedCollection: [ :player | self positionOf: player ] descending) detectIndex: aPlayer
]

{ #category : #accessing }
Match >> totalLaps [
	^ totalLaps
]

{ #category : #description }
Match >> winner [
	self matchNotEnded
		ifTrue: [ AssertionFailure signal: 'There is no winner' ].
	^ players detect: [ :player | self isTheLastSpaceWithFinalLapCrossedBy: player ]
]
