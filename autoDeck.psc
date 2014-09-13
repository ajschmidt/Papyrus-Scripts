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
autoDeckContainerBase[] PotionContainers =  None

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
autoDeckContainerBase[] IngotContainers =  None

autoDeckContainerBase Property Books01  Auto  
autoDeckContainerBase Property Books02  Auto  
autoDeckContainerBase Property Books03  Auto  
autoDeckContainerBase[] BookContainers =  None

autoDeckContainerBase Property Gems01  Auto  
autoDeckContainerBase Property Gems02  Auto  
autoDeckContainerBase Property Gems03  Auto  
autoDeckContainerBase[] GemContainers =  None

autoDeckContainerBase Property SoulGems01  Auto  
autoDeckContainerBase Property SoulGems02  Auto  
autoDeckContainerBase[] SoulGemContainers =  None

autoDeckContainerBase Property Scrolls01  Auto  
autoDeckContainerBase Property Scrolls02  Auto  
autoDeckContainerBase[] ScrollContainers =  None

autoDeckContainerBase Property Jewelry01  Auto  
autoDeckContainerBase Property Jewelry02  Auto  
autoDeckContainerBase Property Jewelry03  Auto  
autoDeckContainerBase Property Jewelry04  Auto  
autoDeckContainerBase[] JewelryContainers =  None

autoDeckContainerBase Property Dishes01  Auto  
autoDeckContainerBase Property Dishes02  Auto  

autoDeckContainerBase Property Skulls01  Auto  
autoDeckContainerBase Property Skulls02  Auto  
autoDeckContainerBase Property Skulls03  Auto  
autoDeckContainerBase[] SkullContainers =  None

autoDeckContainerBase Property Tall01  Auto  
autoDeckContainerBase Property Tall02  Auto  
autoDeckContainerBase Property Tall03  Auto  
autoDeckContainerBase Property Tall04  Auto  
autoDeckContainerBase Property Tall05  Auto  
autoDeckContainerBase Property Tall06  Auto  
autoDeckContainerBase[] TallContainers =  None

autoDeckContainerBase Property TrollSkulls01  Auto  
autoDeckContainerBase Property TrollSkulls02  Auto  
autoDeckContainerBase Property TrollSkulls03  Auto  
autoDeckContainerBase[] TrollSkullContainers =  None

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
autoDeckContainerBase[] MixedContainers =  None

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
int MaxItems = 640
int TotalItems = 0

Form[] inventoryRef = None
autoDeckContainerBase[] refreshList = None

event OnCellLoad()
	OverflowContainer = self
	BookCounter = 0
	AddCounter = 0
	inventoryRef = new Form[128]
	refreshList = new autoDeckContainerBase[128]
	initBookContainers()
	initMixedContainers()
	initPotionContainers()
	initIngotContainers()
	initGemContainers()
	initSoulGemContainers()
	initJewelryContainers()
	initScrollContainers()
	Dishes01.OverflowContainer = OverflowContainer
	Dishes02.OverflowContainer = OverflowContainer
	initSkullContainers()
	initTallContainers()
	initTrollSkullContainers()
endEvent

function initPotionContainers()
	PotionContainers =  new autoDeckContainerBase[12]
	PotionContainers[0] = Potions01
	PotionContainers[1] = Potions02
	PotionContainers[2] = Potions03
	PotionContainers[3] = Potions04
	PotionContainers[4] = Potions05
	PotionContainers[5] = Potions06
	PotionContainers[6] = Potions07
	PotionContainers[7] = Potions08
	PotionContainers[8] = Potions09
	PotionContainers[9] = Potions10
	PotionContainers[10] = Potions11
	PotionContainers[11] = Potions12
	setOverflowContainer(PotionContainers)
endFunction

function initMixedContainers()
	MixedContainers =  new autoDeckContainerBase[22]
	MixedContainers[0] = Mixed01
	MixedContainers[1] = Mixed02
	MixedContainers[2] = Mixed03
	MixedContainers[3] = Mixed04
	MixedContainers[4] = Mixed05
	MixedContainers[5] = Mixed06
	MixedContainers[6] = Mixed07
	MixedContainers[7] = Mixed08
	MixedContainers[8] = Mixed09
	MixedContainers[9] = Mixed10
	MixedContainers[10] = Mixed11
	MixedContainers[11] = Mixed12
	MixedContainers[12] = Mixed13
	MixedContainers[13] = Mixed14
	MixedContainers[14] = Mixed15
	MixedContainers[15] = Mixed16
	MixedContainers[16] = Mixed17
	MixedContainers[17] = Mixed18
	MixedContainers[18] = Mixed19
	MixedContainers[19] = Mixed20
	MixedContainers[20] = Mixed21
	MixedContainers[21] = Mixed22
	setOverflowContainer(MixedContainers)
