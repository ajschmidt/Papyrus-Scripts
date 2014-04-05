scriptname autoDeck extends ObjectReference  
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
autoDeckContainerBase Property Potions10  Auto  
autoDeckContainerBase Property Potions11  Auto  
autoDeckContainerBase Property Potions12  Auto  

autoDeckContainerBase Property Ingots01  Auto  
autoDeckContainerBase Property Ingots02  Auto  
autoDeckContainerBase Property Ingots03  Auto  
autoDeckContainerBase Property Ingots04  Auto  
autoDeckContainerBase Property Ingots05  Auto  
autoDeckContainerBase Property Ingots06  Auto  
autoDeckContainerBase Property Ingots07  Auto  
autoDeckContainerBase Property Ingots08  Auto  
autoDeckContainerBase Property Ingots09  Auto  
autoDeckContainerBase Property Ingots10  Auto  
autoDeckContainerBase Property Ingots11  Auto  
autoDeckContainerBase Property Ingots12  Auto  

autoDeckShelfContainerScript Property Books01  Auto  
autoDeckShelfContainerScript Property Books02  Auto  
autoDeckShelfContainerScript Property Books03  Auto  

autoDeckContainerBase Property Gems01  Auto  
autoDeckContainerBase Property Gems02  Auto  
autoDeckContainerBase Property Gems03  Auto  

autoDeckContainerBase Property SoulGems01  Auto  
autoDeckContainerBase Property SoulGems02  Auto  

autoDeckContainerBase Property Scrolls01  Auto  
autoDeckContainerBase Property Scrolls02  Auto  

autoDeckContainerBase Property Jewelry01  Auto  
autoDeckContainerBase Property Jewelry02  Auto  
autoDeckContainerBase Property Jewelry03  Auto  
autoDeckContainerBase Property Jewelry04  Auto  

autoDeckContainerBase Property Dishes01  Auto  
autoDeckContainerBase Property Dishes02  Auto  

autoDeckContainerBase Property Skulls01  Auto  
autoDeckContainerBase Property Skulls02  Auto  
autoDeckContainerBase Property Skulls03  Auto  

autoDeckContainerBase Property Tall01  Auto  
autoDeckContainerBase Property Tall02  Auto  
autoDeckContainerBase Property Tall03  Auto  
autoDeckContainerBase Property Tall04  Auto  
autoDeckContainerBase Property Tall05  Auto  
autoDeckContainerBase Property Tall06  Auto  

autoDeckContainerBase Property TrollSkulls01  Auto  
autoDeckContainerBase Property TrollSkulls02  Auto  
autoDeckContainerBase Property TrollSkulls03  Auto  

autoDeckContainerBase Property Mixed01  Auto  
autoDeckContainerBase Property Mixed02  Auto  
autoDeckContainerBase Property Mixed03  Auto  
autoDeckContainerBase Property Mixed04  Auto  
autoDeckContainerBase Property Mixed05  Auto  
autoDeckContainerBase Property Mixed06  Auto  
autoDeckContainerBase Property Mixed07  Auto  
autoDeckContainerBase Property Mixed08  Auto  
autoDeckContainerBase Property Mixed09  Auto  
autoDeckContainerBase Property Mixed10  Auto  
autoDeckContainerBase Property Mixed11  Auto  
autoDeckContainerBase Property Mixed12  Auto  
autoDeckContainerBase Property Mixed13  Auto  
autoDeckContainerBase Property Mixed14  Auto  
autoDeckContainerBase Property Mixed15  Auto  
autoDeckContainerBase Property Mixed16  Auto  
autoDeckContainerBase Property Mixed17  Auto  
autoDeckContainerBase Property Mixed18  Auto  
autoDeckContainerBase Property Mixed19  Auto  
autoDeckContainerBase Property Mixed20  Auto  
autoDeckContainerBase Property Mixed21  Auto  
autoDeckContainerBase Property Mixed22  Auto  

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

int BookCounter = 0
int AddCounter = 0

Form[] inventoryRef = None
autoDeckContainerBase[] refreshList = None

