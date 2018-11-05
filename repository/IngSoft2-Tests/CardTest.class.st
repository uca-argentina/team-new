Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
CardTest >> boardWith10SpacesWithoutEffects [
	^ Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom: {NoEffect new}
]

{ #category : #accessing }
CardTest >> playerNamedJose [
	^ Player named: 'Jose'
]

{ #category : #accessing }
CardTest >> playerNamedJuan [
	^ Player named: 'Juan'
]

{ #category : #tests }
CardTest >> testPlayerPlaysAccelerationCard [
	| juan board dice deck match accelerationCard martin jose speedCard |
	juan := self playerNamedJuan.
	jose := self playerNamedJose.
	martin := Player named: 'Martin'.
	board := self boardWith10SpacesWithoutEffects.
	accelerationCard := AccelerationCard new.
	speedCard := SpeedCard new.
	deck := Deck
		deterministicWithCardSequence:
			{accelerationCard.
			speedCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {1 . 2 . 3}.
	match := Match
		playedBy:
			{juan.
			jose.
			martin}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: accelerationCard by: juan.
	self assert: (match cardsAtHandOf: juan) equals: {speedCard} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 3.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 4.
	match playedBy: martin.
	self assert: (match positionOf: martin) currentSpace equals: 5
]

{ #category : #tests }
CardTest >> testPlayerPlaysCancellationCardAnulatingCancellatingCard [
	| juan board dice deck match accelerationCard cancellationCard jose |
	juan := self playerNamedJuan.
	jose := self playerNamedJose.
	board := self boardWith10SpacesWithoutEffects.
	accelerationCard := AccelerationCard new.
	cancellationCard := CancellationCard new.
	deck := Deck
		deterministicWithCardSequence:
			{accelerationCard.
			cancellationCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {1 . 2 . 3 . 4}.
	match := Match
		playedBy:
			{juan.
			jose}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: accelerationCard by: juan.
	self assert: (match cardsAtHandOf: juan) equals: {cancellationCard} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 3.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 4.
	match
		play: cancellationCard
		by: juan
		affecting: juan
		andHis: accelerationCard.
	self assert: (match cardsAtHandOf: juan) equals: {} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 6.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 8
]

{ #category : #tests }
CardTest >> testPlayerPlaysCancellationCardCancellatingAPermanentCardButNoOnePlayedOne [
	| juan board dice deck match accelerationCard cancellationCard jose |
	juan := self playerNamedJuan.
	jose := self playerNamedJose.
	board := self boardWith10SpacesWithoutEffects.
	accelerationCard := AccelerationCard new.
	cancellationCard := CancellationCard new.
	deck := Deck
		deterministicWithCardSequence:
			{accelerationCard.
			cancellationCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {1 . 2 . 3 . 4}.
	match := Match
		playedBy:
			{juan.
			jose}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match
		play: cancellationCard
		by: juan
		affecting: juan
		andHis: accelerationCard
]

{ #category : #tests }
CardTest >> testPlayerPlaysCancellationCardCancellatingAccelerationCard [
	| juan board dice deck match accelerationCard cancellationCard jose |
	juan := self playerNamedJuan.
	jose := self playerNamedJose.
	board := self boardWith10SpacesWithoutEffects.
	accelerationCard := AccelerationCard new.
	cancellationCard := CancellationCard new.
	deck := Deck
		deterministicWithCardSequence:
			{accelerationCard.
			cancellationCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {1 . 2 . 3 . 4}.
	match := Match
		playedBy:
			{juan.
			jose}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: accelerationCard by: juan.
	self assert: (match cardsAtHandOf: juan) equals: {cancellationCard} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 3.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 4.
	match
		play: cancellationCard
		by: juan
		affecting: accelerationCard.
	self assert: (match cardsAtHandOf: juan) equals: {} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 6.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 8
]

{ #category : #tests }
CardTest >> testPlayerPlaysCancellationCardCancellingOverloadCard [
	| juan board dice deck match overloadCard cancellationCard |
	juan := self playerNamedJuan.
	board := self boardWith10SpacesWithoutEffects.
	overloadCard := OverloadCard new.
	cancellationCard := CancellationCard new.
	deck := Deck
		deterministicWithCardSequence:
			{overloadCard.
			cancellationCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {1 . 2 . 3}.
	match := Match
		playedBy: {juan}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: overloadCard to: juan by: juan.
	self assert: (match cardsAtHandOf: juan) equals: {cancellationCard} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 10.
	match
		play: cancellationCard
		by: juan
		affecting: juan
		andHis: overloadCard.
	self assert: (match cardsAtHandOf: juan) equals: {} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 2
]

{ #category : #tests }
CardTest >> testPlayerPlaysCancellationCardCancellingSpeedCard [
	| juan board dice deck match speedCard cancellationCard |
	juan := self playerNamedJuan.
	board := self boardWith10SpacesWithoutEffects.
	speedCard := SpeedCard new.
	cancellationCard := CancellationCard new.
	deck := Deck
		deterministicWithCardSequence:
			{speedCard.
			cancellationCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {1 . 2 . 3}.
	match := Match
		playedBy: {juan}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: speedCard to: juan by: juan.
	self
		assert: (match cardsAtHandOf: juan)
		equals: {cancellationCard} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 3.
	match
		play: cancellationCard
		by: juan
		affecting: juan
		andHis: speedCard.
	self
		assert: (match cardsAtHandOf: juan)
		equals: {} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 5
]

{ #category : #tests }
CardTest >> testPlayerPlaysOverloadCard [
	| juan jose board dice deck match overloadCard |
	juan := self playerNamedJuan.
	jose := self playerNamedJose.
	board := self boardWith10SpacesWithoutEffects.
	overloadCard := OverloadCard new.
	deck := Deck deterministicWithCardSequence: {overloadCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {2 . 6}.
	match := Match
		playedBy:
			{juan.
			jose}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: overloadCard to: jose by: juan.
	self
		assert: (match cardsAtHandOf: juan)
		equals: {overloadCard} asOrderedCollection.
	match playedBy: juan.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 5
]

{ #category : #tests }
CardTest >> testPlayerPlaysRepeatCard [
	| juan board dice deck match speedCard repeatCard |
	juan := self playerNamedJuan.
	board := Board deterministicWithSpaces: 20 andEffectsGeneratedFrom: {SpeedUpEffect new}.
	speedCard := SpeedCard new.
	repeatCard := RepeatCard new.
	deck := Deck
		deterministicWithCardSequence:
			{speedCard.
			repeatCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {1}.
	match := Match
		playedBy:
			{juan}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 6.
	match play: repeatCard by: juan.
	self assert: (match positionOf: juan) currentSpace equals: 10.
]

{ #category : #tests }
CardTest >> testPlayerPlaysRepeatCardButNoOneThrowedDices [
	| juan board dice deck match repeatCard |
	juan := self playerNamedJuan.
	board := Board deterministicWithSpaces: 20 andEffectsGeneratedFrom: {SpeedUpEffect new}.
	repeatCard := RepeatCard new.
	deck := Deck deterministicWithCardSequence: {repeatCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {1}.
	match := Match
		playedBy: {juan}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: repeatCard by: juan
]

{ #category : #tests }
CardTest >> testPlayerPlaysSpeedCard [
	| juan board dice deck match speedCard |
	juan := self playerNamedJuan.
	board := self boardWith10SpacesWithoutEffects.
	speedCard := SpeedCard new.
	deck := Deck deterministicWithCardSequence: {speedCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {5}.
	match := Match
		playedBy: {juan}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: speedCard to: juan by: juan.
	self assert: (match cardsAtHandOf: juan) equals: {speedCard} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 7
]
