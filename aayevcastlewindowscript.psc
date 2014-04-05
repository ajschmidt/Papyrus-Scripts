Scriptname aayevcastlewindowscript extends ObjectReference  
{Trigger for to turn on windows when the player enters the room.}
import debug
import utility

int Property WindowCnt = 0 auto 
ObjectReference[] Property Windows auto hidden
Bool Property AlreadyLoaded = FALSE auto hidden


EVENT OnCellLoad()
	if AlreadyLoaded == FALSE
		Windows = new ObjectReference[10]
		int wIndex = WindowCnt - 1
		while wIndex >= 0
			Windows[wIndex] = GetNthLinkedRef(wIndex)
			wIndex -= 1
		endWhile
		AlreadyLoaded = TRUE
	endif
endEVENT


EVENT OnTriggerEnter(ObjectReference TriggerRef)
	;Trace("DARYL - " + self + " Reference " + TriggerRef + " has ENTERED")
	if TriggerRef != Game.getPlayer()
		return
	endIf
	int wIndex = WindowCnt - 1
	while wIndex >= 0
traceandbox("Trigger Enter: "+Windows[wIndex])
		Windows[wIndex].Enable()
		wIndex -= 1
	endWhile
endEvent

EVENT OnTriggerLeave(ObjectReference TriggerRef)
	if TriggerRef != Game.getPlayer()
		return
	endIf
	int wIndex = WindowCnt - 1
	while wIndex >= 0
		Windows[wIndex].Disable()
		wIndex -= 1
	endWhile
endEvent
