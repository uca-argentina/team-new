Class {
	#name : #OverloadCard,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
OverloadCard >> applyIn: aMatch to: aPlayer [
	aMatch add: self toBeAppliedTo: aPlayer.
	aMatch updateLastCard: self
]

{ #category : #applying }
OverloadCard >> canceledIn: aMatch [
	aMatch removeActivated: self
]

{ #category : #applying }
OverloadCard >> redoIn: aMatch to: aPlayer by: aRedoCard [
	aMatch add: aRedoCard toBeAppliedTo: aPlayer.
	aMatch updateLastCard: aRedoCard
]

{ #category : #applying }
OverloadCard >> spacesToMove [
	^ -2
]
