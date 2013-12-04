scriptname autoDeckTriggerContainerScript extends ObjectReference  
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

autoDeckShelfContainerScript Property Books01  Auto  
autoDeckShelfContainerScript Property Books02  Auto  
autoDeckShelfContainerScript Property Books03  Auto  

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

autoDeckContainerBase Property Skulls01  Auto  
autoDeckContainerBase Property Skulls02  Auto  
autoDeckContainerBase Property Skulls03  Auto  

autoDeckContainerBase Property Mixed01  Auto  
autoDeckContainerBase Property Mixed02  Auto  
autoDeckContainerBase Property Mixed03  Auto  

ObjectReference Property OverflowContainer Auto

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

int ItemCounter = 0
int BookCounter = 0
int AddCounter = 0

Form[] inventoryRef = None
autoDeckContainerBase[] refreshList = None

event OnCellLoad()
	OverflowContainer = self
	itemCounter = 0
	BookCounter = 0
	AddCounter = 0
	inventoryRef = new Form[128]
	refreshList = new autoDeckContainerBase[36]

	Books01.OverflowContainer = Books02
	Books02.OverflowContainer = Books03
	Books03.OverflowContainer = Mixed01
endEvent

event OnItemAdded(Form itemBase, int itemCount, ObjectReference itemRef, ObjectReference sourceContainer)
	;debug.TraceAndBox("OnItemAdded(), itemCounter = "+itemCounter)
	; we only need this inventory to keep track of the references in the actual container
	if itemCount > 0
		inventoryRef[itemCounter] = itemBase
		itemCounter += 1
	endif
	
endEvent

event OnItemRemoved(Form itemBase, int itemCount, ObjectReference itemRef, ObjectReference targetContainer)
;	if targetContainer as autoDeckContainerBase
;	else
		int i = self.GetItemCount(itemBase) 
		if i == 0
			int loc = inventoryRef.Find(itemBase) 
			if loc >= 0
				inventoryRef[loc] = None
			endif
		endif
;	endif
			
endEvent

event OnActivate(ObjectReference akActionRef)
	;debug.TraceAndBox("OnActivate(), itemCounter = "+itemCounter)
	refreshList = new autoDeckContainerBase[36]
	self.BlockActivation(true)
	Wait(0.25)
	int itemCount = 0
	Form nextForm = None
	while itemCounter > 0
		nextForm = inventoryRef[itemCounter - 1]

		if nextForm != None
			itemCount = self.GetItemCount(nextForm)
			placeItems(nextForm, itemCount)
		endif

		itemCounter -= 1
	endWhile

	self.BlockActivation(false)

	Wait(4)

	if refreshList.Find(Potions01) >= 0
		Potions01.Activate(self)
	endif
	if refreshList.Find(Potions02) >= 0
		Potions02.Activate(self)
	endif
	if refreshList.Find(Potions03) >= 0
		Potions03.Activate(self)
	endif
	if refreshList.Find(Potions04) >= 0
		Potions04.Activate(self)
	endif
	if refreshList.Find(Potions05) >= 0
		Potions05.Activate(self)
	endif
	if refreshList.Find(Potions06) >= 0
		Potions06.Activate(self)
	endif
	if refreshList.Find(Potions07) >= 0
		Potions07.Activate(self)
	endif

	if refreshList.Find(Books01) >= 0
		Books01.Activate(self)
	endif
	if refreshList.Find(Books02) >= 0
		Wait(3)
		Books02.Activate(self)
	endif
	if refreshList.Find(Books03) >= 0
		Wait(3)
		Books03.Activate(self)
	endif
	
endEvent