endFunction

function initIngotContainers()
	IngotContainers =  new autoDeckContainerBase[12]
	IngotContainers[0] = Ingots01
	IngotContainers[1] = Ingots02
	IngotContainers[2] = Ingots03
	IngotContainers[3] = Ingots04
	IngotContainers[4] = Ingots05
	IngotContainers[5] = Ingots06
	IngotContainers[6] = Ingots07
	IngotContainers[7] = Ingots08
	IngotContainers[8] = Ingots09
	IngotContainers[9] = Ingots10
	IngotContainers[10] = Ingots11
	IngotContainers[11] = Ingots12
	setOverflowContainer(IngotContainers)
endFunction

function initBookContainers()
	BookContainers =  new autoDeckContainerBase[3]
	BookContainers[0] = Books01
	BookContainers[1] = Books02
	BookContainers[2] = Books03
	setOverflowContainer(BookContainers)
endFunction

function initGemContainers()
	GemContainers =  new autoDeckContainerBase[3]
	GemContainers[0] = Gems01
	GemContainers[1] = Gems02
	GemContainers[2] = Gems03
	setOverflowContainer(GemContainers)
endFunction

function initSoulGemContainers()
	SoulGemContainers =  new autoDeckContainerBase[2]
	SoulGemContainers[0] = SoulGems01
	SoulGemContainers[1] = SoulGems02
	setOverflowContainer(SoulGemContainers)
endFunction

function initScrollContainers()
	ScrollContainers =  new autoDeckContainerBase[2]
	ScrollContainers[0] = Scrolls01
	ScrollContainers[1] = Scrolls02
	setOverflowContainer(ScrollContainers)
endFunction

function initSkullContainers()
	SkullContainers =  new autoDeckContainerBase[3]
	SkullContainers[0] = Skulls01
	SkullContainers[1] = Skulls02
	SkullContainers[2] = Skulls03
	setOverflowContainer(SkullContainers)
endFunction

function initJewelryContainers()
	JewelryContainers =  new autoDeckContainerBase[4]
	JewelryContainers[0] = Jewelry01
	JewelryContainers[1] = Jewelry02
	JewelryContainers[2] = Jewelry03
	JewelryContainers[3] = Jewelry04
	setOverflowContainer(JewelryContainers)
endFunction

function initTrollSkullContainers()
	TrollSkullContainers =  new autoDeckContainerBase[3]
	TrollSkullContainers[0] = TrollSkulls01
	TrollSkullContainers[1] = TrollSkulls02
	TrollSkullContainers[2] = TrollSkulls03
	setOverflowContainer(TrollSkullContainers)
endFunction

function initTallContainers()
	TallContainers =  new autoDeckContainerBase[6]
	TallContainers[0] = Tall01
	TallContainers[1] = Tall02
	TallContainers[2] = Tall03
	TallContainers[3] = Tall04
	TallContainers[4] = Tall05
	TallContainers[5] = Tall06
	setOverflowContainer(TallContainers)
endFunction

function setOverflowContainer(autoDeckContainerBase[] containers)
	int index = containers.length - 1
	while index >= 0
		containers[index].OverflowContainer = self
		index -= 1
	endWhile 
endFunction

event OnItemAdded(Form itemBase, int itemCount, ObjectReference itemRef, ObjectReference sourceContainer)
	; we only need this inventory to keep track of the references in the actual container
	;debug.TraceAndBox("OnItemAdded(), itemCount = "+itemCount+", existing = "+inventoryRef.Find(itemBase))
	TotalItems += itemCount
	int diff = TotalItems - MaxItems
	if diff > 0
		Notification("Add more after the AutoDeck is finished.")
		Notification("You can only place a maximum of "+MaxItems+" items at once.")
		RemoveItem(itemBase, diff, false, Game.getPlayer())
		itemCount -= diff
	endif
	if itemCount > 0 && inventoryRef.Find(itemBase) < 0
		int i = inventoryRef.Find(None)
	;debug.TraceAndBox("OnItemAdded(), next index = "+i)
		inventoryRef[i] = itemBase
	endif
	
