Scriptname autoDeckShelfContainerScript extends autoDeckContainerBase  

import debug
import utility

Form Property LItemBookClutter Auto
{Clutter item list to fill the shelf with}

;***Stuff to make it compatible with the vanilla system***
Keyword Property BookShelfBook01 Auto
Keyword Property BookShelfBook02 Auto
Keyword Property BookShelfBook03 Auto
Keyword Property BookShelfBook04 Auto
Keyword Property BookShelfBook05 Auto
Keyword Property BookShelfBook06 Auto
Keyword Property BookShelfBook07 Auto
Keyword Property BookShelfBook08 Auto
Keyword Property BookShelfBook09 Auto
Keyword Property BookShelfBook10 Auto
Keyword Property BookShelfBook11 Auto
Keyword Property BookShelfBook12 Auto
Keyword Property BookShelfBook13 Auto
Keyword Property BookShelfBook14 Auto
Keyword Property BookShelfBook15 Auto
Keyword Property BookShelfBook16 Auto
Keyword Property BookShelfBook17 Auto
Keyword Property BookShelfBook18 Auto
Keyword Property VendorItemGem Auto
Keyword Property VendorItemOreIngot Auto
Keyword Property VendorItemPotion Auto
Keyword Property VendorItemPoison Auto
Keyword Property VendorItemFood Auto
{List of required Keywords}
Form Property PlacedBook01 Auto Hidden
Form Property PlacedBook02 Auto Hidden
Form Property PlacedBook03 Auto Hidden
Form Property PlacedBook04 Auto Hidden
Form Property PlacedBook05 Auto Hidden
Form Property PlacedBook06 Auto Hidden
Form Property PlacedBook07 Auto Hidden
Form Property PlacedBook08 Auto Hidden
Form Property PlacedBook09 Auto Hidden
Form Property PlacedBook10 Auto Hidden
Form Property PlacedBook11 Auto Hidden
Form Property PlacedBook12 Auto Hidden
Form Property PlacedBook13 Auto Hidden
Form Property PlacedBook14 Auto Hidden
Form Property PlacedBook15 Auto Hidden
Form Property PlacedBook17 Auto Hidden
Form Property PlacedBook16 Auto Hidden
Form Property PlacedBook18 Auto Hidden
{List of Placed Book Forms}
ObjectReference Property PlacedBook01Ref Auto Hidden
ObjectReference Property PlacedBook02Ref Auto Hidden
ObjectReference Property PlacedBook03Ref Auto Hidden
ObjectReference Property PlacedBook04Ref Auto Hidden
ObjectReference Property PlacedBook05Ref Auto Hidden
ObjectReference Property PlacedBook06Ref Auto Hidden
ObjectReference Property PlacedBook07Ref Auto Hidden
ObjectReference Property PlacedBook08Ref Auto Hidden
ObjectReference Property PlacedBook09Ref Auto Hidden
ObjectReference Property PlacedBook10Ref Auto Hidden
ObjectReference Property PlacedBook11Ref Auto Hidden
ObjectReference Property PlacedBook12Ref Auto Hidden
ObjectReference Property PlacedBook13Ref Auto Hidden
ObjectReference Property PlacedBook14Ref Auto Hidden
ObjectReference Property PlacedBook15Ref Auto Hidden
ObjectReference Property PlacedBook17Ref Auto Hidden
ObjectReference Property PlacedBook16Ref Auto Hidden
ObjectReference Property PlacedBook18Ref Auto Hidden
ObjectReference Property BookMarkerLate Auto Hidden
ObjectReference Property OverflowContainer = None Auto Hidden
{List of Placed Book Refs}

Bool Property adAlreadyLoaded2 = FALSE Auto Hidden
Bool Property adAlreadyLoaded8 = FALSE Auto Hidden
Bool Property containerFull = FALSE Auto Hidden 
Bool shelfFull = FALSE 

float minSize = 1.2
float space = 0.3
int MaxBooks = 128

;Number of books on the shelf
int NumBooks = 0

;Distance from first to last book
float TotalDistance = 0.0

;Amount of space already occupied on the shelf
float UsedSpace = 0.0

