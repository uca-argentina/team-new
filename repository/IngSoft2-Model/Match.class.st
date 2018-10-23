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

{ #category : #description }
Match >> board [
	^ board
]

{ #category : #playing }
Match >> changeTurn [
	playerIndex := playerIndex % players size + 1
]

{ #category : #description }
Match >> ifMatchEndedDo: aMatchEndedBlock ifNot: aMatchNotEndedBlock [
	(players
		noneSatisfy: [ :player | 
			| position |
			position := self positionOf: player.
			position currentSpace = board spaces & (position currentLap = (totalLaps - 1)) ])
		ifTrue: aMatchNotEndedBlock
		ifFalse: aMatchEndedBlock 
]

{ #category : #initialize }
Match >> initializePlayedBy: thePlayers throwing: theDices during: aNumberOfLaps on: aBoard [
	players := thePlayers asOrderedCollection.
	playerIndex := 1.
	dices := theDices.
	totalLaps := aNumberOfLaps.
	board := aBoard.
	positionOfPlayers := (Dictionary new).
	players do: [ :player | positionOfPlayers at:player put: Position atStart]
]

{ #category : #playing }
Match >> move: aPlayer [
	self assertTurnBelongsTo: aPlayer.
	positionOfPlayers at: aPlayer put: self nextPlayerPosition
	
]

{ #category : #playing }
Match >> move: aPlayer dueToAnEffect: anAmountOfSpaces [
	positionOfPlayers
		at: aPlayer
		put:
			((Position
				on: (self positionOf: aPlayer) currentSpace + anAmountOfSpaces
				at: (self positionOf: aPlayer) currentLap) adjustWith: board andMatchLast: totalLaps)
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
		on: (self positionOf: nextPlayer) currentSpace + (nextPlayer throw: dices)
		at: (self positionOf: nextPlayer) currentLap.
	^ newPosition adjustWith: board andMatchLast: totalLaps
]

{ #category : #playing }
Match >> playedBy: aPlayer [
	self
		assertMatchIncludes: aPlayer;
		ifMatchEndedDo: [ AssertionFailure signal: 'The game is over' ]
			ifNot: [ self move: aPlayer.
			board activateEffectOf: (self positionOf: aPlayer) currentSpace on: self activatedBy: aPlayer.
			self changeTurn ]
]

{ #category : #description }
Match >> players [
^players
]

{ #category : #description }
Match >> playersPositions [
	^ positionOfPlayers
]

{ #category : #description }
Match >> positionOf: aPlayer [
	^ (positionOfPlayers at: aPlayer ifAbsent: [ AssertionFailure signal: 'Player ' , aPlayer name , ' is not playing' ])

]

{ #category : #description }
Match >> rankingOf: aPlayer [
 ^ (players asSortedCollection:[ :player | self positionOf: player ] descending) detectIndex: aPlayer
	
]

{ #category : #playing }
Match >> resetOnlyPositionOfAllThePlayers [
	players
		do:
			[ :player | positionOfPlayers at: player put: (Position on: 1 at: (self positionOf: player) currentLap) ]
]

{ #category : #description }
Match >> totalLaps [
	^ totalLaps
]

{ #category : #description }
Match >> winner [
	self
		ifMatchEndedDo: [ ^ players
				detect: [ :player | 
					(self positionOf: player) currentSpace = board spaces
						& ((self positionOf: player) currentLap = (totalLaps-1)) ] ]
		ifNot: [ AssertionFailure signal: 'There is no winner' ]
]
