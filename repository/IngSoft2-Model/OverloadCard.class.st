Class {
	#name : #OverloadCard,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
OverloadCard >> applyIn: aMatch to: aPlayer [
	aMatch activate: self toBeAppliedTo: aPlayer.
	aMatch updateLastCard: self.
]

{ #category : #applying }
OverloadCard >> cancelAffecting: aPlayer on: aMatch [
	aMatch remove: self affecting: aPlayer
]

{ #category : #applying }
OverloadCard >> spacesToMove [
	^ -2
]