event OnCellLoad()
	OverflowContainer = self
	BookCounter = 0
	AddCounter = 0
	inventoryRef = new Form[128]
	refreshList = new autoDeckContainerBase[56]

	Books01.OverflowContainer = OverflowContainer
	Books02.OverflowContainer = OverflowContainer
	Books03.OverflowContainer = OverflowContainer
	Mixed01.OverflowContainer = OverflowContainer
	Mixed02.OverflowContainer = OverflowContainer
	Mixed03.OverflowContainer = OverflowContainer
	Mixed04.OverflowContainer = OverflowContainer
	Mixed05.OverflowContainer = OverflowContainer
	Mixed06.OverflowContainer = OverflowContainer
	Mixed07.OverflowContainer = OverflowContainer
	Mixed08.OverflowContainer = OverflowContainer
	Mixed09.OverflowContainer = OverflowContainer
	Mixed10.OverflowContainer = OverflowContainer
	Mixed11.OverflowContainer = OverflowContainer
	Mixed12.OverflowContainer = OverflowContainer
	Mixed13.OverflowContainer = OverflowContainer
	Mixed14.OverflowContainer = OverflowContainer
	Mixed15.OverflowContainer = OverflowContainer
	Mixed16.OverflowContainer = OverflowContainer
	Mixed17.OverflowContainer = OverflowContainer
	Mixed18.OverflowContainer = OverflowContainer
	Mixed19.OverflowContainer = OverflowContainer
	Mixed20.OverflowContainer = OverflowContainer
	Mixed21.OverflowContainer = OverflowContainer
	Mixed22.OverflowContainer = OverflowContainer
	Ingots01.OverflowContainer = OverflowContainer
	Ingots02.OverflowContainer = OverflowContainer
	Ingots03.OverflowContainer = OverflowContainer
	Ingots04.OverflowContainer = OverflowContainer
	Ingots05.OverflowContainer = OverflowContainer
	Ingots06.OverflowContainer = OverflowContainer
	Ingots07.OverflowContainer = OverflowContainer
	Ingots08.OverflowContainer = OverflowContainer
	Ingots09.OverflowContainer = OverflowContainer
	Ingots10.OverflowContainer = OverflowContainer
	Ingots11.OverflowContainer = OverflowContainer
	Ingots12.OverflowContainer = OverflowContainer
	Gems01.OverflowContainer = OverflowContainer
	Gems02.OverflowContainer = OverflowContainer
	Gems03.OverflowContainer = OverflowContainer
	SoulGems01.OverflowContainer = OverflowContainer
	SoulGems02.OverflowContainer = OverflowContainer
	Jewelry01.OverflowContainer = OverflowContainer
	Jewelry02.OverflowContainer = OverflowContainer
	Jewelry03.OverflowContainer = OverflowContainer
	Jewelry04.OverflowContainer = OverflowContainer
	Dishes01.OverflowContainer = OverflowContainer
	Dishes02.OverflowContainer = OverflowContainer
	Skulls01.OverflowContainer = OverflowContainer
	Skulls02.OverflowContainer = OverflowContainer
	Skulls03.OverflowContainer = OverflowContainer
	Tall01.OverflowContainer = OverflowContainer
	Tall02.OverflowContainer = OverflowContainer
	Tall03.OverflowContainer = OverflowContainer
	Tall04.OverflowContainer = OverflowContainer
	Tall05.OverflowContainer = OverflowContainer
	Tall06.OverflowContainer = OverflowContainer
	TrollSkulls01.OverflowContainer = OverflowContainer
	TrollSkulls02.OverflowContainer = OverflowContainer
	TrollSkulls03.OverflowContainer = OverflowContainer
endEvent

event OnItemAdded(Form itemBase, int itemCount, ObjectReference itemRef, ObjectReference sourceContainer)
	; we only need this inventory to keep track of the references in the actual container
	;debug.TraceAndBox("OnItemAdded(), itemCount = "+itemCount+", existing = "+inventoryRef.Find(itemBase))
	if itemCount > 0 && inventoryRef.Find(itemBase) < 0
		int i = inventoryRef.Find(None)
	;debug.TraceAndBox("OnItemAdded(), next index = "+i)
		inventoryRef[i] = itemBase
	endif
	
endEvent

event OnItemRemoved(Form itemBase, int itemCount, ObjectReference itemRef, ObjectReference targetContainer)
;	if targetContainer as autoDeckContainerBase
;	else
; THIS METHOD NEEDS WORK
		int i = self.GetItemCount(itemBase) 
		if i < 1 
			int loc = inventoryRef.Find(itemBase) 
			if loc >= 0
				inventoryRef[loc] = None
			endif
		endif
;	endif
			
endEvent