;Fraction of total distance covered so far
float TotalOffset = 0.0
float xDist = 0.0
float yDist = 0.0
float zDist = 0.0

bool VerticalBooks = true
float MarkerWidth = 23.0
float MarkerHeight = 6.0
float MarkerLength = 30.0
float MarkerAngle
float OrientMult = 1.0

float[] ingotR1
float[] ingotR2
float[] ingotR3
float[] ingotR4
int stackedIngots
int AddCount = 0

event OnCellLoad()
        load()
endEvent

event OnActivate(ObjectReference akActionRef)
	if (BookShelfGlobal.GetValue() == 0)
		BookShelfFirstActivateMESSAGE.Show()
		BookShelfGlobal.SetValue(1)
	endif
	refresh(akActionRef)
endEvent

function refresh(ObjectReference akActionRef)
	BlockActivate()
	self.BlockActivation(true)

	if BookShelfTrigger01Ref
		BookShelfTrigger01Ref.GoToState("IgnoreBooks")
	endif
	if BookShelfTrigger02Ref
		BookShelfTrigger02Ref.GoToState("IgnoreBooks")
	endif
	if BookShelfTrigger03Ref
		BookShelfTrigger03Ref.GoToState("IgnoreBooks")
	endif
	if BookShelfTrigger04Ref
		BookShelfTrigger04Ref.GoToState("IgnoreBooks")
	endif

	Wait(0.25)
	; The following will fire when the player leaves inventory
	BookMarkerStart = GetLinkedRef(BookShelfBook01)
	BookMarkerLate = BookMarkerStart.PlaceAtMe(BookMarkerStart.GetBaseObject())
	UpdateBooks()

	if BookShelfTrigger01Ref
		BookShelfTrigger01Ref.GoToState("WaitForBooks")
	endif
	if BookShelfTrigger02Ref
		BookShelfTrigger02Ref.GoToState("WaitForBooks")
	endif
	if BookShelfTrigger03Ref
		BookShelfTrigger03Ref.GoToState("WaitForBooks")
	endif
	if BookShelfTrigger04Ref
		BookShelfTrigger04Ref.GoToState("WaitForBooks")
	endif
	self.blockActivation(false)
	CurrentBookAmount = NumBooks
endFunction

function UpdateBooks()
	GoToState("PlacingBooks") ; Future calls should not mess with this stuff
	ingotR1 = new float[128]
	ingotR2 = new float[128]
	ingotR3 = new float[128]
	ingotR4 = new float[128]
	stackedIngots = 0
	;Start updating book locations
	int i=0
        ;Debug.TraceAndBox("UpdateBooks "+self+", NumBooks: "+NumBooks+", shelfFull: "+shelfFull+", UsedSpace: "+UsedSpace+", TotalDistance: "+TotalDistance)
	while i<NumBooks
		if self.getItemCount(PlacedBooks[i]) == 0
			debug.TraceAndBox("Alert: Book '"+PlacedBooks[i].getName()+"' not found in the containers inventory. It must have been removed.")
			PlacedBooksRef[i] = PlacedBooksRef[NumBooks - 1]
			PlacedBooks[i] = PlacedBooks[NumBooks - 1]
			if i==NumBooks - 1
				PlacedBooks[i] = None
			endif
			NumBooks -= 1
		endif
		PlacedBooksRef[i].Disable()
		PlacedBooksRef[i].Delete()
		PlacedBooksRef[i]=UpdateSingleBook(PlacedBooks[i], i)
		i+=1
	endwhile
	
	;Delete the rest of the references
	while i<PlacedBooks.length
		if PlacedBooksRef[i]
			PlacedBooksRef[i].Disable()
			PlacedBooksRef[i].Delete()
			PlacedBooksRef[i] = None
        ;Debug.TraceAndBox("UpdateBooks, disable: "+i)
		endIf
		i+=1
	endwhile
	GoToState("") ; Now allow books to be updated again
	
	;Enable newly placed books
	i=0
	while i<NumBooks
		if(PlacedBooks[i])
			PlacedBooksRef[i].enable()
			PlacedBooksRef[i].BlockActivation(FALSE)
			PlacedBooksRef[i].SetMotionType(1)
        ;Debug.TraceAndBox("UpdateBooks, enable: "+i)
		else
			CleanArrays()
		endif
		i+=1
	endwhile
	CurrentBookAmount = NumBooks
