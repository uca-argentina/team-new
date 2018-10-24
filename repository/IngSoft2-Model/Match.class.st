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
	self matchEnded
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
Match >> isTheLastSpaceWithFinalLapOccupiedBy: aPlayer [
	| position |
	position := self positionOf: aPlayer.
	^ position currentSpace = board spaces and: (position currentLap = (totalLaps - 1))
]

{ #category : #playing }
Match >> matchEnded [
	^ players
		noneSatisfy: [ :player | self isTheLastSpaceWithFinalLapOccupiedBy: player ]
]

{ #category : #playing }
Match >> move: aPlayer [
	self assertTurnBelongsTo: aPlayer.
	positionOfPlayers at: aPlayer put: self nextPlayerPosition
]

{ #category : #playing }
Match >> moveByEffectTo: aPlayer spaces: anAmountOfSpaces [
	| position |
	position := self positionOf: aPlayer.
	positionOfPlayers
		at: aPlayer
		put:
			((Position onSpace: position currentSpace + anAmountOfSpaces ofLap: position currentLap)
				adjustWith: board
				andMatchLengthOf: totalLaps)
]

{ #category : #description }
Match >> nextPlayer [
	^ players at: playerIndex
]

{ #category : #playing }
Match >> nextPlayerPosition [
	| newPosition nextPlayer |
	nextPlayer := self nextPlayer.
	newPosition := Position
		onSpace: (self positionOf: nextPlayer) currentSpace + (nextPlayer throw: dices)
		ofLap: (self positionOf: nextPlayer) currentLap.
	^ newPosition adjustWith: board andMatchLengthOf: totalLaps
]

{ #category : #playing }
Match >> playedBy: aPlayer [
	self assertMatchIncludes: aPlayer.
	self assertMatchHasEnded.
	self move: aPlayer.
	self matchEnded
		ifTrue: [ board applyEffectOf: (self positionOf: aPlayer) currentSpace on: self activatedBy: aPlayer ].
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

{ #category : #playing }
Match >> resetPlayersSpaces [
	players
		do: [ :player | positionOfPlayers at: player put: (Position onSpace: 1 ofLap: (self positionOf: player) currentLap) ]
]

{ #category : #description }
Match >> winner [
	self matchEnded
		ifTrue: [ AssertionFailure signal: 'There is no winner' ].
	^ players detect: [ :player | self isTheLastSpaceWithFinalLapOccupiedBy: player ]
]
