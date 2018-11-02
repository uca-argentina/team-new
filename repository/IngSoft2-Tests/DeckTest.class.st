Class {
	#name : #DeckTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DeckTest >> testDealingCardFromDeckWithDeterministicStrategy [
	| deck overloadCard speedCard |
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	deck := Deck
		deterministicWithCardSequence:
			{overloadCard.
			speedCard}.
	self assert: deck dealCard equals: overloadCard
]

{ #category : #tests }
DeckTest >> testDealingCardFromDeckWithRandomStrategy [
	| deck card |
	deck := Deck random.
	card := deck dealCard class.
	self
		assert:
			(card = OverloadCard
				or: [ card = SpeedCard
						or: [ card = RepeatCard or: [ card = RedoCard or: [ card = CancellationCard or: [ card = AccelerationCard ] ] ] ] ])
]