endFunction

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	if BlockBooks == FALSE
		; If the item is a book find the corresponding book reference and remove it.
		;MessageBox("BOOKCASE - Form being Removed " + akBaseItem + " is a Book! Remove it from the list")
		
		int orient = orientation(akItemReference)
		float itemWidth = getBookAmount(akItemReference, orient)

		if akItemReference.hasKeyword(VendorItemOreIngot)
			itemWidth = 2 * itemWidth/3
		endif

		UsedSpace -= (itemWidth * aiItemCount)
		shelfFull = FALSE
        ;Debug.TraceAndBox("OnItemRemoved "+self+", NumBooks: "+NumBooks+", shelfFull: "+shelfFull+", UsedSpace: "+UsedSpace+", TotalDistance: "+TotalDistance+"Book Name: "+akItemReference.getName())
		RemoveBooks(akBaseItem, aiItemCount)
	else
		BlockBooks = FALSE
	endif
	CurrentBookAmount = NumBooks
        
endEvent


Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	itemAdded(akBaseItem, aiItemCount, akItemReference, akSourceContainer)
endEvent

function itemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	self.BlockActivation(true)
	int aiItemDiff = 0

	;while GetState() == "PlacingBooks"
		;Wait(0.25)
	;endWhile

	; Check to see if there is room in the container.
	if ((aiItemCount + NumBooks) > MaxBooks)
		containerFull = TRUE
		aiItemDiff = (aiItemCount + NumBooks) - MaxBooks		
		aiItemCount = aiItemCount - aiItemDiff
	endif

	; Add any items that will fit
	if !akSourceContainer
		AddBooks(akItemReference, akBaseItem, aiItemCount)
		;refresh(akItemReference)
	else
		AddBooks(akItemReference, akBaseItem, aiItemCount)
	endif

	if containerFull
	debug.TraceAndBox("Container Full MaxBooks="+MaxBooks)
		; Remove the items that won't fit in the container
		utility.waitMenuMode(0)
		BookShelfNoMoreRoomMESSAGE.Show()
		BlockBooks = TRUE
		self.RemoveItem(akBaseItem, aiItemDiff, true, OverflowContainer)
	endif

	CurrentBookAmount = NumBooks
	self.BlockActivation(false)
endFunction

function load()
	if adAlreadyLoaded2 == FALSE
		;MessageBox("BOOKCASE - Running OnLoad()")
		PlacedBooks = new Form[128]
		PlacedBooksRef = new ObjectReference[128]
		
		BookShelfTrigger01Ref = (GetLinkedRef(BookShelfTrigger01) as autoDeckShelfTriggerScript)
		BookShelfTrigger02Ref = (GetLinkedRef(BookShelfTrigger02) as autoDeckShelfTriggerScript)
		BookShelfTrigger03Ref = (GetLinkedRef(BookShelfTrigger03) as autoDeckShelfTriggerScript)
		BookShelfTrigger04Ref = (GetLinkedRef(BookShelfTrigger04) as autoDeckShelfTriggerScript)
		RecoverOldBooks()
		adAlreadyLoaded2 = TRUE
	endif
	if !adAlreadyLoaded8
		;Debug.TraceAndBox("CountMaxBooksA, Parent: "+parent+", Self: "+self)
		BookMarkerStart = GetLinkedRef(BookShelfBook01)
		BookMarkerEnd = GetLinkedRef(BookShelfBook18)

		;Debug.TraceAndBox("load, BookMarkerStart: "+BookMarkerStart)
		CountMaxBooks()
		MarkerAngle = BookMarkerStart.getAngleY()
		float mx = BookMarkerStart.getAngleX()
		float mz = BookMarkerStart.getAngleZ()
		if mx > 180.0
			mx -= 360.0
		endif
		if mz > 180.0
			mz -= 360.0
		endif
		VerticalBooks = (Math.abs(Math.abs(mx) - 90.0) < 30.0)
		if Math.abs(mx) < Math.abs(mz)
			OrientMult = -1.0
		endif
		adAlreadyLoaded8 = true
	endif
	minSize = 1.2
	space = 0.3
	MaxBooks = PlacedBooks.length
	self.blockActivation(false)
	CleanArrays()
	adAlreadyLoaded = false
	AddCount = 0
