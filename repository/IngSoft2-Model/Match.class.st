Class {
	#name : #Match,
	#superclass : #Object,
	#instVars : [
		'board',
		'players',
		'dices',
		'orderOfPlayers',
		'positionOfPlayers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Match class >> playedBy: thePlayers throwing: gameDices on: aBoard [
	^ self new initializePlayedBy: thePlayers throwing: gameDices on: aBoard
]

{ #category : #playing }
Match >> alternateTurn [
	| playerAuxiliar |
	playerAuxiliar := orderOfPlayers first.
	orderOfPlayers removeFirst.
	orderOfPlayers add: playerAuxiliar
]

{ #category : #playing }
Match >> anAmountOfSpacesAccordingToDices [
	^ self isPlayerTryingToMoveFurtherThanSpacesOfBoard
		ifTrue: [ board spaces ]
		ifFalse: [ (self positionOf: self nextPlayer) + (self nextPlayer throw: dices) ]
]

{ #category : #initialize }
Match >> initializePlayedBy: thePlayers throwing: theDices on: aBoard [
	players := thePlayers.
	dices := theDices.
	board := aBoard.
	positionOfPlayers := Dictionary new.
	orderOfPlayers := LinkedList new.
	thePlayers do: [ :player | positionOfPlayers at: player name put: 0.
										orderOfPlayers add: player]
	
]

{ #category : #comparing }
Match >> isPlayerTryingToMoveFurtherThanSpacesOfBoard [
	^ (self positionOf: self nextPlayer) + (self nextPlayer throw: dices) >= board spaces
]

{ #category : #description }
Match >> isThereAWinner [
	^ (players select: [ :player | (self positionOf: player) = board spaces ]) isNotEmpty 
]

{ #category : #playing }
Match >> movePlayer [
	positionOfPlayers at: self nextPlayer name put: self anAmountOfSpacesAccordingToDices
]

{ #category : #description }
Match >> nextPlayer [
	^ orderOfPlayers first
]

{ #category : #playing }
Match >> play [
	self isThereAWinner
		ifTrue: [AssertionFailure signal:'The game is over'  ]
		ifFalse: [ self
				movePlayer;
				alternateTurn ]
]

{ #category : #description }
Match >> positionOf: aPlayer [
	^ positionOfPlayers at: aPlayer name ifAbsent: [ ^ 'Player ' , aPlayer name , ' is not playing' ]
]

{ #category : #description }
Match >> winner [
	^ self isThereAWinner
		ifTrue: [  (players select: [ :player | (self positionOf: player) = board spaces ]) first ]
		ifFalse: [ 'None']
]
