Class {
	#name : #PermanentCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
PermanentCard >> cancelAffecting: aPlayer on: aMatch [
	self subclassResponsibility
]

{ #category : #applying }
PermanentCard >> needs: aNextPlayer toBeTurnOf: anAffecterPlayer [
	aNextPlayer = anAffecterPlayer
		ifFalse: [ MatchException signal: 'A player can only play a permanent card in his turn' ]
]
