Scriptname struncastleDisableScript extends ObjectReference  
{Disables objects when triggered, enables otherwise}
import debug
import utility

Bool Property AlreadyLoaded = FALSE auto hidden


EVENT OnCellLoad()
	if AlreadyLoaded == FALSE
		EnableLinkChain()
		AlreadyLoaded = TRUE
	endif
endEVENT


EVENT OnTriggerEnter(ObjectReference TriggerRef)
	;TraceAndBox("DARYL - " + self + " Reference " + TriggerRef + " has ENTERED")
	if TriggerRef != Game.getPlayer()
		return
	endIf
	DisableLinkChain()
endEvent

EVENT OnTriggerLeave(ObjectReference TriggerRef)
	if TriggerRef != Game.getPlayer()
		return
	endIf
	EnableLinkChain()
endEvent
