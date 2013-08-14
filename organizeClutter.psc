Scriptname organizeClutter extends ObjectReference  
{Sorts clutter onto shelves}

autoDeckShelfContainerScript Property Potions01  Auto  
autoDeckShelfContainerScript Property Potions02  Auto  
autoDeckShelfContainerScript Property Potions03  Auto  
autoDeckShelfContainerScript Property Potions04  Auto  
autoDeckShelfContainerScript Property Potions05  Auto  
autoDeckShelfContainerScript Property Potions06  Auto  
autoDeckShelfContainerScript Property Potions07  Auto  
autoDeckShelfContainerScript Property Potions08  Auto  
autoDeckShelfContainerScript Property Potions09  Auto  

autoDeckShelfContainerScript Property Ingots01  Auto  
autoDeckShelfContainerScript Property Ingots02  Auto  
autoDeckShelfContainerScript Property Ingots03  Auto  
autoDeckShelfContainerScript Property Ingots04  Auto  
autoDeckShelfContainerScript Property Ingots05  Auto  
autoDeckShelfContainerScript Property Ingots06  Auto  
autoDeckShelfContainerScript Property Ingots07  Auto  
autoDeckShelfContainerScript Property Ingots08  Auto  

autoDeckShelfContainerScript Property Books01  Auto  
autoDeckShelfContainerScript Property Books02  Auto  
autoDeckShelfContainerScript Property Books03  Auto  

autoDeckShelfContainerScript Property Gems01  Auto  
autoDeckShelfContainerScript Property Gems02  Auto  

autoDeckShelfContainerScript Property SoulGems01  Auto  
autoDeckShelfContainerScript Property SoulGems02  Auto  

autoDeckShelfContainerScript Property Scrolls01  Auto  
autoDeckShelfContainerScript Property Scrolls02  Auto  

autoDeckShelfContainerScript Property Jewelry01  Auto  
autoDeckShelfContainerScript Property Jewelry02  Auto  

autoDeckShelfContainerScript Property Table01  Auto  
autoDeckShelfContainerScript Property Table02  Auto  

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
    ;debug.TraceAndBox("OnTriggerEnter, akActionRef: "+akActionRef)
		if (isPotion(akActionRef))
			if (Potions01 && !Potions01.isFull())
				Potions01.AddItem(akActionRef, 1, true)
      				Potions01.Activate(akActionRef)
			elseif (Potions02 && !Potions02.isFull())
				Potions02.AddItem(akActionRef, 1, true)
      				Potions02.Activate(akActionRef)
			elseif (Potions03 && !Potions03.isFull())
				Potions03.AddItem(akActionRef, 1, true)
      				Potions03.Activate(akActionRef)
			elseif (Potions04 && !Potions04.isFull())
				Potions04.AddItem(akActionRef, 1, true)
      				Potions04.Activate(akActionRef)
			elseif (Potions05 && !Potions05.isFull())
				Potions05.AddItem(akActionRef, 1, true)
      				Potions05.Activate(akActionRef)
			elseif (Potions06 && !Potions06.isFull())
				Potions06.AddItem(akActionRef, 1, true)
      				Potions06.Activate(akActionRef)
			elseif (Potions07 && !Potions07.isFull())
				Potions07.AddItem(akActionRef, 1, true)
      				Potions07.Activate(akActionRef)
			elseif (Potions08 && !Potions08.isFull())
				Potions08.AddItem(akActionRef, 1, true)
      				Potions08.Activate(akActionRef)
			elseif (Potions09)
				Potions09.AddItem(akActionRef, 1, true)
      				Potions09.Activate(akActionRef)
			endif
		elseif (isIngot(akActionRef))
			if (Ingots01 && !Ingots01.isFull())
				Ingots01.AddItem(akActionRef, 1, true)
				Ingots01.Activate(akActionRef)
			elseif (Ingots02 && !Ingots02.isFull())
				Ingots02.AddItem(akActionRef, 1, true)
				Ingots02.Activate(akActionRef)
			elseif (Ingots03 && !Ingots03.isFull())
				Ingots03.AddItem(akActionRef, 1, true)
				Ingots03.Activate(akActionRef)
			elseif (Ingots04 && !Ingots04.isFull())
				Ingots04.AddItem(akActionRef, 1, true)
				Ingots04.Activate(akActionRef)
			elseif (Ingots05 && !Ingots05.isFull())
				Ingots05.AddItem(akActionRef, 1, true)
				Ingots05.Activate(akActionRef)
			elseif (Ingots06 && !Ingots06.isFull())
				Ingots06.AddItem(akActionRef, 1, true)
				Ingots06.Activate(akActionRef)
			elseif (Ingots07 && !Ingots07.isFull())
				Ingots07.AddItem(akActionRef, 1, true)
				Ingots07.Activate(akActionRef)
			elseif (Ingots08)
				Ingots08.AddItem(akActionRef, 1, true)
				Ingots08.Activate(akActionRef)
			endif
		elseif (akActionRef.HasKeyword(VendorItemBook))
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
		elseif(akActionRef.HasKeyword(VendorItemSpellTome))
			if (Books03)
				Books03.AddItem(akActionRef,1,true)
				Books03.Activate(akActionRef)
			endif
		elseif (akActionRef.HasKeyword(VendorItemGem))
			if (Gems01 && !Gems01.isFull())
				Gems01.AddItem(akActionRef, 1, true)
				Gems01.Activate(akActionRef)
			elseif (Gems02 && !Gems02.isFull())
				Gems02.AddItem(akActionRef, 1, true)
				Gems02.Activate(akActionRef)
			endif
		elseif (akActionRef.HasKeyword(VendorItemGem))
			if (SoulGems01 && !SoulGems01.isFull())
				SoulGems01.AddItem(akActionRef, 1, true)
				SoulGems01.Activate(akActionRef)
			elseif (SoulGems02 && !SoulGems02.isFull())
				SoulGems02.AddItem(akActionRef, 1, true)
				SoulGems02.Activate(akActionRef)
			endif
		elseif (akActionRef.HasKeyword(VendorItemScroll))
			if (Scrolls01 && !Scrolls01.isFull())
				Scrolls01.AddItem(akActionRef, 1, true)
				Scrolls01.Activate(akActionRef)
			elseif (Scrolls02 && !Scrolls02.isFull())
				Scrolls02.AddItem(akActionRef, 1, true)
				Scrolls02.Activate(akActionRef)
			endif
		elseif (akActionRef.HasKeyword(VendorItemJewelry))
			if (Jewelry01 && !Jewelry01.isFull())
				Jewelry01.AddItem(akActionRef, 1, true)
				Jewelry01.Activate(akActionRef)
			elseif (Jewelry02 )
				Jewelry02.AddItem(akActionRef, 1, true)
				Jewelry02.Activate(akActionRef)
			endif
		else 
			if (Table01 && !Table01.isFull())
				Table01.AddItem(akActionRef, 1, true)
				Table01.Activate(akActionRef)
			elseif (Table02 )
				Table02.AddItem(akActionRef, 1, true)
				Table02.Activate(akActionRef)
			endif
   
		endif
	endif
EndEvent
 
bool Function isIngot(ObjectReference akActionRef)

    return (akActionRef.HasKeyword(VendorItemOreIngot))
endFunction

bool Function isPotion(ObjectReference akActionRef)
    return (akActionRef.HasKeyword(VendorItemPotion) || akActionRef.HasKeyword(VendorItemPoison))
endFunction

