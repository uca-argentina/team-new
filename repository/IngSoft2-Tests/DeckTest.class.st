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
