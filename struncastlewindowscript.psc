Scriptname struncastlewindowscript extends ObjectReference  
{Enables/Disables lower windows when trying to
view out the upper windows}
import debug
import utility

Bool Property AlreadyLoaded = FALSE auto hidden


EVENT OnCellLoad()
	if AlreadyLoaded == FALSE
		DisableLinkChain()
		AlreadyLoaded = TRUE
	endif
endEVENT


EVENT OnTriggerEnter(ObjectReference TriggerRef)
	;Trace("DARYL - " + self + " Reference " + TriggerRef + " has ENTERED")
	if TriggerRef != Game.getPlayer()
		return
	endIf
	ObjectReference first = GetLinkedRef()
	first.Enable()
	first.EnableLinkChain()
endEvent

EVENT OnTriggerLeave(ObjectReference TriggerRef)
	if TriggerRef != Game.getPlayer()
		return
	endIf
	ObjectReference first = GetLinkedRef()
	first.Disable()
	first.DisableLinkChain()
endEvent
