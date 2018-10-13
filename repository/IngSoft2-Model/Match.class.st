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

{ #category : #comparing }
Match >> adjust: newSpace with: aPosition [
	(newSpace > board spaces) * totalLaps
		ifTrue: [ aPosition
				change: board spaces;
				update: totalLaps ]
		ifFalse: [ aPosition
				change: newSpace % board spaces;
				update: aPosition currentLap + (newSpace / board spaces) asInteger ].
	^ aPosition
]

{ #category : #playing }
Match >> alternateTurn [
	playerIndex := playerIndex % players size + 1
]

{ #category : #description }
Match >> assertIsPlayerTurn: aPlayer [
	^ aPlayer = self nextPlayer
]

{ #category : #description }
Match >> ifMatchEndedDo: aMatchEndedBlock ifNot: aMatchNotEndedBlock [
	(players select: [:player | (self positionOf: player) currentSpace = (board spaces) ]) isNotEmpty
	ifTrue: [ aMatchEndedBlock value]
	ifFalse: [ aMatchNotEndedBlock value]
]

{ #category : #initialize }
Match >> initializePlayedBy: thePlayers throwing: theDices during: aNumberOfLaps on: aBoard [ 
	players := thePlayers asOrderedCollection.
	playerIndex := 1.
	dices := theDices.
	totalLaps := aNumberOfLaps.
	board := aBoard.
	positionOfPlayers := OrderedCollection new.
	thePlayers do: [ :player | positionOfPlayers add: (player->Position new) ]
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
	newPosition := (self positionOf: self nextPlayer) currentSpace 
		+ (self nextPlayer throw: dices).
	^ self adjust: newPosition with: (self positionOf: self nextPlayer)
]

{ #category : #playing }
Match >> playedBy: aPlayer [
	self ifMatchEndedDo: [ AssertionFailure signal: 'The game is over' ] 
	ifNot: [ self
				move: aPlayer;
				alternateTurn ]
]

{ #category : #description }
Match >> positionOf: aPlayer [
	"^positionOfPlayers
		at: aPlayer
		ifAbsent: [ ^ 'Player ' , aPlayer name , ' is not playing' ]"
	^ positionOfPlayers detect: [:player| player = aPlayer] ifNone:[AssertionFailure signal:'Player ' , aPlayer name , ' is not playing'] 
]

{ #category : #description }
Match >> winner [
	self
		ifMatchEndedDo: [ ^ players
				detect: [ :player | 
					(self positionOf: player) currentSpace = board spaces & ((self positionOf: player) currentLap = totalLaps )] ]
		ifNot: [ AssertionFailure signal: 'There is no winner' ]
]
