Scriptname autoDeckShelfContainerScript extends autoDeckContainerBase  

import debug
import utility

Form Property LItemBookClutter Auto
{Clutter item list to fill the shelf with}

;***Stuff to make it compatible with the vanilla system***
Keyword Property BookShelfBook01 Auto
Keyword Property BookShelfBook18 Auto
Keyword Property VendorItemGem Auto
Keyword Property VendorItemOreIngot Auto
Keyword Property VendorItemPotion Auto
Keyword Property VendorItemPoison Auto
Keyword Property VendorItemFood Auto

;ObjectReference Property BookMarkerLate Auto hidden
;Bool Property adAlreadyLoaded2 = FALSE Auto hidden
;Bool Property adAlreadyLoaded8 = FALSE Auto hidden
;Bool Property containerFull = FALSE Auto hidden 
ObjectReference Property BookMarkerLate Auto 
Bool Property adAlreadyLoaded2 = FALSE Auto 
Bool Property adAlreadyLoaded8 = FALSE Auto
Bool Property containerFull = FALSE Auto 

Bool shelfFull = FALSE 

float minSize = 1.2
float space = 0.3
int MaxBooks = 128

;Number of books on the shelf
int NumBooks = 0

;Distance from first to last book
float TotalDistance = 0.0

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
	while i<NumBooks
		if self.getItemCount(PlacedBooks[i]) == 0
			;debug.TraceAndBox("Alert: Book '"+PlacedBooks[i].getName()+"' not found in the containers inventory. It must have been removed.")
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
	
	ObjectReference itemRef = None
	;Delete the rest of the references
	while i<PlacedBooks.length
		itemRef = PlacedBooksRef[i]
		if itemRef
			itemRef.Disable()
			itemRef.Delete()
			PlacedBooksRef[i] = None
        ;Debug.TraceAndBox("UpdateBooks, disable: "+i)
		endIf
		i+=1
	endwhile
	
	;Enable newly placed books
	i=0
	while i<NumBooks
		if(PlacedBooks[i])
			itemRef = PlacedBooksRef[i]
			itemRef.enable()
			itemRef.BlockActivation(FALSE)
			if !itemRef.hasKeyword(VendorItemOreIngot)
				itemRef.SetMotionType(1)
			endif
        ;Debug.TraceAndBox("UpdateBooks, enable: "+i)
		else
			CleanArrays()
		endif
		i+=1
	endwhile
	GoToState("") ; Now allow books to be updated again
endFunction

event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	if BlockBooks == FALSE
		; if the player took the item then the shelf is no longer full
		if akDestContainer != OverflowContainer
			shelfFull = FALSE
        ;Debug.TraceAndBox("OnItemRemoved "+self+", akDeskContainer != OverflowContainer")
		endif
		RemoveBooks(akBaseItem, aiItemCount)
	else
		BlockBooks = FALSE
	endif
        
endEvent


event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	itemAdded(akBaseItem, aiItemCount, akItemReference, akSourceContainer)
endEvent

function itemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	self.BlockActivation(true)
	int aiItemDiff = 0

	; Check to see if there is room in the container.
	if ((aiItemCount + NumBooks) > MaxBooks)
		containerFull = TRUE
		aiItemDiff = (aiItemCount + NumBooks) - MaxBooks		
		aiItemCount = aiItemCount - aiItemDiff
	endif

	; Add any items that will fit
	AddBooks(akItemReference, akBaseItem, aiItemCount)

	if containerFull
		; Remove the items that won't fit in the container
		utility.waitMenuMode(0)
		BookShelfNoMoreRoomMESSAGE.Show()
		BlockBooks = TRUE
		self.RemoveItem(akBaseItem, aiItemDiff, true, OverflowContainer)
	endif

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
		;RecoverOldBooks()
		adAlreadyLoaded2 = TRUE
	endif
	if !adAlreadyLoaded8
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
	int tempEnd = NumBooks
	while BookAmount > 0
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
	if NumBooks < MaxBooks
		containerFull = FALSE
	endif	
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
	float retWidth = 1.7

	if itemType as Book
		retWidth = 3.5
	elseif itemType as Potion
		retWidth = 8.0
	elseif itemType as MiscObject
		retWidth = 10.0
	endif

	return retWidth

endFunction

function AddBooks(ObjectReference item, Form BookBase, Int BookAmount)
        ;Debug.TraceAndBox("AddBooks, NumBooks: "+NumBooks)

	while BookAmount > 0
		PlacedBooks[NumBooks] = BookBase
		NumBooks += 1
		if !thereIsRoom(item, BookBase)
			self.RemoveItem(BookBase, 1, true, OverflowContainer)
		endif
		BookAmount -= 1
	endWhile
endFunction

bool function thereIsRoom(ObjectReference item, Form itemType)
	if self.isFull()
		return FALSE
	endif

	float itemWidth = 1.0

	if item 
		int orient = orientation(item)
		itemWidth = getBookAmount(item, orient)

		if item.hasKeyword(VendorItemOreIngot)
			itemWidth = 1.5
		endif
	else
		itemWidth = getDefaultWidth(itemType)
	endif
		

	if (TotalOffset + itemWidth/TotalDistance) > (1.0 + (1.5 * MarkerHeight/TotalDistance))
		shelfFull = TRUE
		return FALSE
	else
		return TRUE
	endif
endFunction

Function CountMaxBooks()
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
		retVal.disable()
		retVal.delete()
		int itemCount = NumBooks
		while itemCount>index
			self.RemoveItem(PlacedBooks[ itemCount - 1 ], 1, true, OverflowContainer)
			itemCount -= 1
		endwhile
		;Notification("Some items did not fit and have been returned to the Autodeck.")
		shelfFull = TRUE
		return None
	elseif (TotalOffset + 12.0/TotalDistance) > (1.0 + (1.5 * MarkerHeight/TotalDistance))
		shelfFull = TRUE
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
		int itemCount = NumBooks
		while NumBooks>index
			self.RemoveItem(PlacedBooks[ itemCount - 1 ], 1, true, OverflowContainer)
			;PlacedBooks[ NumBooks - 1 ] = None
			itemCount -= 1
		endwhile
		shelfFull = TRUE
		return None
	elseif (TotalOffset + 12.0/TotalDistance) > (1.0 + (1.5 * MarkerHeight/TotalDistance))
		shelfFull = TRUE
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
	dz -= MarkerWidth/2.0 - 2 
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

