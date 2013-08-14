Scriptname autoDeckUBRotateItem extends ObjectReference

Float Property rotateAmount Auto
Bool Property specialRemove Auto
autoDeckShelfContainerScript Property myShelf Auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
  if akNewContainer==Game.getPlayer() && !akOldContainer && specialRemove
    myShelf.removeItem(self.getBaseObject())
  endIf
endEvent 