endFunction

Function BlockActivate()
	int i=0
	while i<NumBooks
		if PlacedbooksRef[i]
			PlacedBooksRef[i].BlockActivation(TRUE)
		endif
		i+=1
	endwhile
endFunction

Function RemoveBooks(Form BookBase, Int BookAmount)
	;Debug.TraceAndBox("autoDeckShelfContainer.RemoveBooks()")
	;if GetState() != "PlacingBooks"
		int tempEnd = NumBooks
		While BookAmount > 0
			int i=0
			bool f=true
			while i<tempEnd
				if PlacedBooks[i] == BookBase && f
					NumBooks -= 1
					f=false
				endif
				if !f
					if i == PlacedBooks.length - 1
						PlacedBooks[i] = None
					else
						PlacedBooks[i] = PlacedBooks[i+1]
					endif
				endif
				i+=1
			endwhile
			BookAmount -= 1
		endWhile
	;endif
	CurrentBookAmount = NumBooks
endFunction

float Function getBookAmount(ObjectReference BookRef, int orient = 0)
	if !BookRef
		return 0
	endif
        ;Debug.TraceAndBox("getBookAmount, orient="+orient+" , length: "+BookRef.getLength()+", width: "+BookRef.getWidth()+", height: "+BookRef.getHeight())
	float dim = 0
	if orient == 0
		dim = BookRef.getHeight() + 1 
        ;Debug.TraceAndBox("getBookAmount, orient=0, obj: "+BookRef.getBaseObject()+", dim: "+dim)
	elseif orient == 1
		dim = BookRef.getLength() + 3
        ;Debug.TraceAndBox("getBookAmount, orient=1, length: "+BookRef.getLength()+", width: "+BookRef.getWidth()+", height: "+BookRef.getHeight())
	else
		dim = BookRef.getWidth() + 3
        ;Debug.TraceAndBox("getBookAmount, orient=2, obj: "+BookRef.getBaseObject()+", dim: "+dim)
	endif
	if dim<=3
		dim += minSize
	else
		dim += space
	endif
	if dim<minSize
		dim=minSize
	endif
        ;Debug.TraceAndBox("getBookAmount, final, obj: "+BookRef.getBaseObject()+", dim: "+dim)
	return dim
endFunction

float function getDefaultWidth(Form itemType)
	float retWidth = 6.0

	if itemType as Book
		retWidth = 3.5
	elseif itemType as Potion
		retWidth = 8.0
	endif

	return retWidth

endFunction

function AddBooks(ObjectReference item, Form BookBase, Int BookAmount)
        ;Debug.TraceAndBox("AddBooks, NumBooks: "+NumBooks)

	while BookAmount > 0
		if thereIsRoom(item, BookBase)
			PlacedBooks[NumBooks] = BookBase
			NumBooks += 1
        ;Debug.TraceAndBox("AddBooks while, NumBooks: "+NumBooks)
		else
        ;Debug.TraceAndBox("RemoveItem "+self+", NumBooks: "+NumBooks+", shelfFull: "+shelfFull+", UsedSpace: "+UsedSpace+", TotalDistance: "+TotalDistance+"Book Name: "+item.getName())
			BlockBooks = true
			self.RemoveItem(BookBase, 1, true, OverflowContainer)
		endif
		BookAmount -= 1
	endWhile
	CurrentBookAmount = NumBooks
endFunction

;bool function addToContainer(ObjectReference item)
	;Form BookBase = item.GetBaseObject()

	;while GetState() == "AddingBooks"
		;Wait(0.25)
	;endWhile

	;GoToState("AddingBooks") ; Future calls should not mess with this stuff
	;AddCount += 1
	;debug.TraceAndBox("addToContainer, AddCount = "+AddCount)

	;if thereIsRoom(item)
		;PlacedBooks[NumBooks] = BookBase
		;NumBooks += 1
		;CurrentBookAmount = NumBooks
		;AddItem(item,1,true)
		;GoToState("") ; Future calls should not mess with this stuff
		;return true
	;else
		;OverflowContainer.AddItem(item,1,true)
		;GoToState("") ; Future calls should not mess with this stuff
		;return false
	;endif