endEvent

event OnItemRemoved(Form itemBase, int itemCount, ObjectReference itemRef, ObjectReference targetContainer)
	TotalItems -= itemCount
	int i = self.GetItemCount(itemBase) 
	if i < 1 
		int loc = inventoryRef.Find(itemBase) 
		if loc >= 0
			inventoryRef[loc] = None
		endif
	endif
			
endEvent

event OnActivate(ObjectReference akActionRef)
	;debug.TraceAndBox("OnActivate(), formCounter = "+formCounter)
	self.BlockActivation(true)
	refreshList = new autoDeckContainerBase[128]
	Wait(0.25)
	bool again = false
	int itemCount = 0
	Form nextForm = None
	int end = inventoryRef.Find(None)
	int totalCount = 0
	end = 128

	int index = 0
	while index < end
	;debug.TraceAndBox("OnActivate(), end = "+end)
		nextForm = inventoryRef[index]

		if nextForm != None 
			itemCount = self.GetItemCount(nextForm)
	;debug.TraceAndBox("inventoryRef["+index+"], form = "+nextForm.getName()+", itemCount = "+itemCount)
			int blockCount = 0

			; Place no more than 128 items at a time 
			while itemCount > 0
				if itemCount > 128
					blockCount = 128
				else
					blockCount = itemCount
				endif

				placeItems(nextForm, blockCount, totalCount % 4)
				itemCount -= blockCount
				totalCount += blockCount
			endwhile

			again = TRUE
		endif
	
		;inventoryRef[index] = None
		index += 1
	endWhile

	Wait(2)
	end = 128
	index = 0
	ObjectReference adContainer = None

	while index < end
		adContainer = refreshList[index]

		if adContainer != None
			adContainer.Activate(self)
			Wait(05)
		endif
		index += 1
	endWhile
	
	self.BlockActivation(false)
	if again 
		Wait(02)
		self.Activate(self)
	endif
endEvent

; rotation is used to modulate which shelf is targeted
function placeItems(Form akActionRef, int itemCount, int rotation)	
				 
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
		placed = findOpeningAndPlace(IngotContainers, akActionRef, itemCount)
	elseif (akActionRef.getName() == "Skull")
		placed = findOpeningAndPlace(SkullContainers, akActionRef, itemCount)
	elseif (akActionRef.getName() == "Troll Skull")
		placed = findOpeningAndPlace(TrollSkullContainers, akActionRef, itemCount)
	elseif (akActionRef.HasKeyword(VendorItemJewelry))
		placed = findOpeningAndPlace(JewelryContainers, akActionRef, itemCount)
	elseif (isGem(akActionRef))
		placed = findOpeningAndPlace(GemContainers, akActionRef, itemCount)
	elseif (isSoulGem(akActionRef))
		placed = findOpeningAndPlace(SoulGemContainers, akActionRef, itemCount)
	elseif (isScroll(akActionRef))
		placed = findOpeningAndPlace(ScrollContainers, akActionRef, itemCount)
	elseif (isPotion(akActionRef))
		placed = findOpeningAndPlace(PotionContainers, akActionRef, itemCount)
	elseif(isSpellBook(akActionRef))
		placed = true
		if (Books03 && !Books03.isFull())
			placeItem(Books03, akActionRef, itemCount) 
		else
			placed = false
		endif
	elseif (isBook(akActionRef))
		placed = findOpeningAndPlace(BookContainers, akActionRef, itemCount)
	elseif (isTall(akActionRef))
		placed = findOpeningAndPlace(TallContainers, akActionRef, itemCount)
	endif
	
	; If we could not find a special shelf for the item 
	; then just put it on one of the general shelves
	if (!placed) 
		placed = findOpeningAndPlace(MixedContainers, akActionRef, itemCount)
	endif

	; if we still don't have a place for the item
	; then give it back to the player
	if !placed
		self.RemoveItem(akActionRef, itemCount, true, Game.GetPlayer())
	endif
	
endFunction
 
bool function findOpeningAndPlace(autoDeckContainerBase[] containers, Form akActionRef, int itemCount)
	int len = containers.length
	int i=0
	while i < len && (!containers[i] || containers[i].isFull())
		i += 1
	endWhile
	if i < len
		placeItem(containers[i], akActionRef, itemCount) 
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
	; add Item to the targetShelf
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
