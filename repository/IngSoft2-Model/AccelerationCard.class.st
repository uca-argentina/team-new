Class {
	#name : #AccelerationCard,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
AccelerationCard >> applyIn: aMatch to: aPlayer [
	aMatch players do: [ :player | aMatch add: self toBeAppliedTo: player ].
	aMatch updateLastCard: self.
]

{ #category : #applying }
AccelerationCard >> cancelAffecting: aPlayer on: aMatch [
	aMatch players do: [ :player | aMatch remove: self affecting: player ]
]

{ #category : #applying }
AccelerationCard >> spacesToMove [
	^ 1
]
