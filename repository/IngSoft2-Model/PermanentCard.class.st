Class {
	#name : #PermanentCard,
	#superclass : #CardBehavior,
	#category : #'IngSoft2-Model'
}

{ #category : #moving }
PermanentCard >> affectDiceRoll: aRoll [
	self subclassResponsibility
]

{ #category : #description }
PermanentCard >> assertCanBePlayedBy: aPlayer in: aMatch [
	aMatch nextPlayer = aPlayer
		ifFalse: [ MatchException signal: 'A player can only play a permanent card in his turn' ]
]

{ #category : #cancelling }
PermanentCard >> cancelledIn: aMatch [
	aMatch removeActivated: self
]
