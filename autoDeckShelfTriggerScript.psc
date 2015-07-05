Scriptname autoDeckShelfTriggerScript extends ObjectReference  

import debug
import utility

ObjectReference Property ShelfContainer Auto 
Bool Property AlreadyLoaded = FALSE Auto 


event OnCellLoad()
	if AlreadyLoaded == FALSE
		ShelfContainer = GetLinkedRef()
		AlreadyLoaded = TRUE
	endif
endEvent


auto state WaitForBooks

	event OnBeginState()
		;Trace(self + " BOOKTRIGGER - Waiting For Books!")
	endEvent

	event OnTriggerEnter(ObjectReference TriggerRef)
		;Trace("DARYL - " + self + " Reference " + TriggerRef + " has ENTERED")

	endEvent

	event OnTriggerLeave(ObjectReference TriggerRef)
		; Reference has left this trigger
		if GetParentCell().IsAttached()
			;Trace("DARYL - " + self + " Reference " + TriggerRef + " has EXITED")
			if (TriggerRef == Game.GetPlayerGrabbedRef())
				; Check to see if the player is holding it
				;Trace("DARYL - " + self + " Player has a hold of this reference, do nothing")
			else
				; Player isnt' grabbing this reference, check to see if it's in the container.
				if Shelfcontainer.GetItemCount(TriggerRef.GetBaseObject()) >= 1
					;debug.TraceAndBox("In Trigger Script; Item Removed: "+TriggerRef.GetName())
					Shelfcontainer.RemoveItem(TriggerRef.GetBaseObject(), 1)
					;(Shelfcontainer as autoDeckContainerBase).CurrentBookAmount = (Shelfcontainer as autoDeckContainerBase).CurrentBookAmount - 1
					;(ShelfContainer as autoDeckContainerBase).RemoveBooks((TriggerRef.GetBaseObject()), 1)
				else
				; There is no book based on this form in the container
					;Trace("DARYL - " + self + " Container doesn't contain this book")
				endif
			endif
		endif
	endEvent

endState


state IgnoreBooks
	event OnBeginState()
		;Trace(self + " BOOKTRIGGER - Ignoring Books!")
	endEvent
endState