;endFunction

bool function thereIsRoom(ObjectReference item, Form itemType)
	if self.isFull()
		return FALSE
	endif

	float itemWidth = 0.0

	if item 
		int orient = orientation(item)
		itemWidth = getBookAmount(item, orient)

		if item.hasKeyword(VendorItemOreIngot)
			itemWidth = 2 * itemWidth/3
		endif
	else
		itemWidth = getDefaultWidth(itemType)
	endif
		

	; Calculate Available Space
	int i = 0
        float slack = TotalDistance - UsedSpace
	;debug.TraceAndBox("slack="+slack+", UsedSpace="+UsedSpace+", itemWidth="+itemWidth+", TotalDistance="+TotalDistance)

	if slack > itemWidth
		;if (slack - itemWidth) < 19.0
			;shelfFull = TRUE
		;else 
			;shelfFull = FALSE
		;endif
			
		UsedSpace += itemWidth 
		return TRUE
	else
		if slack < 19.0
			shelfFull = TRUE
		else 
			shelfFull = FALSE
		endif

		return FALSE
	endif
		
endFunction

Function CountMaxBooks()
        ;Debug.TraceAndBox("CountMaxBooks2, BookMarkerEnd: "+BookMarkerEnd+", BookMarkerStart: "+BookMarkerStart)
	; Checks how many books can be placed on this shelf
	if GetLinkedRef(BookShelfBook18) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook18)
        ;Debug.TraceAndBox("CountMaxBooks18, BookMarkerEnd: "+BookMarkerEnd+", BookMarkerStart: "+BookMarkerStart)
	elseif GetLinkedRef(BookShelfBook17) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook17)
	elseif GetLinkedRef(BookShelfBook16) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook16)
	elseif GetLinkedRef(BookShelfBook15) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook15)
	elseif GetLinkedRef(BookShelfBook14) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook14)
	elseif GetLinkedRef(BookShelfBook13) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook13)
	elseif GetLinkedRef(BookShelfBook12) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook12)
	elseif GetLinkedRef(BookShelfBook11) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook11)
	elseif GetLinkedRef(BookShelfBook10) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook10)
	elseif GetLinkedRef(BookShelfBook09) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook09)
	elseif GetLinkedRef(BookShelfBook08) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook08)
	elseif GetLinkedRef(BookShelfBook07) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook07)
	elseif GetLinkedRef(BookShelfBook06) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook06)
	elseif GetLinkedRef(BookShelfBook05) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook05)
	elseif GetLinkedRef(BookShelfBook04) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook04)
	elseif GetLinkedRef(BookShelfBook03) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook03)
	elseif GetLinkedRef(BookShelfBook02) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook02)
	elseif GetLinkedRef(BookShelfBook01) 
		BookMarkerEnd = GetLinkedRef(BookShelfBook01)
	endif
	xDist = BookMarkerEnd.getPositionX()-BookMarkerStart.getPositionX()
	yDist = BookMarkerEnd.getPositionY()-BookMarkerStart.getPositionY()
	zDist = BookMarkerEnd.getPositionZ()-BookMarkerStart.getPositionZ()
	TotalDistance = Math.sqrt((xDist*xDist)+(yDist*yDist)+(zDist*zDist))
        ;Debug.TraceAndBox("CountMaxBooks, xDist: "+xDist+", yDist: "+yDist)
        ;Debug.TraceAndBox("CountMaxBooks, BookMarkerEnd: "+BookMarkerEnd+", BookMarkerStart: "+BookMarkerStart)
endFunction


ObjectReference function UpdateSingleBook(Form itemType, Int index)
	if itemType
		if (itemType as Book)
			return positionBook(itemType, index)
		else
			return updateOther(itemType, index)
		endif
	endif

	ObjectReference retVal
	return retVal
