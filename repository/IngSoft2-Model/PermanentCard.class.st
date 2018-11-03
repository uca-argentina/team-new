Class {
	#name : #PermanentCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
PermanentCard >> needs: aNextPlayer ToBeTurnOf: anAffecterPlayer [
	aNextPlayer = anAffecterPlayer
		ifFalse: [ AssertionFailure signal: 'A player only can play a permanent card in his turn' ]
]

{ #category : #applying }
PermanentCard >> playedTo: aPlayer in: aMatch [ 
	aMatch add: self toBeAppliedTo: aPlayer
]
