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
		'cardsAtHands',
		'deck',
		'lastEffect',
		'cardsAffectingPlayers',
		'lastCard'
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
	(cardsAffectingPlayers at: aPlayer) add: aCard
]

{ #category : #'as yet unclassified' }
Match >> activateInstant: aCard toBeAppliedoTo: aPlayer [
	lastCard := aPlayer -> aCard
]

{ #category : #description }
Match >> assert: aCard isAffecting: aPlayer [
	(cardsAffectingPlayers at: aPlayer)
		detect: [ :card | card = aCard ]
		ifNone: [ MatchException signal: 'There is not a card ' , aCard className , ' affecting ' , aPlayer name ]
]

{ #category : #description }
Match >> assert: aPlayer owns: aCard [
	(cardsAtHands at: aPlayer)
		detect: [ :card | card = aCard ]
		ifNone: [ MatchException signal: 'The player ' , aPlayer name , ' do not own ' , aCard className ]
]

{ #category : #description }
Match >> assertMatchHasEnded [
	self matchNotEnded
		ifFalse: [ MatchException signal: 'The match is over' ]
]

{ #category : #description }
Match >> assertMatchIncludes: aPlayer [
	(players includes: aPlayer)
		ifFalse: [ MatchException signal: 'Player ' , aPlayer name , ' is not playing' ]
]

{ #category : #description }
Match >> assertTurnBelongsTo: aPlayer [
	aPlayer = self nextPlayer
		ifFalse: [ MatchException signal: 'It is not ' , aPlayer name , ' turn' ]
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
	cardsAffectingPlayers := Dictionary new.
	cardsAtHands := Dictionary new.
	players
		do: [ :player | 
			positionOfPlayers at: player put: Position atStart.
			cardsAtHands at: player put: (OrderedCollection with: deck dealCard with: deck dealCard).
			cardsAffectingPlayers at: player put: OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
Match >> instantRepeat: aRepeatCard by: aPlayer [
	self assert: aPlayer owns: aRepeatCard.
	self assertMatchIncludes: aPlayer.
	aRepeatCard applyCardEffectOn: self.
	self remove: aRepeatCard atHandfrom: aPlayer
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
	aCard applyIn: self to: aPlayer.
	self remove: aCard atHandfrom: aPlayer
]

{ #category : #playing }
Match >> play: aCard by: anAffecterPlayer affecting: anActivatedCard [
	self assert: anAffecterPlayer owns: aCard.
	self assert: anActivatedCard isAffecting: anAffecterPlayer.
	self assertMatchIncludes: anAffecterPlayer.
	aCard activate: anActivatedCard affecting: anAffecterPlayer in: self.
	self remove: aCard atHandfrom: anAffecterPlayer
]

{ #category : #playing }
Match >> play: aCard by: anAffecterPlayer affecting: anAffectedPlayer andHis: activatedCard [
	self assert: anAffecterPlayer owns: aCard.
	self assert: activatedCard isAffecting: anAffectedPlayer.
	self assertMatchIncludes: anAffecterPlayer.
	self assertMatchIncludes: anAffectedPlayer.
	aCard activate: activatedCard affecting: anAffecterPlayer in: self.
	self remove: aCard atHandfrom: anAffecterPlayer
]

{ #category : #playing }
Match >> play: aCard to: anAffectedPlayer by: anAffecterPlayer [
	self assert: anAffecterPlayer owns: aCard.
	self assertMatchIncludes: anAffectedPlayer.
	self assertMatchIncludes: anAffecterPlayer.
	aCard needs: self nextPlayer ToBeTurnOf: anAffecterPlayer.
	aCard applyIn: self to: anAffectedPlayer.
	self remove: aCard atHandfrom: anAffecterPlayer
]

{ #category : #playing }
Match >> playedBy: aPlayer [
	self assertMatchIncludes: aPlayer.
	self assertMatchHasEnded.
	self move: aPlayer.
	board applyEffectOf: (self positionOf: aPlayer) currentSpace on: self activatedBy: aPlayer.
	self changeTurn
]

{ #category : #accessing }
Match >> players [
	^ players
]

{ #category : #description }
Match >> positionOf: aPlayer [
	^ positionOfPlayers at: aPlayer ifAbsent: [ AssertionFailure signal: 'Player ' , aPlayer name , ' is not playing' ]
]

{ #category : #description }
Match >> rankingOf: aPlayer [
	^ (players asSortedCollection: [ :player | self positionOf: player ] descending)
		detectIndex: aPlayer
]

{ #category : #removing }
Match >> remove: aCard affecting: aPlayer [
	(cardsAffectingPlayers at: aPlayer) remove: aCard
]

{ #category : #removing }
Match >> remove: aCard atHandfrom: aPlayer [ 
	(cardsAtHands at:aPlayer) remove: aCard
]

{ #category : #playing }
Match >> throwDicesAndApplyCardsBy: nextPlayer [
	^ (nextPlayer throw: dices)
		+ ((cardsAffectingPlayers at: nextPlayer) sumNumbers: [ :card | card spacesToMove ])
]

{ #category : #updating }
Match >> updateLastEffect: anEffectToPlayer [
	lastEffect := anEffectToPlayer
]

{ #category : #description }
Match >> winner [
	self matchNotEnded
		ifTrue: [ MatchException signal: 'There is no winner' ].
	^ players detect: [ :player | self isTheLastSpaceWithFinalLapCrossedBy: player ]
]
