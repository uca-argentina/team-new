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
		'totalLaps',
		'cardsActivated',
		'cardsAtHands',
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Match class >> playedBy: thePlayers throwing: gameDices during: aNumberOfLaps on: aBoard dealingFrom: aDeck [
	^ self new
		initializePlayedBy: thePlayers
		throwing: gameDices
		during: aNumberOfLaps
		on: aBoard
		dealingFrom: aDeck
]

{ #category : #playing }
Match >> apply: aCard to: anAffectedPlayer by: anAffecterPlayer [
	self assertPlayerOwns: aCard.
	self assertMatchIncludes: anAffectedPlayer.
	self assertMatchIncludes: anAffecterPlayer.
	aCard applyTo: anAffectedPlayer  by: anAffecterPlayer  considering: self nextPlayer  
	
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
Match >> assertPlayerOwns: aCard [
	^ cardsAtHands includes: aCard 
]

{ #category : #description }
Match >> assertTurnBelongsTo: aPlayer [
	aPlayer = self nextPlayer
		ifFalse: [ AssertionFailure signal: 'It is not ' , aPlayer name , ' turn' ]
]

{ #category : #description }
Match >> cardsAtHandOf: aPlayer [ 
	^ cardsAtHands at: aPlayer
]

{ #category : #playing }
Match >> changeTurn [
	playerIndex := (playerIndex rem: players size) + 1
]

{ #category : #playing }
Match >> dealCardTo: aPlayer [ 
	(cardsAtHands at:aPlayer) add: deck dealCard.
]

{ #category : #initialization }
Match >> initializePlayedBy: thePlayers throwing: theDices during: aNumberOfLaps on: aBoard dealingFrom: aDeck [
	players := thePlayers asOrderedCollection.
	playerIndex := 1.
	dices := theDices.
	totalLaps := aNumberOfLaps.
	board := aBoard.
	deck := aDeck.
	positionOfPlayers := Dictionary new.
	cardsActivated := Dictionary new.
	cardsAtHands := Dictionary new.
	players
		do: [ :player | 
			positionOfPlayers at: player put: Position atStart.
			cardsAtHands
				at: player
				put: (OrderedCollection with: deck dealCard with: deck dealCard) ]
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

{ #category : #description }
Match >> winner [
	self matchNotEnded
		ifTrue: [ AssertionFailure signal: 'There is no winner' ].
	^ players detect: [ :player | self isTheLastSpaceWithFinalLapCrossedBy: player ]
]