function placeItems(Form akActionRef, int itemCount)	
				 
	;debug.TraceAndBox("placeItems(), akActionRef = "+akActionRef.GetName()+", itemCount = "+itemCount)
		bool placed = false;

		if (isIngot(akActionRef))
			placed = true;
			if (Ingots01 && !Ingots01.isFull())
				Ingots01.AddItem(akActionRef, 1, true)
			elseif (Ingots02 && !Ingots02.isFull())
				Ingots02.AddItem(akActionRef, 1, true)
			elseif (Ingots03 && !Ingots03.isFull())
				Ingots03.AddItem(akActionRef, 1, true)
			elseif (Ingots04 && !Ingots04.isFull())
				Ingots04.AddItem(akActionRef, 1, true)
			elseif (Ingots05 && !Ingots05.isFull())
				Ingots05.AddItem(akActionRef, 1, true)
			elseif (Ingots06 && !Ingots06.isFull())
				Ingots06.AddItem(akActionRef, 1, true)
			elseif (Ingots07 && !Ingots07.isFull())
				Ingots07.AddItem(akActionRef, 1, true)
			elseif (Ingots08 && !Ingots08.isFull())
				Ingots08.AddItem(akActionRef, 1, true)
			else
				placed = false;
			endif
		elseif (akActionRef.getName() == "Skull")
			placed = true;
			if (Skulls01 && !Skulls01.isFull())
				Skulls01.AddItem(akActionRef, 1, true)
			else
				placed = false
			endif
		elseif (akActionRef.HasKeyword(VendorItemJewelry))
			placed = true
			if (Jewelry01 && !Jewelry01.isFull())
				Jewelry01.AddItem(akActionRef, 1, true)
				;Jewelry01.Activate(akActionRef)
			elseif (Jewelry02 )
				Jewelry02.AddItem(akActionRef, 1, true)
				;Jewelry02.Activate(akActionRef)
			else
				placed = false
			endif
		elseif (isGem(akActionRef))
			placed = true
			if (Gems01 && !Gems01.isFull())
				Gems01.AddItem(akActionRef, 1, true)
				;Gems01.Activate(akActionRef)
			elseif (Gems02 && !Gems02.isFull())
				Gems02.AddItem(akActionRef, 1, true)
				;Gems02.Activate(akActionRef)
			else
				placed = false
			endif
		elseif (isSoulGem(akActionRef))
			placed = true
			if (SoulGems01 && !SoulGems01.isFull())
				SoulGems01.AddItem(akActionRef, 1, true)
				;SoulGems01.Activate(akActionRef)
			elseif (SoulGems02 && !SoulGems02.isFull())
				SoulGems02.AddItem(akActionRef, 1, true)
				;SoulGems02.Activate(akActionRef)
			else
				placed = false
			endif
		elseif (isScroll(akActionRef))
			placed = true
			if (Scrolls01 && !Scrolls01.isFull())
				Scrolls01.AddItem(akActionRef, 1, true)
				;Scrolls01.Activate(akActionRef)
			elseif (Scrolls02 && !Scrolls02.isFull())
				Scrolls02.AddItem(akActionRef, 1, true)
				;Scrolls02.Activate(akActionRef)
			else
				placed = false
			endif
		elseif (isPotion(akActionRef))
			placed = true
			if (Potions01 && !Potions01.isFull())
				placeItem(Potions01, akActionRef, itemCount) 
				;Potions01.AddItem(akActionRef, 1, true)
			elseif (Potions02 && !Potions02.isFull())
				placeItem(Potions02, akActionRef, itemCount) 
				;Potions02.AddItem(akActionRef, 1, true)
			elseif (Potions03 && !Potions03.isFull())
				placeItem(Potions03, akActionRef, itemCount) 
				;Potions03.AddItem(akActionRef, 1, true)
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
			elseif (Potions09 && !Potions09.isFull())
				Potions09.AddItem(akActionRef, 1, true)
			else
				placed = false
			endif
		elseif(isSpellBook(akActionRef))
			placed = placeBookOnShelf(Books03, akActionRef, itemCount)
		elseif (isBook(akActionRef))
			placed = placeBookOnShelf(Books01, akActionRef, itemCount)

		        if !placed
		 		placed = placeBookOnShelf(Books02, akActionRef, itemCount)		
			endif

		        if !placed
		 		placed = placeBookOnShelf(Books03, akActionRef, itemCount)		
			endif
		endif
		
		; If we could not find a special shelf for the item 
		; then just put it on one of the general shelves
		if (!placed) 
			if (Table01 && !Table01.isFull())
				placed = true
				Table01.AddItem(akActionRef, 1, true)
				;Table01.Activate(akActionRef)
			elseif (Table02 && !Table02.isFull())
				placed = true
				Table02.AddItem(akActionRef, 1, true)
				;Table02.Activate(akActionRef)
			elseif (Mixed01 && !Mixed01.isFull())
				placed = true
				Mixed01.AddItem(akActionRef, 1, true)
				;Mixed01.Activate(akActionRef)
			elseif (Mixed02 && !Mixed02.isFull())
				placed = true
				Mixed02.AddItem(akActionRef, 1, true)
				;Mixed02.Activate(akActionRef)
			elseif (Mixed03 && !Mixed03.isFull())
				placed = true
				Mixed03.AddItem(akActionRef, 1, true)
				;Mixed03.Activate(akActionRef)
			endif
   
		endif

		; if we still don't have a place for the item
		; then give it back to the player
		if !placed
			Game.GetPlayer().AddItem(akActionRef, 1, false)
		endif
		
