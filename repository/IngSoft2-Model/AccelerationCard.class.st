Class {
	#name : #AccelerationCard,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
AccelerationCard >> applyBy: aPlayer in: aMatch [ 
	aMatch players do: [ :player | aMatch activate: self toBeAppliedTo: player ].
]

{ #category : #applying }
AccelerationCard >> spacesToMove [
	^1
]
