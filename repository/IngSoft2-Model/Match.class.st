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
Match >> adjust: newSpace with: aPosition [
	^ newSpace >= board spaces & (aPosition currentLap = (totalLaps - 1))
		ifTrue: [ Position on: board spaces at: totalLaps - 1 ]
		ifFalse: [ Position
				on: (newSpace -1 % board spaces) +1
				at: aPosition currentLap + (newSpace // board spaces) ]
]

{ #category : #playing }
Match >> adjustBackWards: playerPosition [
	playerPosition
		value:
			(Position
				on: playerPosition value currentSpace % board spaces
				at: playerPosition value currentLap + (playerPosition value currentSpace // board spaces))
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
	positionOfPlayers := players collect:[:player| player -> Position atStart].

]

{ #category : #playing }
Match >> move: aPlayer [
	self assertTurnBelongsTo: aPlayer.
	(positionOfPlayers
		detect: [ :positionPlayer | 
			positionPlayer key = aPlayer
				])value: self nextPlayerPosition
]

{ #category : #description }
Match >> nextPlayer [
	^ players at: playerIndex
]

{ #category : #playing }
Match >> nextPlayerPosition [
	| newPosition nextPlayer |
	nextPlayer := self nextPlayer.
	newPosition := (self positionOf: nextPlayer) currentSpace
		+ (nextPlayer throw: dices).
	^ self adjust: newPosition with: (self positionOf: nextPlayer)
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
Match >> playersPositions [
	^ positionOfPlayers
]

{ #category : #description }
Match >> positionOf: aPlayer [
	^ (positionOfPlayers
		detect: [ :playerWithPosition | playerWithPosition key = aPlayer ]
		ifNone: [ AssertionFailure signal: 'Player ' , aPlayer name , ' is not playing' ]) value
]

{ #category : #description }
Match >> rankingOf: aPlayer [
 ^ (players asSortedCollection:[ :player | self positionOf: player ] descending) detectIndex: aPlayer
	
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
