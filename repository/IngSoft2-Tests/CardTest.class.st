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
	self assert: (match cardsOf: juan) equals: speedCard asOrderedCollection.
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
	self assert: (match cardsOf: juan) equals: {cancellationCard} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 3.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 4.
	match
		play: cancellationCard
		by: juan
		affecting: juan
		andHis: accelerationCard.
	self assert: (match cardsOf: juan) isEmpty.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 6.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 8
]

{ #category : #tests }
CardTest >> testPlayerPlaysCancellationCardCancellatingACardButNoOnePlayedOne [
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
		should: [ match play: cancellationCard by: juan affecting: accelerationCard ]
		raise: MatchException 
		withExceptionDo: [ :exception | 
			self
				assert: exception messageText
				equals: 'There is not a card ' , accelerationCard className , ' affecting ' , juan name ]
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
	self assert: (match cardsOf: juan) equals: cancellationCard asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 3.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 4.
	match
		play: cancellationCard
		by: juan
		affecting: accelerationCard.
	self assert: (match cardsOf: juan) isEmpty.
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
	match play: overloadCard targeting: juan by: juan.
	self assert: (match cardsOf: juan) equals: cancellationCard asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 10.
	match
		play: cancellationCard
		by: juan
		affecting: juan
		andHis: overloadCard.
	self assert: (match cardsOf: juan) isEmpty.
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
	match play: speedCard targeting: juan by: juan.
	self
		assert: (match cardsOf: juan)
		equals: cancellationCard asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 3.
	match
		play: cancellationCard
		by: juan
		affecting: juan
		andHis: speedCard.
	self
		assert: (match cardsOf: juan) isEmpty.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 5
]

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
CardTest >> testPlayerPlaysRedoCardRedoingACancellationCardCancellatingASpeedCard [
	| juan jose board dice deck match speedCard cancellationCard redoCard |
	board := self boardWith10SpacesWithoutEffects.
	juan := self playerNamedJuan.
	jose := self playerNamedJose.
	speedCard := SpeedCard new.
	redoCard := RedoCard new.
	cancellationCard := CancellationCard new.
	deck := Deck
		deterministicWithCardSequence:
			{speedCard.
			redoCard.
			cancellationCard }.
	dice := Dice deterministicWithFaces: 6 throwing: #(2 3).
	match := Match
		playedBy: {juan . jose}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: speedCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 4.
	match play: speedCard targeting: jose by: jose.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 5.
	match play: cancellationCard by: jose affecting: juan andHis: speedCard.
	match play: redoCard by: juan affecting: jose andHis: speedCard. 
	match playedBy: juan;
			playedBy: jose.
	self assert: (match positionOf: juan) currentSpace equals: 6;
		  assert: (match positionOf: jose) currentSpace equals: 8.
]

{ #category : #tests }
CardTest >> testPlayerPlaysRedoCardRedoingACancellationCardCancellatingAnAccelerationCard [
	| juan jose board dice deck match accelerationCard cancellationCard redoCard |
	board := self boardWith10SpacesWithoutEffects.
	juan := self playerNamedJuan.
	jose := self playerNamedJose.
	accelerationCard := AccelerationCard new.
	redoCard := RedoCard new.
	cancellationCard := CancellationCard new.
	deck := Deck
		deterministicWithCardSequence:
			{accelerationCard.
			redoCard.
			cancellationCard }.
	dice := Dice deterministicWithFaces: 6 throwing: #(2 3).
	match := Match
		playedBy: {juan . jose}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: accelerationCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 4.
	match play: accelerationCard targeting: jose by: jose.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 6.
	match play: cancellationCard by: jose affecting: accelerationCard.
	match play: redoCard by: juan affecting: accelerationCard. 
	match playedBy: juan;
			playedBy: jose.
	self assert: (match positionOf: juan) currentSpace equals: 6;
		  assert: (match positionOf: jose) currentSpace equals: 9.
]

{ #category : #tests }
CardTest >> testPlayerPlaysRedoCardRedoingARedoCard [
	| juan board dice deck match speedCard redoCard |
	board := Board deterministicWithSpaces: 20 andEffectsGeneratedFrom: { NoEffect new . DealCardEffect new } .
	juan := self playerNamedJuan.
	speedCard := SpeedCard new.
	redoCard := RedoCard new.
	deck := Deck
		deterministicWithCardSequence:
			{redoCard.
			speedCard}.
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
	self assert: (match positionOf: juan) currentSpace equals: 8.
	match play: redoCard targeting: juan by: juan.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 13.
]

{ #category : #tests }
CardTest >> testPlayerPlaysRedoCardRedoingARepeatCard [
	| juan board dice deck match repeatCard redoCard |
	board := Board deterministicWithSpaces: 15 andEffectsGeneratedFrom: { SpeedUpEffect new }.
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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
	| juan board dice deck match repeatCard speedCard |
	juan := self playerNamedJuan.
	board := Board deterministicWithSpaces: 20 andEffectsGeneratedFrom: {SpeedUpEffect new}.
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
	match play: speedCard targeting: juan by: juan.
	self assert: (match cardsOf: juan) equals: speedCard asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 7
]
