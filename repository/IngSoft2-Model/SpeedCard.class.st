Class {
	#name : #SpeedCard,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
SpeedCard >> applyIn: aMatch to: aPlayer [
	aMatch activate: self toBeAppliedTo: aPlayer.
	aMatch updateLastCard: self.
]

{ #category : #applying }
SpeedCard >> cancelAffecting: aPlayer on: aMatch [
	aMatch remove: self affecting: aPlayer
]

{ #category : #applying }
SpeedCard >> spacesToMove [
	^ 1
]
