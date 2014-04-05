Scriptname autoDeckUBRotateItem extends ObjectReference

Float Property rotateAmount Auto
Bool Property specialRemove Auto
autoDeckContainerBase Property myShelf Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
  if akNewContainer==Game.getPlayer() && !akOldContainer && specialRemove
	debug.TraceAndBox("In UBRotateItem; item removed: "+self.getName())
 	myShelf.removeItem(self.getBaseObject())
  endIf
endEvent 