endFunction

int function orientation(ObjectReference item)
	int orient = 0
	if item.GetBaseObject() as Book
		orient = 0
	elseif ((item.getLength() * 2) < item.getWidth()) || (item.getLength() > (MarkerLength * 1.8))
		orient = 1
	else
		orient = 2
	endif
		
	return orient
endFunction

ObjectReference function updateOther(Form itemType, int index)
	ObjectReference retVal
	retVal = BookMarkerStart.PlaceAtMe(itemType)
	retVal.BlockActivation()
	float orientAngle = 0.0
	int orient = orientation(retVal)
	if orient == 1
		orientAngle += 90.0
	endif
	float bookAmt = getBookAmount(retVal, orient)

	if (itemType as autoDeckUBRotateItem)
		;Debug.TraceAndBox("updateOther, UBRotate: "+orientAngle)
		orientAngle += 180.0
	endif
		
	if index == 0
		TotalOffset = (bookAmt - MarkerHeight)/(TotalDistance*2)
	endif

	if VerticalBooks
		if itemType.hasKeyword(VendorItemOreIngot)
			retVal = positionIngot(retVal, index, orient, orientAngle)
		elseif  retVal.getHeight() > 0
			retVal = positionOther(retVal, orient, orientAngle)
		endif
	endif

	if (TotalOffset + bookAmt/TotalDistance) > (1.0 + (1.5 * MarkerHeight/TotalDistance))
		shelfFull = TRUE
		retVal.disable()
		retVal.delete()
		;while NumBooks>index
			;self.RemoveItem(PlacedBooks[ NumBooks - 1 ], 1, true, OverflowContainer)
			;;self.RemoveItem(PlacedBooks[ NumBooks - 1 ], 1, true, Game.GetPlayer())
			;PlacedBooks[ NumBooks - 1 ]=None
			;NumBooks -= 1
		;endwhile
		Notification("Some items did not fit and have been given back")
		return None
	else
		shelfFull = FALSE
	endif
		
	TotalOffset += bookAmt/TotalDistance
	return retVal
endFunction

ObjectReference function positionBook(Form bookType, int index)
	float bookAmt = 0.0
	if index == 0
		TotalOffset = (2)/(TotalDistance*2)
	endif
	float dx=xDist*(TotalOffset )
	float dy=yDist*(TotalOffset )
	float dz=zDist*(TotalOffset )
	BookMarkerLate.moveTo(BookMarkerStart,dx,dy,dz,false)
	ObjectReference retVal = BookMarkerLate.PlaceAtMe(bookType, 1)
	retVal.SetMotionType(4)
	bookAmt = retVal.getHeight() + 1.0

	if (TotalOffset + bookAmt/TotalDistance) > (1.0 + (1.5 * MarkerHeight/TotalDistance))
		retVal.disable()
		retVal.delete()
		while NumBooks>index
			self.RemoveItem(PlacedBooks[ NumBooks - 1 ], 1, true, OverflowContainer)
			;self.RemoveItem(PlacedBooks[ NumBooks - 1 ], 1, true, Game.GetPlayer())
			PlacedBooks[ NumBooks - 1 ] = None
			NumBooks -= 1
		endwhile
		;Notification("Some items did not fit and have been given back")
		shelfFull = TRUE
		return None
	else
		shelfFull = FALSE
	endif
		
	TotalOffset += bookAmt/TotalDistance
	return retVal
endFunction

ObjectReference function positionOther(ObjectReference retVal, int orient, float orientAngle)
	float dx=xDist*(TotalOffset );- (0.4 * MarkerHeight/TotalDistance)) ;-(MarkerHeight/2.0)
	float dy=yDist*(TotalOffset );- (0.4 * MarkerHeight/TotalDistance))
	float dz=zDist*(TotalOffset );- (0.4 * MarkerHeight/TotalDistance))
	;dz += (retVal.getHeight() - MarkerWidth)/2.0 
	dz -= MarkerWidth/2.0 - 3
	retVal.SetMotionType(4)

	if orient == 0 
		retVal.moveTo(BookMarkerStart,dx,dy,dz)
	else
		retVal.setAngle(0, 0, (MarkerAngle - 90.0)*OrientMult + orientAngle)
		retVal.moveTo(BookMarkerStart,dx,dy,dz, false)
	endif

	BookMarkerLate.moveTo(BookMarkerStart,dx,dy,dz,false)
	return retVal
		
