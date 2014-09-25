Scriptname TestAutoDeckTriggerScript extends ObjectReference  
{launches a test of the AutoDeck}

event OnTrigger(ObjectReference triggerActionRef)
	;debug.TraceAndBox("In Trigger")
	autoDeck adRef =  GetLinkedRef() as autoDeck
	;adRef.AddItem( Diamond, 11, false)
	;adRef.AddItem( Shadowmarks, 11, false)
	;adRef.AddItem( Book0DanceInFireV4, 11, false)
endEvent