event OnActivate(ObjectReference akActionRef)
	;debug.TraceAndBox("OnActivate(), formCounter = "+formCounter)
	self.BlockActivation(true)
	refreshList = new autoDeckContainerBase[56]
	Wait(0.25)
	bool again = false
	int itemCount = 0
	Form nextForm = None
	int end = inventoryRef.Find(None)

	if end < 0 
		end = 128
	endif

	int index = 0
	while index < end
	;debug.TraceAndBox("OnActivate(), end = "+end)
		nextForm = inventoryRef[index]

		if nextForm != None ;we shouldn't need this check. Remove it later
			itemCount = self.GetItemCount(nextForm)
	;debug.TraceAndBox("OnActivate(), form = "+nextForm.getName()+", itemCount = "+itemCount)
			int blockCount = 0

			; Place no more than 128 items at a time 
			while itemCount > 0
				if itemCount > 128
					blockCount = 128
				else
					blockCount = itemCount
				endif

				placeItems(nextForm, blockCount)

				itemCount -= blockCount
			endwhile

			again = TRUE
		endif
	
		;inventoryRef[index] = None
		index += 1
	endWhile

	Wait(2)
	end = refreshList.Find(None)

	if end < 0 
		end = 56
	endif

	index = 0
	ObjectReference adContainer = None

	while index < end
		adContainer = refreshList[index]
		adContainer.Activate(self)
		Wait(02)
		index += 1
	endWhile
	
	self.BlockActivation(false)
	if again 
		Wait(02)
		self.Activate(self)
	endif
endEvent

