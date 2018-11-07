Class {
	#name : #RepeatCard,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
RepeatCard >> applyIn: aMatch to: aPlayer [
	aMatch lastEffect value turnOnEffectAt: aMatch activatedBy: aMatch lastEffect key.
	aMatch updateLastCard: self.
]
