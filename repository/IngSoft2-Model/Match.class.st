Class {
	#name : #Match,
	#superclass : #Object,
	#instVars : [
		'board',
		'players',
		'dices',
		'positionOfPlayers',
		'playerIndex',
		'totalLaps',
		'deck',
		'lastEffect',
		'cardsAffectingPlayers',
		'lastCard',
		'playersCards'
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

{ #category : #adding }
Match >> add: aCard toBeAppliedTo: aPlayer [
	(cardsAffectingPlayers at: aPlayer ifAbsentPut: [ OrderedCollection new ]) add: aCard
]

{ #category : #description }
Match >> assert: aCard isAffecting: aPlayer [
	((cardsAffectingPlayers at: aPlayer ifAbsentPut:[	OrderedCollection new ]) includes: aCard)
		ifFalse: [ MatchException signal: 'There is not a card ' , aCard className , ' affecting ' , aPlayer name ]
]

{ #category : #description }
Match >> assert: aPlayer owns: aCard [
	self assertIsPlaying: aPlayer.
	(playersCards at: aPlayer ifAbsentPut: [ OrderedCollection with: deck dealCard with: deck dealCard ])
		detect: [ :card | card = aCard ]
		ifNone: [ MatchException signal: 'The player ' , aPlayer name , ' do not own ' , aCard className ]
]

{ #category : #description }
Match >> assertIsPlaying: aPlayer [
	(players includes: aPlayer)
		ifFalse: [ MatchException signal: 'Player ' , aPlayer name , ' is not playing' ]
]

{ #category : #description }
Match >> assertMatchHasEnded [
	self matchNotEnded
		ifFalse: [ MatchException signal: 'The match is over' ]
]

{ #category : #description }
Match >> assertTurnBelongsTo: aPlayer [
	aPlayer = self nextPlayer
		ifFalse: [ MatchException signal: 'It is not ' , aPlayer name , ' turn' ]
]

{ #category : #accessing }
Match >> cardsOf: aPlayer [
	self assertIsPlaying: aPlayer.
	^ playersCards at: aPlayer ifAbsentPut: [ OrderedCollection with: deck dealCard with: deck dealCard ]
]

{ #category : #playing }
Match >> changeTurn [
	playerIndex := (playerIndex rem: players size) + 1
]

{ #category : #playing }
Match >> dealCardTo: aPlayer [ 
	(playersCards at:aPlayer) add: deck dealCard.
]

{ #category : #description }
Match >> hasWon: aPlayer [
	^ (self positionOf: aPlayer) currentLap > (totalLaps - 1)
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
	cardsAffectingPlayers := Dictionary new.
	playersCards := Dictionary new.
	lastCard := NoneCard new.
	lastEffect := players first -> NoEffect new
]

{ #category : #accessing }
Match >> lastCard [
	^ lastCard
]

{ #category : #accessing }
Match >> lastEffect [
	^ lastEffect value
]

{ #category : #accessing }
Match >> lastEffectTarget [
	^ lastEffect key
]

{ #category : #playing }
Match >> matchNotEnded [
	^ players
		noneSatisfy: [ :player | self hasWon: player ]
]

{ #category : #moving }
Match >> move: aPlayer [
	self assertTurnBelongsTo: aPlayer.
	positionOfPlayers at: aPlayer put: self nextPlayerPosition
]

{ #category : #moving }
Match >> moveByEffectTo: aPlayer spaces: anAmountOfSpaces [
	positionOfPlayers
		at: aPlayer
		put:
			(Position
				whenMoving: anAmountOfSpaces
				from: (self positionOf: aPlayer)
				onBoardOfSize: board spaces)
]

{ #category : #accessing }
Match >> nextPlayer [
	^ players at: playerIndex
]

{ #category : #playing }
Match >> nextPlayerPosition [
	| nextPlayer |
	nextPlayer := self nextPlayer.
	^ Position
		whenMoving: (self throwDicesAndApplyCardsBy: nextPlayer)
		from: (self positionOf: nextPlayer)
		onBoardOfSize: board spaces
]

{ #category : #playing }
Match >> play: aCard by: aPlayer [
	self assert: aPlayer owns: aCard.
	aCard assertingNextPlayerOn: self is: aPlayer.
	aCard applyIn: self to: aPlayer.
	self remove: aCard from: aPlayer
]

{ #category : #playing }
Match >> play: aCard by: anAffecterPlayer targeting: anActivatedCard [
	self assert: anAffecterPlayer owns: aCard.
	"self assert: anActivatedCard isAffecting: anAffecterPlayer."
	aCard applyTo: anActivatedCard affecting: anAffecterPlayer in: self.
	self remove: aCard from: anAffecterPlayer
]

{ #category : #playing }
Match >> play: aCard by: anAffecterPlayer targeting: anAffectedPlayer andHis: activatedCard [
	self assert: anAffecterPlayer owns: aCard.
	self assert: activatedCard isAffecting: anAffectedPlayer.
	self assertIsPlaying: anAffectedPlayer.
	aCard applyTo: activatedCard affecting: anAffectedPlayer in: self.
	self remove: aCard from: anAffecterPlayer
]

{ #category : #playing }
Match >> play: aCard targeting: anAffectedPlayer by: anAffecterPlayer [
	self assert: anAffecterPlayer owns: aCard.
	self assertIsPlaying: anAffectedPlayer.
	aCard assertingNextPlayerOn: self is: anAffecterPlayer.
	aCard applyIn: self to: anAffectedPlayer.
	self remove: aCard from: anAffecterPlayer
]

{ #category : #playing }
Match >> playedBy: aPlayer [
	self assertIsPlaying: aPlayer.
	self assertMatchHasEnded.
	self move: aPlayer.
	board applyEffectOf: (self positionOf: aPlayer) currentSpace on: self activatedBy: aPlayer.
	self changeTurn
]

{ #category : #accessing }
Match >> players [
	^ players
]

{ #category : #accessing }
Match >> positionOf: aPlayer [
	self assertIsPlaying: aPlayer.
	^ positionOfPlayers at: aPlayer ifAbsentPut: [ Position atStart ]
]

{ #category : #accessing }
Match >> rankingOf: aPlayer [
	self assertIsPlaying: aPlayer.
	^ (players asSortedCollection: [ :player | self positionOf: player ] descending) indexOf: aPlayer
]

{ #category : #removing }
Match >> remove: aCard affecting: aPlayer [
	self assert: aCard isAffecting: aPlayer.
	(cardsAffectingPlayers at: aPlayer) remove: aCard
]

{ #category : #removing }
Match >> remove: aCard from: aPlayer [ 
	(playersCards at:aPlayer) remove: aCard
]

{ #category : #playing }
Match >> throwDicesAndApplyCardsBy: nextPlayer [
	^ (nextPlayer throw: dices)
		+
			((cardsAffectingPlayers at: nextPlayer ifAbsentPut: [ OrderedCollection new ])
				sumNumbers: [ :card | card spacesToMove ])
]

{ #category : #updating }
Match >> updateLastCard: aCard [
	lastCard := aCard
]

{ #category : #updating }
Match >> updateLastEffect: anEffectToPlayer [
	lastEffect := anEffectToPlayer
]

{ #category : #accessing }
Match >> winner [
	self matchNotEnded
		ifTrue: [ MatchException signal: 'There is no winner' ].
	^ players detect: [ :player | self hasWon: player ]
]
