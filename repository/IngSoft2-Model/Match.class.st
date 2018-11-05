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
		'deck',
		'lastInstantCard',
		'lastEffect'
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
Match >> activate: aCard toBeAppliedTo: aPlayer [ 
	(cardsActivated at: aPlayer) add: aCard
]

{ #category : #'as yet unclassified' }
Match >> activateInstant: aCancellationCard toBeAppliedoTo: aPlayer [
	lastInstantCard := aCancellationCard -> aPlayer
]

{ #category : #'as yet unclassified' }
Match >> anulate: aCard affecting: aPlayer [
	(cardsActivated at: aPlayer) remove: aCard.
	"cardsActivated removeKey: aPlayer"
]

{ #category : #description }
Match >> assert: aPlayer owns: aCard [
	(cardsAtHands at: aPlayer)
		detect: [ :card | card = aCard ]
		ifNone: [ AssertionFailure signal: 'The player ', aPlayer name ,' do not own ', aCard className ]
]

{ #category : #description }
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
			cardsAtHands at: player put: (OrderedCollection with: deck dealCard with: deck dealCard).
			cardsActivated at: player put: OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
Match >> instantRepeat: aRepeatCard by: aPlayer [
"Para repetir necesito saber cual fue el ultimo casillero activado y saber quien fue el ultimo afectado o puedo activarlo sobre mi o puedo elegir a quien afectar?" 
	self assert: aPlayer owns: aRepeatCard.
	self assertMatchIncludes: aPlayer.
	aRepeatCard applyCardEffectOn: self.
	self remove: aRepeatCard from: aPlayer
]

{ #category : #description }
Match >> isTheLastSpaceWithFinalLapCrossedBy: aPlayer [
	| position |
	position := self positionOf: aPlayer.
	^ position currentLap > (totalLaps - 1)
]

{ #category : #accessing }
Match >> lastEffect [
	^ lastEffect
]

{ #category : #playing }
Match >> matchNotEnded [
	^ players
		noneSatisfy: [ :player | self isTheLastSpaceWithFinalLapCrossedBy: player ]
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

{ #category : #description }
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
	self assertMatchIncludes: aPlayer.
	aCard needs: self nextPlayer ToBeTurnOf: aPlayer.
	aCard applyBy:aPlayer in: self.
	self remove: aCard from: aPlayer
]

{ #category : #'as yet unclassified' }
Match >> play: aCard by: anAffecterPlayer affecting: anAffectedPlayer andHis: activatedCard [
	self assert: anAffecterPlayer owns: aCard.
	self assertMatchIncludes: anAffecterPlayer.
	self assertMatchIncludes: anAffectedPlayer.
	aCard activate: activatedCard affecting: anAffecterPlayer on: self.
	self activateInstant: aCard toBeAppliedoTo: anAffectedPlayer.
	self remove: aCard from: anAffecterPlayer
]

{ #category : #playing }
Match >> play: aCard to: anAffectedPlayer by: anAffecterPlayer [
	self assert: anAffecterPlayer owns: aCard.
	self assertMatchIncludes: anAffectedPlayer.
	self assertMatchIncludes: anAffecterPlayer.
	aCard needs: self nextPlayer ToBeTurnOf: anAffecterPlayer.
	self activate: aCard toBeAppliedTo: anAffectedPlayer.
	self remove: aCard from: anAffecterPlayer
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

{ #category : #playing }
Match >> remove: aCard from: aPlayer [ 
	(cardsAtHands at:aPlayer) remove: aCard
]

{ #category : #playing }
Match >> throwDicesAndApplyCardsBy: nextPlayer [
	^ (nextPlayer throw: dices) + ((cardsActivated at: nextPlayer) sumNumbers: [ :card | card spacesToMove ])
]

{ #category : #updating }
Match >> updateLastEffect: anEffect [
	lastEffect := anEffect
]

{ #category : #description }
Match >> winner [
	self matchNotEnded
		ifTrue: [ AssertionFailure signal: 'There is no winner' ].
	^ players detect: [ :player | self isTheLastSpaceWithFinalLapCrossedBy: player ]
]
