Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
CardTest >> boardWith10SpacesWithoutEffects [
	^ Board
		withSpaces: 10
		andDeterministicEffectsGeneratedFrom: {NoEffect new}
]

{ #category : #accessing }
CardTest >> playerNamedJose [
	^ Player named: 'Jose'
]

{ #category : #accessing }
CardTest >> playerNamedJuan [
	^ Player named: 'Juan'
]

{ #category : #'tests-permanentCards' }
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
	self assert: (match cardsOf: juan) equals: speedCard asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 3.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 4.
	match playedBy: martin.
	self assert: (match positionOf: martin) currentSpace equals: 5
]

{ #category : #'tests-cancellationCard' }
CardTest >> testPlayerPlaysCancellationCardCancellingACardButNoOnePlayedOne [
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
	self
		should: [ match play: cancellationCard by: juan targeting: accelerationCard ]
		raise: MatchException
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'There is not a ' , accelerationCard className , ' activated' ]
]

{ #category : #'tests-cancellationCard' }
CardTest >> testPlayerPlaysCancellationCardCancellingAccelerationCard [
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
	self assert: (match cardsOf: juan) equals: cancellationCard asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 3.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 4.
	match
		play: cancellationCard
		by: juan
		targeting: accelerationCard.
	self assert: (match cardsOf: juan) isEmpty.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 6.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 8
]

{ #category : #'tests-cancellationCard' }
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
	match play: overloadCard targeting: juan by: juan.
	self assert: (match cardsOf: juan) equals: cancellationCard asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 10.
	self assert: (match positionOf: juan) currentLap equals: -1.
	match
		play: cancellationCard
		by: juan
		targeting: overloadCard.
	self assert: (match cardsOf: juan) isEmpty.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 2
]

{ #category : #'tests-cancellationCard' }
CardTest >> testPlayerPlaysCancellationCardCancellingRedoCard [
	| juan board dice deck match speedCard cancellationCard redoCard |
	juan := self playerNamedJuan.
	board := Board
		withSpaces: 15
		andDeterministicEffectsGeneratedFrom:
			{NoEffect new.
			DealCardEffect new}.
	speedCard := SpeedCard new.
	cancellationCard := CancellationCard new.
	redoCard := RedoCard new.
	deck := Deck
		deterministicWithCardSequence:
			{speedCard.
			redoCard.
			cancellationCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {2 . 3 . 4}.
	match := Match
		playedBy: {juan}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: speedCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 4.
	self assert: (match cardsOf: juan) equals: { redoCard . cancellationCard } asOrderedCollection. 
	match play: redoCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 9.
	match
		play: cancellationCard
		by: juan
		targeting: redoCard.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 14.
]

{ #category : #'tests-cancellationCard' }
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
	match play: speedCard targeting: juan by: juan.
	self assert: (match cardsOf: juan) equals: cancellationCard asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 3.
	match
		play: cancellationCard
		by: juan
		targeting: speedCard.
	self assert: (match cardsOf: juan) isEmpty.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 5
]

{ #category : #'tests-permanentCards' }
CardTest >> testPlayerPlaysOverloadCard [
	| juan jose board dice deck match overloadCard |
	board := self boardWith10SpacesWithoutEffects.
	juan := self playerNamedJuan.
	jose := self playerNamedJose.
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
	match play: overloadCard targeting: jose by: juan.
	self
		assert: (match cardsOf: juan)
		equals: overloadCard asOrderedCollection.
	match playedBy: juan.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 5
]

{ #category : #'tests-redoCard' }
CardTest >> testPlayerPlaysRedoCardButNoCardWasPlayedBefore [
	| juan board dice deck match speedCard redoCard |
	board := self boardWith10SpacesWithoutEffects.
	juan := self playerNamedJuan.
	speedCard := SpeedCard new.
	redoCard := RedoCard new.
	deck := Deck
		deterministicWithCardSequence:
			{speedCard.
			redoCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {2}.
	match := Match
		playedBy: {juan}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: redoCard targeting: juan by: juan.
	self assert: (match cardsOf: juan) equals: speedCard asOrderedCollection
]

{ #category : #'tests-redoCard' }
CardTest >> testPlayerPlaysRedoCardRedoingACancellationCardCancellingASpeedCard [
	| juan jose board dice deck match juanSpeedCard joseSpeedCard cancellationCard redoCard |
	board := self boardWith10SpacesWithoutEffects.
	juan := self playerNamedJuan.
	jose := self playerNamedJose.
	juanSpeedCard := SpeedCard new.
	joseSpeedCard := SpeedCard new.
	redoCard := RedoCard new.
	cancellationCard := CancellationCard new.
	deck := Deck
		deterministicWithCardSequence:
			{juanSpeedCard.
			redoCard.
			joseSpeedCard.
			cancellationCard .
			redoCard
			}.
	dice := Dice deterministicWithFaces: 6 throwing: #(2 3).
	match := Match
		playedBy:
			{juan.
			jose}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: juanSpeedCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 4.
	match play: joseSpeedCard targeting: jose by: jose.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 5.
	match
		play: cancellationCard
		by: jose
		targeting:  juanSpeedCard.
	match
		play: redoCard
		by: juan
		targeting: joseSpeedCard.
	match
		playedBy: juan;
		playedBy: jose.
	self
		assert: (match positionOf: juan) currentSpace equals: 6;
		assert: (match positionOf: jose) currentSpace equals: 8
]

{ #category : #'tests-redoCard' }
CardTest >> testPlayerPlaysRedoCardRedoingACancellationCardCancellingAnAccelerationCard [
	| juan jose board dice deck match juanAccelerationCard joseAccelerationCard cancellationCard redoCard |
	board := self boardWith10SpacesWithoutEffects.
	juan := self playerNamedJuan.
	jose := self playerNamedJose.
	juanAccelerationCard := AccelerationCard new.
	joseAccelerationCard := AccelerationCard new.
	redoCard := RedoCard new.
	cancellationCard := CancellationCard new.
	deck := Deck
		deterministicWithCardSequence:
			{juanAccelerationCard.
			redoCard.
			joseAccelerationCard.
			cancellationCard}.
	dice := Dice deterministicWithFaces: 6 throwing: #(2 3).
	match := Match
		playedBy:
			{juan.
			jose}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: juanAccelerationCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 4.
	match play: joseAccelerationCard targeting: jose by: jose.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 6.
	match play: cancellationCard by: jose targeting: joseAccelerationCard.
	match play: redoCard by: juan targeting: juanAccelerationCard.
	match
		playedBy: juan;
		playedBy: jose.
	self
		assert: (match positionOf: juan) currentSpace equals: 6;
		assert: (match positionOf: jose) currentSpace equals: 9
]

{ #category : #'tests-redoCard' }
CardTest >> testPlayerPlaysRedoCardRedoingARedoCard [
	| juan board dice deck match speedCard firstRedoCard secondRedoCard |
	board := Board withSpaces: 20 andDeterministicEffectsGeneratedFrom: { NoEffect new . DealCardEffect new } .
	juan := self playerNamedJuan.
	speedCard := SpeedCard new.
	firstRedoCard := RedoCard new.
	secondRedoCard := RedoCard new.
	deck := Deck
		deterministicWithCardSequence:
			{firstRedoCard.
			speedCard. secondRedoCard }.
	dice := Dice deterministicWithFaces: 6 throwing: {2}.
	match := Match
		playedBy: {juan}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: speedCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 4.
	match play: firstRedoCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 8.
	match play: secondRedoCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 13.
]

{ #category : #'tests-redoCard' }
CardTest >> testPlayerPlaysRedoCardRedoingARepeatCard [
	| juan board dice deck match repeatCard redoCard |
	board := Board withSpaces: 15 andDeterministicEffectsGeneratedFrom: { SpeedUpEffect new }.
	juan := self playerNamedJuan.
	repeatCard := RepeatCard new.
	redoCard := RedoCard new.
	deck := Deck
		deterministicWithCardSequence:
			{repeatCard.
			redoCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {1 . 2 . 3 . 4}.
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
	match play: redoCard by: juan.
	self assert: (match positionOf: juan) currentSpace equals: 14.

]

{ #category : #'tests-redoCard' }
CardTest >> testPlayerPlaysRedoCardRedoingASpeedCard [
	| juan board dice deck match speedCard redoCard |
	board := self boardWith10SpacesWithoutEffects.
	juan := self playerNamedJuan.
	speedCard := SpeedCard new.
	redoCard := RedoCard new.
	deck := Deck
		deterministicWithCardSequence:
			{speedCard.
			redoCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {2}.
	match := Match
		playedBy: {juan}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: speedCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 4.
	match play: redoCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 8
]

{ #category : #'tests-redoCard' }
CardTest >> testPlayerPlaysRedoCardRedoingAnAccelerationCard [
	| juan board dice deck match accelerationCard redoCard jose |
	board := self boardWith10SpacesWithoutEffects.
	juan := self playerNamedJuan.
	jose := self playerNamedJose.
	accelerationCard := AccelerationCard new.
	redoCard := RedoCard new.
	deck := Deck
		deterministicWithCardSequence:
			{accelerationCard.
			redoCard}.
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
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 3.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 4.
	match play: redoCard by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 8.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 10.
]

{ #category : #'tests-redoCard' }
CardTest >> testPlayerPlaysRedoCardRedoingAnOverloadCard [
	| juan board dice deck match overloadCard redoCard |
	board := self boardWith10SpacesWithoutEffects.
	juan := self playerNamedJuan.
	overloadCard := OverloadCard new.
	redoCard := RedoCard new.
	deck := Deck
		deterministicWithCardSequence:
			{overloadCard.
			redoCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {5}.
	match := Match
		playedBy: {juan}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: overloadCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 4.
	match play: redoCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 5
]

{ #category : #'tests-repeatCard' }
CardTest >> testPlayerPlaysRepeatCard [
	| juan board dice deck match speedCard repeatCard |
	juan := self playerNamedJuan.
	board := Board withSpaces: 20 andDeterministicEffectsGeneratedFrom: {SpeedUpEffect new}.
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

{ #category : #'tests-repeatCard' }
CardTest >> testPlayerPlaysRepeatCardButNoOneThrowedDices [
	| juan board dice deck match repeatCard speedCard |
	juan := self playerNamedJuan.
	board := Board withSpaces: 20 andDeterministicEffectsGeneratedFrom: {SpeedUpEffect new}.
	repeatCard := RepeatCard new.
	speedCard := SpeedCard new.
	deck := Deck
		deterministicWithCardSequence:
			{repeatCard.
			speedCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {1}.
	match := Match
		playedBy: {juan}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: repeatCard by: juan.
	self assert: (match cardsOf: juan) equals: speedCard asOrderedCollection.
	self assert: (match positionOf: juan) currentSpace equals: 1.
	self assert: (match positionOf: juan) currentLap equals: 0
]

{ #category : #'tests-permanentCards' }
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
	match play: speedCard targeting: juan by: juan.
	self assert: (match cardsOf: juan) equals: speedCard asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 7
]

{ #category : #'tests-cancellationCard' }
CardTest >> testPlayerWantsToPlayCancellationCardCancellingAnInstantCard [
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
	self assert: (match cardsOf: juan) equals: {cancellationCard} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 3.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 4.
	match
		play: cancellationCard
		by: juan
		targeting: accelerationCard.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 6.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 8.
	self
		should: [ match play: cancellationCard by: jose targeting: cancellationCard ]
		raise: MatchException
		withExceptionDo:
			[ :exception | self assert: exception messageText equals: 'Cancellation card can only be used affecting a Permantent Card' ]
]
