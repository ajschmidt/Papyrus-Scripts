Scriptname organizeClutter extends ObjectReference  
{Sorts clutter onto shelves}
import debug
import utility

autoDeckContainerBase Property Potions01  Auto  
autoDeckContainerBase Property Potions02  Auto  
autoDeckContainerBase Property Potions03  Auto  
autoDeckContainerBase Property Potions04  Auto  
autoDeckContainerBase Property Potions05  Auto  
autoDeckContainerBase Property Potions06  Auto  
autoDeckContainerBase Property Potions07  Auto  
autoDeckContainerBase Property Potions08  Auto  
autoDeckContainerBase Property Potions09  Auto  

autoDeckContainerBase Property Ingots01  Auto  
autoDeckContainerBase Property Ingots02  Auto  
autoDeckContainerBase Property Ingots03  Auto  
autoDeckContainerBase Property Ingots04  Auto  
autoDeckContainerBase Property Ingots05  Auto  
autoDeckContainerBase Property Ingots06  Auto  
autoDeckContainerBase Property Ingots07  Auto  
autoDeckContainerBase Property Ingots08  Auto  

autoDeckContainerBase Property Books01  Auto  
autoDeckContainerBase Property Books02  Auto  
autoDeckContainerBase Property Books03  Auto  

autoDeckContainerBase Property Gems01  Auto  
autoDeckContainerBase Property Gems02  Auto  

autoDeckContainerBase Property SoulGems01  Auto  
autoDeckContainerBase Property SoulGems02  Auto  

autoDeckContainerBase Property Scrolls01  Auto  
autoDeckContainerBase Property Scrolls02  Auto  

autoDeckContainerBase Property Jewelry01  Auto  
autoDeckContainerBase Property Jewelry02  Auto  

autoDeckContainerBase Property Table01  Auto  
autoDeckContainerBase Property Table02  Auto  

Keyword Property VendorItemPotion  Auto 
Keyword Property VendorItemPoison  Auto 
Keyword Property VendorItemBook  Auto 
Keyword Property VendorItemOreIngot  Auto 
Keyword Property VendorItemGem  Auto 
Keyword Property VendorItemJewelry  Auto 
Keyword Property VendorItemClutter  Auto 
Keyword Property VendorItemAnimalHide  Auto 
Keyword Property VendorItemDaedricArtifact  Auto 
Keyword Property VendorItemFood  Auto 
Keyword Property VendorItemScroll  Auto 
Keyword Property VendorItemSoulGem  Auto 
Keyword Property VendorItemSpellTome  Auto 
Keyword Property VendorItemTool  Auto 

Event OnTriggerEnter(ObjectReference akActionRef)
	if (akActionRef != Game.getPlayer())
		;debug.TraceAndBox("Name: "+akActionRef.getBaseObject().getName()+", Type: "+akActionRef.getBaseObject().getType()+", Form ID: "+akActionRef.getBaseObject().getFormID())
		if (isIngot(akActionRef))
			if (Ingots01 && !Ingots01.isFull())
				Ingots01.AddItem(akActionRef, 1, true)
			elseif (Ingots02 && !Ingots02.isFull())
				Ingots02.AddItem(akActionRef, 1, true)
				;Ingots02.Activate(akActionRef)
			elseif (Ingots03 && !Ingots03.isFull())
				Ingots03.AddItem(akActionRef, 1, true)
				;Ingots03.Activate(akActionRef)
			elseif (Ingots04 && !Ingots04.isFull())
				Ingots04.AddItem(akActionRef, 1, true)
				;Ingots04.Activate(akActionRef)
			elseif (Ingots05 && !Ingots05.isFull())
				Ingots05.AddItem(akActionRef, 1, true)
				;Ingots05.Activate(akActionRef)
			elseif (Ingots06 && !Ingots06.isFull())
				Ingots06.AddItem(akActionRef, 1, true)
				;Ingots06.Activate(akActionRef)
			elseif (Ingots07 && !Ingots07.isFull())
				Ingots07.AddItem(akActionRef, 1, true)
				;Ingots07.Activate(akActionRef)
			elseif (Ingots08)
				Ingots08.AddItem(akActionRef, 1, true)
				;Ingots08.Activate(akActionRef)
			endif
		elseif (akActionRef.getBaseObject().getName() == "Skull")
			if (Table02 )
				Table02.AddItem(akActionRef, 1, true)
				Table02.Activate(akActionRef)
			endif
		elseif (akActionRef.HasKeyword(VendorItemJewelry))
			if (Jewelry01 && !Jewelry01.isFull())
				Jewelry01.AddItem(akActionRef, 1, true)
				Jewelry01.Activate(akActionRef)
			elseif (Jewelry02 )
				Jewelry02.AddItem(akActionRef, 1, true)
				Jewelry02.Activate(akActionRef)
			endif
		elseif (isGem(akActionRef))
			if (Gems01 && !Gems01.isFull())
				Gems01.AddItem(akActionRef, 1, true)
				Gems01.Activate(akActionRef)
			elseif (Gems02 && !Gems02.isFull())
				Gems02.AddItem(akActionRef, 1, true)
				Gems02.Activate(akActionRef)
			endif
		elseif (isSoulGem(akActionRef))
			if (SoulGems01 && !SoulGems01.isFull())
				SoulGems01.AddItem(akActionRef, 1, true)
				SoulGems01.Activate(akActionRef)
			elseif (SoulGems02 && !SoulGems02.isFull())
				SoulGems02.AddItem(akActionRef, 1, true)
				SoulGems02.Activate(akActionRef)
			endif
		elseif (isScroll(akActionRef))
			if (Scrolls01 && !Scrolls01.isFull())
				Scrolls01.AddItem(akActionRef, 1, true)
				Scrolls01.Activate(akActionRef)
			elseif (Scrolls02 && !Scrolls02.isFull())
				Scrolls02.AddItem(akActionRef, 1, true)
				Scrolls02.Activate(akActionRef)
			endif
		elseif (isPotion(akActionRef))
			if (Potions01 && !Potions01.isFull())
				Potions01.AddItem(akActionRef, 1, true)
			elseif (Potions02 && !Potions02.isFull())
				Potions02.AddItem(akActionRef, 1, true)
			elseif (Potions03 && !Potions03.isFull())
				Potions03.AddItem(akActionRef, 1, true)
			elseif (Potions04 && !Potions04.isFull())
				Potions04.AddItem(akActionRef, 1, true)
			elseif (Potions05 && !Potions05.isFull())
				Potions05.AddItem(akActionRef, 1, true)
			elseif (Potions06 && !Potions06.isFull())
				Potions06.AddItem(akActionRef, 1, true)
			elseif (Potions07 && !Potions07.isFull())
				Potions07.AddItem(akActionRef, 1, true)
			elseif (Potions08 && !Potions08.isFull())
				Potions08.AddItem(akActionRef, 1, true)
			elseif (Potions09)
				Potions09.AddItem(akActionRef, 1, true)
			endif
		elseif(isSpellBook(akActionRef))
			if (Books03)
				Books03.AddItem(akActionRef,1,true)
				Books03.Activate(akActionRef)
			endif
		elseif (isBook(akActionRef))
			if (Books01 && !Books01.isFull())
				Books01.AddItem(akActionRef, 1, true)
				Books01.Activate(akActionRef)
			elseif (Books02 && !Books02.isFull())
				Books02.AddItem(akActionRef, 1, true)
				Books02.Activate(akActionRef)
			elseif (Books03)
				Books03.AddItem(akActionRef, 1, true)
				Books03.Activate(akActionRef)
			endif
		else 
			if (Table01 && !Table01.isFull())
				Table01.AddItem(akActionRef, 1, true)
				Table01.Activate(akActionRef)
			endif
   
		endif
	endif
