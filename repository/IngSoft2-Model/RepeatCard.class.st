Class {
	#name : #RepeatCard,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
RepeatCard >> applyBy: aPlayer in: aMatch [
	aMatch lastEffect turnOnEffectAt: aMatch activatedBy: aPlayer
]
