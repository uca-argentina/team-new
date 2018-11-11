Class {
	#name : #PermanentCard,
	#superclass : #CardBehavior,
	#category : #'IngSoft2-Model'
}

{ #category : #description }
PermanentCard >> assertingNextPlayerIn: aMatch is: aPlayer [
	aMatch nextPlayer = aPlayer
		ifFalse: [ MatchException signal: 'A player can only play a permanent card in his turn' ]
]

{ #category : #moving }
PermanentCard >> spacesToMove [
	self subclassResponsibility
]