function placeItems(Form akActionRef, int itemCount)	
				 
	;int kw = akActionRef.GetNumKeywords()
	;while kw > 0
		;kw -= 1
		;debug.TraceAndBox(akActionRef.GetNthKeyword(kw))
	;endWhile
		

	if itemCount < 1 || akActionRef == None
		return
	endif

	bool placed = false;

	if (isIngot(akActionRef))
		placed = true;
		if (Ingots01 && !Ingots01.isFull())
			placeItem(Ingots01, akActionRef, itemCount) 
		elseif (Ingots02 && !Ingots02.isFull())
			placeItem(Ingots02, akActionRef, itemCount) 
		elseif (Ingots03 && !Ingots03.isFull())
			placeItem(Ingots03, akActionRef, itemCount) 
		elseif (Ingots04 && !Ingots04.isFull())
			placeItem(Ingots04, akActionRef, itemCount) 
		elseif (Ingots05 && !Ingots05.isFull())
			placeItem(Ingots05, akActionRef, itemCount) 
		elseif (Ingots06 && !Ingots06.isFull())
			placeItem(Ingots06, akActionRef, itemCount) 
		elseif (Ingots07 && !Ingots07.isFull())
			placeItem(Ingots07, akActionRef, itemCount) 
		elseif (Ingots08 && !Ingots08.isFull())
			placeItem(Ingots08, akActionRef, itemCount) 
		elseif (Ingots09 && !Ingots09.isFull())
			placeItem(Ingots09, akActionRef, itemCount) 
		elseif (Ingots10 && !Ingots10.isFull())
			placeItem(Ingots10, akActionRef, itemCount) 
		elseif (Ingots11 && !Ingots11.isFull())
			placeItem(Ingots11, akActionRef, itemCount) 
		elseif (Ingots12 && !Ingots12.isFull())
			placeItem(Ingots12, akActionRef, itemCount) 
		else
			placed = false;
		endif
	elseif (akActionRef.getName() == "Skull")
		placed = true;
		if (Skulls01 && !Skulls01.isFull())
			placeItem(Skulls01, akActionRef, itemCount) 
		elseif (Skulls02 && !Skulls02.isFull())
			placeItem(Skulls02, akActionRef, itemCount) 
		elseif (Skulls03 && !Skulls03.isFull())
			placeItem(Skulls03, akActionRef, itemCount) 
		else
			placed = false
		endif
	elseif (akActionRef.getName() == "Troll Skull")
		placed = true;
		if (TrollSkulls01 && !TrollSkulls01.isFull())
			placeItem(TrollSkulls01, akActionRef, itemCount) 
		elseif (TrollSkulls02 && !TrollSkulls02.isFull())
			placeItem(TrollSkulls02, akActionRef, itemCount) 
		elseif (TrollSkulls03 && !TrollSkulls03.isFull())
			placeItem(TrollSkulls03, akActionRef, itemCount) 
		else
			placed = false
		endif
	elseif (akActionRef.HasKeyword(VendorItemJewelry))
		placed = true
		if (Jewelry01 && !Jewelry01.isFull())
			placeItem(Jewelry01, akActionRef, itemCount) 
		elseif (Jewelry02 && !Jewelry02.isFull())
			placeItem(Jewelry02, akActionRef, itemCount) 
		elseif (Jewelry03 && !Jewelry03.isFull())
			placeItem(Jewelry03, akActionRef, itemCount) 
		elseif (Jewelry04 && !Jewelry04.isFull())
			placeItem(Jewelry04, akActionRef, itemCount) 
		else
			placed = false
		endif
	elseif (isGem(akActionRef))
		placed = true
		if (Gems01 && !Gems01.isFull())
			placeItem(Gems01, akActionRef, itemCount) 
		elseif (Gems02 && !Gems02.isFull())
			placeItem(Gems02, akActionRef, itemCount) 
		elseif (Gems03 && !Gems03.isFull())
			placeItem(Gems03, akActionRef, itemCount) 
		else
			placed = false
		endif
	elseif (isSoulGem(akActionRef))
		placed = true
		if (SoulGems01 && !SoulGems01.isFull())
			placeItem(SoulGems01, akActionRef, itemCount) 
		elseif (SoulGems02 && !SoulGems02.isFull())
			placeItem(SoulGems02, akActionRef, itemCount) 
		else
			placed = false
		endif
	elseif (isScroll(akActionRef))
		placed = true
		if (Scrolls01 && !Scrolls01.isFull())
			placeItem(Scrolls01, akActionRef, itemCount) 
		elseif (Scrolls02 && !Scrolls02.isFull())
			placeItem(Scrolls02, akActionRef, itemCount) 
		else
			placed = false
		endif
	elseif (isPotion(akActionRef))
		placed = true
		if (Potions01 && !Potions01.isFull())
			placeItem(Potions01, akActionRef, itemCount) 
		elseif (Potions02 && !Potions02.isFull())
			placeItem(Potions02, akActionRef, itemCount) 
		elseif (Potions03 && !Potions03.isFull())
			placeItem(Potions03, akActionRef, itemCount) 
		elseif (Potions04 && !Potions04.isFull())
			placeItem(Potions04, akActionRef, itemCount) 
		elseif (Potions05 && !Potions05.isFull())
			placeItem(Potions05, akActionRef, itemCount) 
		elseif (Potions06 && !Potions06.isFull())
			placeItem(Potions06, akActionRef, itemCount) 
		elseif (Potions07 && !Potions07.isFull())
			placeItem(Potions07, akActionRef, itemCount) 
		elseif (Potions08 && !Potions08.isFull())
			placeItem(Potions08, akActionRef, itemCount) 
		elseif (Potions09 && !Potions09.isFull())
			placeItem(Potions09, akActionRef, itemCount) 
		elseif (Potions10 && !Potions10.isFull())
			placeItem(Potions10, akActionRef, itemCount) 
		elseif (Potions11 && !Potions11.isFull())
			placeItem(Potions11, akActionRef, itemCount) 
		elseif (Potions12 && !Potions12.isFull())
			placeItem(Potions12, akActionRef, itemCount) 
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
	elseif (isTall(akActionRef))
		placed = true
		if (Tall01 && !Tall01.isFull())
			placeItem(Tall01, akActionRef, itemCount) 
		elseif (Tall02 && !Tall02.isFull())
			placeItem(Tall02, akActionRef, itemCount) 
		elseif (Tall03 && !Tall03.isFull())
			placeItem(Tall03, akActionRef, itemCount) 
		elseif (Tall04 && !Tall04.isFull())
			placeItem(Tall04, akActionRef, itemCount) 
		elseif (Tall05 && !Tall05.isFull())
			placeItem(Tall05, akActionRef, itemCount) 
		elseif (Tall06 && !Tall06.isFull())
			placeItem(Tall06, akActionRef, itemCount) 
		else
			placed = false
		endif
	endif
	
	; If we could not find a special shelf for the item 
	; then just put it on one of the general shelves
	if (!placed) 
		placed = true
		if (Mixed01 && !Mixed01.isFull())
			placeItem(Mixed01, akActionRef, itemCount) 
		elseif (Mixed02 && !Mixed02.isFull())
			placeItem(Mixed02, akActionRef, itemCount) 
		elseif (Mixed03 && !Mixed03.isFull())
			placeItem(Mixed03, akActionRef, itemCount) 
		elseif (Mixed04 && !Mixed04.isFull())
			placeItem(Mixed04, akActionRef, itemCount) 
		elseif (Mixed05 && !Mixed05.isFull())
			placeItem(Mixed05, akActionRef, itemCount) 
		elseif (Mixed06 && !Mixed06.isFull())
			placeItem(Mixed06, akActionRef, itemCount) 
		elseif (Mixed07 && !Mixed07.isFull())
			placeItem(Mixed07, akActionRef, itemCount) 
		elseif (Mixed08 && !Mixed08.isFull())
			placeItem(Mixed08, akActionRef, itemCount) 
		elseif (Mixed09 && !Mixed09.isFull())
			placeItem(Mixed09, akActionRef, itemCount) 
		elseif (Mixed10 && !Mixed10.isFull())
			placeItem(Mixed10, akActionRef, itemCount) 
		elseif (Mixed11 && !Mixed11.isFull())
			placeItem(Mixed11, akActionRef, itemCount) 
		elseif (Mixed12 && !Mixed12.isFull())
			placeItem(Mixed12, akActionRef, itemCount) 
		elseif (Mixed13 && !Mixed13.isFull())
			placeItem(Mixed13, akActionRef, itemCount) 
		elseif (Mixed14 && !Mixed14.isFull())
			placeItem(Mixed14, akActionRef, itemCount) 
		elseif (Mixed15 && !Mixed15.isFull())
			placeItem(Mixed15, akActionRef, itemCount) 
		elseif (Mixed16 && !Mixed16.isFull())
			placeItem(Mixed16, akActionRef, itemCount) 
		elseif (Mixed17 && !Mixed17.isFull())
			placeItem(Mixed17, akActionRef, itemCount) 
		elseif (Mixed18 && !Mixed18.isFull())
			placeItem(Mixed18, akActionRef, itemCount) 
		elseif (Mixed19 && !Mixed19.isFull())
			placeItem(Mixed19, akActionRef, itemCount) 
		elseif (Mixed20 && !Mixed20.isFull())
			placeItem(Mixed20, akActionRef, itemCount) 
		elseif (Mixed21 && !Mixed21.isFull())
			placeItem(Mixed21, akActionRef, itemCount) 
		elseif (Mixed22 && !Mixed22.isFull())
			placeItem(Mixed22, akActionRef, itemCount) 
		else
			placed = false
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
	endif
	refreshList[i] = targetShelf
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
	;debug.TraceAndBox("isIngot, akActionRef = "+akActionRef.GetName()+", HasKeyword = "+akActionRef.HasKeyword(VendorItemOreIngot))

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