endFunction

ObjectReference function positionIngot(ObjectReference retVal, int index, int orient, float orientAngle)
	float dx=xDist*(TotalOffset );- (0.4 * MarkerHeight/TotalDistance)) ;-(MarkerHeight/2.0)
	float dy=yDist*(TotalOffset );- (0.4 * MarkerHeight/TotalDistance))
	float dz=zDist*(TotalOffset );- (0.4 * MarkerHeight/TotalDistance))
	dz -= MarkerWidth/2.0 - 5 
	int i=0
	bool b=false
	while !b && i<ingotR4.length - 3
		if ingotR4[i]==0 && ingotR3[i]>0 && ingotR3[i+1]>0
			dz += (retVal.getHeight() * 3.3) ;+ 2
			dx = xDist*(ingotR3[i] + ingotR3[i+1])/2.0
			dy = yDist*(ingotR3[i] + ingotR3[i+1])/2.0
			ingotR4[i]=(ingotR3[i] + ingotR3[i+1])/2.0
			b=true
		endif
		i+=1
	endwhile
	i=0
	while !b && i<ingotR3.length - 2
		if ingotR3[i]==0 && ingotR2[i]>0 && ingotR2[i+1]>0
			dz += (retVal.getHeight() * 2.2) ;+ 1
			dx = xDist*(ingotR2[i] + ingotR2[i+1])/2.0
			dy = yDist*(ingotR2[i] + ingotR2[i+1])/2.0
			ingotR3[i]=(ingotR2[i] + ingotR2[i+1])/2.0
			b=true
		endif
		i+=1
	endwhile
	i=0
	while !b && i<ingotR2.length - 1
		if ingotR2[i]==0 && ingotR1[i]>0 && ingotR1[i+1]>0
			dz += retVal.getHeight() * 1.1
			dx = xDist*(ingotR1[i] + ingotR1[i+1])/2.0
			dy = yDist*(ingotR1[i] + ingotR1[i+1])/2.0
			ingotR2[i]=(ingotR1[i] + ingotR1[i+1])/2.0
			b=true
		endif
		i+=1
	endwhile
	if !b
		ingotR1[index - stackedIngots]=TotalOffset
	else
		float bookAmt = getBookAmount(retVal, orient)
		TotalOffset-=bookAmt/TotalDistance
		stackedIngots += 1
	endif

	retVal.SetMotionType(4)
	if orient == 0 
		retVal.moveTo(BookMarkerStart,dx,dy,dz)
        ;Debug.TraceAndBox("positionIngot moveTo, BookMarkerStart: "+BookMarkerStart+", dx: "+dx+", dy: "+dy+", dz: "+dz)
	else
		retVal.setAngle(0, 0, (MarkerAngle - 90.0)*OrientMult + orientAngle)
        ;Debug.TraceAndBox("positionIngot setAngle, Angle: "+((MarkerAngle - 90.0)*OrientMult + orientAngle))
		retVal.moveTo(BookMarkerStart,dx,dy,dz, false)
        ;Debug.TraceAndBox("positionIngot moveTo, BookMarkerStart: "+BookMarkerStart+", dx: "+dx+", dy: "+dy+", dz: "+dz)
	endif
	BookMarkerLate.moveTo(BookMarkerStart,dx,dy,dz,false)
	return retVal
endFunction

