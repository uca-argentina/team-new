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
	self
		assert: deck dealCard equals: overloadCard;
		assert: deck dealCard equals: speedCard;
		assert: deck dealCard equals: overloadCard
]

{ #category : #tests }
DeckTest >> testDealingCardFromDeckWithRandomStrategy [
	| deck card |
	deck := Deck random.
	card := deck dealCard.
	self
		assert:
			(card class = OverloadCard
				or: [ card class = SpeedCard
						or: [ card class = RepeatCard
								or: [ card class = RedoCard or: [ card class = CancellationCard or: [ card class = AccelerationCard ] ] ] ] ])
]