bool function isTall(Form akActionRef)
debug.trace("isTall() Name: "+akActionRef.getName()+", FormID: "+akActionRef.getFormID())
	int[] formIds = new int[27]
	int i = 0
        formIds[i] = 985329
	i += 1
        formIds[i] = 549676
	i += 1
        formIds[i] = 760798
	i += 1
        formIds[i] = 760790
	i += 1
        formIds[i] = 624163
	i += 1
        formIds[i] = 985335
	i += 1
        formIds[i] = 985334
	i += 1
        formIds[i] = 154878
	i += 1
        formIds[i] = 760788
	i += 1
        formIds[i] = 760786
	i += 1
        formIds[i] = 1100906
	i += 1
        formIds[i] = 895915
	i += 1
        formIds[i] = 549434
	i += 1
        formIds[i] = 155004
	i += 1
        formIds[i] = 703792
	i += 1
        formIds[i] = 104788
	i += 1
        formIds[i] = 282222
	i += 1
        formIds[i] = 588183
	i += 1
        formIds[i] = 444911
	i += 1
        formIds[i] = 405338
	i += 1
        formIds[i] = 138915
	i += 1
        formIds[i] = 114197
	i += 1
        formIds[i] = 77804
	i += 1
        formIds[i] = 77803
	i += 1
        formIds[i] = 77802
	i += 1
        formIds[i] = 77801
	i += 1
        formIds[i] = 77800
	
	if (containsInt(akActionRef.getFormID(), 27, formIds))
		return true
	else
		return false
	endif
endFunction

bool function containsInt(int find, int size, int[] ids)
	int i = 0
	while i < size
		if find == ids[i]
			return true
		endif
		i += 1
	endWhile
	return false
endFunction