endFunction
 
bool function placeBookOnShelf(autoDeckShelfContainerScript targetShelf, Form aBook, int itemCount)  
		;debug.TraceAndBox("placeBookOnShelf, targetShelf = "+targetShelf)
	if (targetShelf && !targetShelf.isFull())
		;BookCounter += itemCount
		;AddCounter += itemCount

		;int i = refreshList.Find(targetShelf)  

		;if (i < 0)
			;i = refreshList.Find(None)
			;refreshList[i] = targetShelf
		;endif
			
		;targetShelf.OverflowContainer = OverflowContainer
		;debug.TraceAndBox("placeBookOnShelf, AddCounter = "+AddCounter)
		;return bookShelf.addToContainer(aBook)
		;bookShelf.Activate(aBook)
		;self.RemoveItem(aBook, itemCount, true, targetShelf)
		placeItem(targetShelf, aBook, itemCount)
		return true
	else
		return false	
	endif
endFunction

function placeItem(autoDeckContainerBase targetShelf, Form itemType, int itemCount)
	int i = refreshList.Find(targetShelf)  

	if (i < 0)
		i = refreshList.Find(None)
		refreshList[i] = targetShelf
	endif

	self.RemoveItem(itemType, itemCount, true, targetShelf)
endFunction

bool function isBook(Form akActionRef)

	if (akActionRef.HasKeyword(VendorItemBook))
		return true
	else
		return (akActionRef as Book)
	endif
	
endFunction

bool function isSpellBook(Form akActionRef)

	if (akActionRef.HasKeyword(VendorItemSpellTome))
		return true
	else
		return false
	endif
	
endFunction

bool function isIngot(Form akActionRef)

	if akActionRef.HasKeyword(VendorItemOreIngot) 
		return true
	else
		return false 
	endif
	
endFunction

bool function isPotion(Form akActionRef)
	if (akActionRef.HasKeyword(VendorItemPotion) || akActionRef.HasKeyword(VendorItemPoison))
		return true
	else
		return (akActionRef as Potion) 
	endif

endFunction

bool function isGem(Form akActionRef)

	if (akActionRef.HasKeyword(VendorItemGem))
		return true
	else
		return false;
	endif
	
endFunction

bool function isSoulGem(Form akActionRef)

	if (akActionRef.HasKeyword(VendorItemSoulGem))
		return true
	else
		return (akActionRef as SoulGem)
	endif
	
endFunction

bool function isScroll(Form akActionRef)

	if (akActionRef.HasKeyword(VendorItemScroll))
		return true
	else
		return (akActionRef as Scroll)
	endif
	
endFunction