function CleanArrays()
	;Update arrays if the max number of books is changed
	if MaxBooks != PlacedBooks.length
		Form[] tmp = new Form[128]
		ObjectReference[] tmp2 = new ObjectReference[128]
		int i=0
		while ((i < PlacedBooks.length) && (i < tmp.length))
			tmp[i] = PlacedBooks[i]
			tmp2[i] = PlacedBooksRef[i]
			i+=1
		endwhile
		PlacedBooks = tmp
		PlacedBooksRef = tmp2
	endif
	
	;Clean up arrays so there are no gaps and determine the number of books
	int i=0
	bool f = false
	int loc = 0
	while (i < PlacedBooks.length)
		if !PlacedBooks[i] && !f
			f = true
			loc = i
		elseif PlacedBooks[i] && f
			PlacedBooks[loc] = PlacedBooks[i]
			PlacedBooksRef[loc] = PlacedBooksRef[i]
			PlacedBooks[i] = None
			PlacedBooksRef[i] = None
			loc += 1
		endif
		i += 1
	endwhile
	NumBooks = loc
endFunction

function RecoverOldBooks()
	PlacedBooks[0] = PlacedBook01
	PlacedBooksRef[0] = PlacedBook01Ref
	PlacedBook01 = None
	PlacedBook01Ref = None
	PlacedBooks[1] = PlacedBook02
	PlacedBooksRef[1] = PlacedBook02Ref
	PlacedBook02 = None
	PlacedBook02Ref = None
	PlacedBooks[2] = PlacedBook03
	PlacedBooksRef[2] = PlacedBook03Ref
	PlacedBook03 = None
	PlacedBook03Ref = None
	PlacedBooks[3] = PlacedBook04
	PlacedBooksRef[3] = PlacedBook04Ref
	PlacedBook04 = None
	PlacedBook04Ref = None
	PlacedBooks[4] = PlacedBook05
	PlacedBooksRef[4] = PlacedBook05Ref
	PlacedBook05 = None
	PlacedBook05Ref = None
	PlacedBooks[5] = PlacedBook06
	PlacedBooksRef[5] = PlacedBook06Ref
	PlacedBook06 = None
	PlacedBook06Ref = None
	PlacedBooks[6] = PlacedBook07
	PlacedBooksRef[6] = PlacedBook07Ref
	PlacedBook07 = None
	PlacedBook07Ref = None
	PlacedBooks[7] = PlacedBook08
	PlacedBooksRef[7] = PlacedBook08Ref
	PlacedBook08 = None
	PlacedBook08Ref = None
	PlacedBooks[8] = PlacedBook09
	PlacedBooksRef[8] = PlacedBook09Ref
	PlacedBook09 = None
	PlacedBook09Ref = None
	PlacedBooks[9] = PlacedBook10
	PlacedBooksRef[9] = PlacedBook10Ref
	PlacedBook10 = None
	PlacedBook10Ref = None
	PlacedBooks[10] = PlacedBook11
	PlacedBooksRef[10] = PlacedBook11Ref
	PlacedBook11 = None
	PlacedBook11Ref = None
	PlacedBooks[11] = PlacedBook12
	PlacedBooksRef[11] = PlacedBook12Ref
	PlacedBook12 = None
	PlacedBook12Ref = None
	PlacedBooks[12] = PlacedBook13
	PlacedBooksRef[12] = PlacedBook13Ref
	PlacedBook13 = None
	PlacedBook13Ref = None
	PlacedBooks[13] = PlacedBook14
	PlacedBooksRef[13] = PlacedBook14Ref
	PlacedBook14 = None
	PlacedBook14Ref = None
	PlacedBooks[14] = PlacedBook15
	PlacedBooksRef[14] = PlacedBook15Ref
	PlacedBook15 = None
	PlacedBook15Ref = None
	PlacedBooks[15] = PlacedBook16
	PlacedBooksRef[15] = PlacedBook16Ref
	PlacedBook16 = None
	PlacedBook16Ref = None
	PlacedBooks[16] = PlacedBook17
	PlacedBooksRef[16] = PlacedBook17Ref
	PlacedBook17 = None
	PlacedBook17Ref = None
	PlacedBooks[17] = PlacedBook18
	PlacedBooksRef[17] = PlacedBook18Ref
	PlacedBook18 = None
	PlacedBook18Ref = None
endFunction

bool function isFull()
	return shelfFull || containerFull
endFunction

state AddingBooks
endState 

state PlacingBooks
	function UpdateBooks()
		; Already updating books, so ignore
	endFunction
	
	EVENT OnActivate(ObjectReference akActionRef)
	EndEvent
endState 

