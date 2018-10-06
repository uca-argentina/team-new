Class {
	#name : #Match,
	#superclass : #Object,
	#instVars : [
		'board',
		'players',
		'dices',
		'orderOfPlayers',
		'positionOfPlayers',
		'playerIndex'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Match class >> playedBy: thePlayers throwing: gameDices on: aBoard [
	^ self new initializePlayedBy: thePlayers throwing: gameDices on: aBoard
]

{ #category : #comparing }
Match >> adjust: valueOfDices [
	^ valueOfDices > board spaces
		ifTrue: [ board spaces ]
		ifFalse: [ valueOfDices ]
]

{ #category : #playing }
Match >> alternateTurn [
	playerIndex = players size
		ifTrue: [ playerIndex := 1 ]
		ifFalse: [ playerIndex := playerIndex + 1 ]
]

{ #category : #description }
Match >> assertIsPlayerTurn: aPlayer [
	^ aPlayer = self nextPlayer
]

{ #category : #initialize }
Match >> initializePlayedBy: thePlayers throwing: theDices on: aBoard [
	players := thePlayers asOrderedCollection.
	playerIndex := 1.
	dices := theDices.
	board := aBoard.
	positionOfPlayers := Dictionary new.
	thePlayers do: [ :player | positionOfPlayers at: player put: 0 ]
]

{ #category : #description }
Match >> isThereAWinner [
	^ (players select: [ :player | (self positionOf: player) = board spaces ]) isNotEmpty 
]

{ #category : #playing }
Match >> move: aPlayer [
	(self assertIsPlayerTurn: aPlayer)
		ifTrue: [ positionOfPlayers at: aPlayer put: self nextPlayerPosition ]
		ifFalse: [ AssertionFailure signal: 'It is not ' , aPlayer name , ' turn' ]
]

{ #category : #description }
Match >> nextPlayer [
	^ players at: playerIndex
]

{ #category : #playing }
Match >> nextPlayerPosition [
	| newPosition |
	newPosition := (self positionOf: self nextPlayer) + (self nextPlayer throw: dices).
	^ self adjust: newPosition
]

{ #category : #playing }
Match >> playedBy: aPlayer [
	self isThereAWinner
		ifTrue: [ AssertionFailure signal: 'The game is over' ]
		ifFalse: [ self
				move: aPlayer;
				alternateTurn ]
]

{ #category : #description }
Match >> positionOf: aPlayer [
	^ positionOfPlayers
		at: aPlayer
		ifAbsent: [ ^ 'Player ' , aPlayer name , ' is not playing' ]
]

{ #category : #description }
Match >> winner [
	^ self isThereAWinner
		ifTrue: [ (players select: [ :player | (self positionOf: player) = board spaces ]) first ]
		ifFalse: [ 'None' ]
]