EndEvent
 
;Event OnTriggerLeave(ObjectReference akActionRef)
	;if (akActionRef == Game.getPlayer())
			;if (Potions01)
      				;Potions01.Activate(akActionRef)
			;endif
			;if (Potions02)
      				;Potions02.Activate(akActionRef)
			;endif
			;if (Potions03)
      				;Potions03.Activate(akActionRef)
			;endif
			;if (Potions04)
      				;Potions04.Activate(akActionRef)
			;endif
;			if (Potions05)
;      				Potions05.Activate(akActionRef)
;			endif
;			if (Potions06)
;      				Potions06.Activate(akActionRef)
;			endif
			;elseif (Potions07 && !Potions07.isFull())
				;Potions07.AddItem(akActionRef, 1, true)
      				;Potions07.Activate(akActionRef)
			;elseif (Potions08 && !Potions08.isFull())
				;Potions08.AddItem(akActionRef, 1, true)
      				;Potions08.Activate(akActionRef)
			;elseif (Potions09)
				;Potions09.AddItem(akActionRef, 1, true)
      				;Potions09.Activate(akActionRef)
			;endif
		
	;endif
;endEvent

bool Function isBook(ObjectReference akActionRef)

	if (akActionRef.HasKeyword(VendorItemBook))
		return true
	else
		return (akActionRef.GetBaseObject() as Book)
	endif
	
endFunction

bool Function isSpellBook(ObjectReference akActionRef)

	if (akActionRef.GetBaseObject().HasKeyword(VendorItemSpellTome))
		return true
	else
		return false
	endif
	
endFunction

bool Function isIngot(ObjectReference akActionRef)

	if (akActionRef.GetBaseObject().HasKeyword(VendorItemOreIngot) || akActionRef.HasKeyword(VendorItemOreIngot))
		return true
	else
		return false 
	endif
	
endFunction

bool Function isPotion(ObjectReference akActionRef)
	if (akActionRef.HasKeyword(VendorItemPotion) || akActionRef.HasKeyword(VendorItemPoison))
		return true
	else
		return (akActionRef.GetBaseObject() as Potion) 
	endif

endFunction

bool Function isGem(ObjectReference akActionRef)

	if (akActionRef.GetBaseObject().HasKeyword(VendorItemGem))
		return true
	else
		return false;
	endif
	
endFunction

bool Function isSoulGem(ObjectReference akActionRef)

	if (akActionRef.HasKeyword(VendorItemSoulGem))
		return true
	else
		return (akActionRef.GetBaseObject() as SoulGem)
	endif
	
endFunction

bool Function isScroll(ObjectReference akActionRef)

	if (akActionRef.GetBaseObject().HasKeyword(VendorItemScroll))
		return true
	else
		return (akActionRef.GetBaseObject() as Scroll)
	endif
	
endFunction
