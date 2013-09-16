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
{List of Placed Book Refs}

Bool Property adAlreadyLoaded2 = FALSE Auto Hidden
Bool Property adAlreadyLoaded8 = FALSE Auto Hidden

float minSize = 1.2
float space = 0.3
int MaxBooks = 128

;Number of books on the shelf
int NumBooks = 0

;Distance from first to last book
float TotalDistance = 0.0

;Fraction of total distance covered so far
float BookOffset = 0.0
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

EVENT OnCellLoad()
        load()
endEVENT


EVENT OnActivate(ObjectReference akActionRef)
	BlockActivate()
	self.BlockActivation(true)
	if (BookShelfGlobal.GetValue() == 0)
		BookShelfFirstActivateMESSAGE.Show()
		BookShelfGlobal.SetValue(1)
	endif

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
endEVENT


Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	;if (akBaseItem as Book || akBaseItem as Scroll)
		if BlockBooks == FALSE
			; If the item is a book find the corresponding book reference and remove it.
			;MessageBox("BOOKCASE - Form being Removed " + akBaseItem + " is a Book! Remove it from the list")
			RemoveBooks(akBaseItem, aiItemCount)
		else
			BlockBooks = FALSE
		endif
	;endif
	CurrentBookAmount = NumBooks
        
endEvent


Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	; Check to see if there is room in on the shelf.
	if ((aiItemCount + NumBooks) <= MaxBooks)
		; There's room on teh shelf, manage the book placement
		AddBooks(akBaseItem, aiItemCount)
	else
		; There is no room on the shelf.  Tell the player this and give him his book back.
		utility.waitMenuMode(0)
		BookShelfNoMoreRoomMESSAGE.Show()
		BlockBooks = TRUE
		self.RemoveItem(akBaseItem, aiItemCount, true, Game.GetPlayer())
	endif
	CurrentBookAmount = NumBooks
endEvent

Function load()
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
	if GetState() != "PlacingBooks"
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
	endif
	CurrentBookAmount = NumBooks
endFunction

float Function getBookAmount(ObjectReference BookRef, int orient = 0)
	if !BookRef
		return 0
	endif
	float dim = 0
	if orient == 0
		dim = BookRef.getHeight()
        ;Debug.TraceAndBox("getBookAmount, orient=0, obj: "+BookRef.getBaseObject()+", dim: "+dim)
	elseif orient == 1
		dim = BookRef.getLength() + 3
        ;Debug.TraceAndBox("getBookAmount, orient=1, obj: "+BookRef.getBaseObject()+", dim: "+dim)
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

Function AddBooks(Form BookBase, Int BookAmount)
        ;Debug.TraceAndBox("AddBooks, NumBooks: "+NumBooks)
	While BookAmount > 0
		if NumBooks < MaxBooks
			PlacedBooks[NumBooks] = BookBase
			NumBooks += 1
        ;Debug.TraceAndBox("AddBooks while, NumBooks: "+NumBooks)
		endif
		BookAmount -= 1
	endWhile
	CurrentBookAmount = NumBooks
endFunction


Function CountMaxBooks()
	;BookMarkerEnd = BookMarkerStart
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


ObjectReference Function UpdateSingleBook(Form TargetBook, Int index)
   ObjectReference retVal
  ;Debug.TraceAndBox("UpdateSingleBook, TargetBook: "+TargetBook)
   if TargetBook
	retVal = BookMarkerEnd.PlaceAtMe(TargetBook)
	retVal.BlockActivation()
  ;Debug.TraceAndBox("UpdateSingleBook, PlaceAtMe.TargetBook: "+BookMarkerStart.GetPositionX()+","+BookMarkerStart.GetPositionY()+","+BookMarkerStart.GetPositionZ())
  ;Debug.TraceAndBox("UpdateSingleBook, retVal 1: x="+retVal.GetPositionX()+", y="+retVal.GetPositionY()+", z="+retVal.GetPositionZ())
		
      float orientAngle = 0.0
      int orient
      if (retVal.getLength() < retVal.getWidth()) || (retVal.getLength() > (MarkerLength * 1.1))
         orient = 1
         orientAngle += 90.0
      else
         orient = 2
      endif
      if (TargetBook as autoDeckUBRotateItem)
         ;Debug.TraceAndBox("UpdateSingleBook, UBRotate: "+orientAngle)
         orientAngle += 180.0
      endif
		
      float bookAmt = getBookAmount(retVal, orient)
      if index == 0
         BookOffset += (bookAmt - MarkerHeight)/(TotalDistance*2)
      endif

	if VerticalBooks
		if TargetBook.hasKeyword(VendorItemOreIngot)
			retVal = positionIngot(retVal, index, orient, orientAngle)
		elseif  retVal.getHeight() > 0
			retVal = positionOther(retVal, orient, orientAngle)
		endif
	endif

        ;Debug.TraceAndBox("UpdateSingleBook p2, retVal: x="+retVal.GetPositionX()+", y="+retVal.GetPositionY()+", z="+retVal.GetPositionZ())
        ;Debug.TraceAndBox("UpdateSingleBook p2, BookMarkerStart: x="+BookMarkerStart.GetPositionX()+", y="+BookMarkerStart.GetPositionY()+", z="+BookMarkerStart.GetPositionZ())
		
		if (BookOffset + bookAmt/TotalDistance) > (1.0 + (1.5 * MarkerHeight/TotalDistance))
			retVal.disable()
			retVal.delete()
			while NumBooks>index
				self.RemoveItem(PlacedBooks[ NumBooks - 1 ], 1, true, Game.GetPlayer())
				PlacedBooks[ NumBooks - 1 ]=None
				NumBooks -= 1
			endwhile
			Notification("Some items did not fit and have been given back")
			return None
		endif
		
		BookOffset+=bookAmt/TotalDistance
	endIf
	return retVal
EndFunction

ObjectReference Function positionBook(ObjectReference retVal, int orient, float orientAngle)
	float dx=xDist*(BookOffset );- (0.4 * MarkerHeight/TotalDistance)) ;-(MarkerHeight/2.0)
	float dy=yDist*(BookOffset );- (0.4 * MarkerHeight/TotalDistance))
	float dz=zDist*(BookOffset );- (0.4 * MarkerHeight/TotalDistance))
	dz += (retVal.getWidth() - MarkerWidth)/2.0

	if orient == 0 
		retVal.moveTo(BookMarkerStart,dx,dy,dz)
	else
		retVal.setAngle(0, 0, (MarkerAngle - 90.0)*OrientMult + orientAngle)
		retVal.moveTo(BookMarkerStart,dx,dy,dz, false)
	endif

	return retVal
		
EndFunction

ObjectReference Function positionOther(ObjectReference retVal, int orient, float orientAngle)
	float dx=xDist*(BookOffset );- (0.4 * MarkerHeight/TotalDistance)) ;-(MarkerHeight/2.0)
	float dy=yDist*(BookOffset );- (0.4 * MarkerHeight/TotalDistance))
	float dz=zDist*(BookOffset );- (0.4 * MarkerHeight/TotalDistance))
	;dz += (retVal.getHeight() - MarkerWidth)/2.0 
	dz -=  14.0
		;Debug.TraceAndBox("UpdateSingleBook adjust dz, dx: "+dx+", dy: "+dy+", dz: "+dz)

	if orient == 0 
		retVal.moveTo(BookMarkerStart,dx,dy,dz)
	else
		retVal.setAngle(0, 0, (MarkerAngle - 90.0)*OrientMult + orientAngle)
		retVal.moveTo(BookMarkerStart,dx,dy,dz, false)
	endif

	return retVal
		
EndFunction

ObjectReference Function positionIngot(ObjectReference retVal, int index, int orient, float orientAngle)
	float dx=xDist*(BookOffset );- (0.4 * MarkerHeight/TotalDistance)) ;-(MarkerHeight/2.0)
	float dy=yDist*(BookOffset );- (0.4 * MarkerHeight/TotalDistance))
	float dz=zDist*(BookOffset );- (0.4 * MarkerHeight/TotalDistance))
	int i=0
	bool b=false
	while !b && i<ingotR4.length - 3
		if ingotR4[i]==0 && ingotR3[i]>0 && ingotR3[i+1]>0
			dz += retVal.getHeight() * 3.3
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
			dz += retVal.getHeight() * 2.2
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
		ingotR1[index - stackedIngots]=bookOffset
	else
		float bookAmt = getBookAmount(retVal, orient)
		BookOffset-=bookAmt/TotalDistance
		stackedIngots += 1
	endif

	if orient == 0 
		retVal.moveTo(BookMarkerStart,dx,dy,dz)
        ;Debug.TraceAndBox("UpdateSingleBook moveTo, BookMarkerStart: "+BookMarkerStart+", dx: "+dx+", dy: "+dy+", dz: "+dz)
	else
		retVal.setAngle(0, 0, (MarkerAngle - 90.0)*OrientMult + orientAngle)
        ;Debug.TraceAndBox("UpdateSingleBook setAngle, Angle: "+((MarkerAngle - 90.0)*OrientMult + orientAngle))
		retVal.moveTo(BookMarkerStart,dx,dy,dz, false)
        ;Debug.TraceAndBox("UpdateSingleBook moveTo, BookMarkerStart: "+BookMarkerStart+", dx: "+dx+", dy: "+dy+", dz: "+dz)
	endif
	return retVal
EndFunction


ObjectReference Function positionBottle(ObjectReference retVal, int orient)
	float dx=xDist*(BookOffset );- (0.4 * MarkerHeight/TotalDistance)) ;-(MarkerHeight/2.0)
	float dy=yDist*(BookOffset );- (0.4 * MarkerHeight/TotalDistance))
	float dz=zDist*(BookOffset );- (0.4 * MarkerHeight/TotalDistance))

	if retVal.getHeight() > 0
		dz += (retVal.getHeight() - MarkerWidth)/2.0 ;
 	endif
	if orient == 0
		retVal.moveTo(BookMarkerStart,dx,dy,dz)
        ;Debug.TraceAndBox("positionBottle moveTo, BookMarkerStart: "+BookMarkerStart+", dx: "+dx+", dy: "+dy+", dz: "+dz)
	else
		retVal.setAngle(0, 0, (MarkerAngle - 90.0)*OrientMult)
        ;Debug.TraceAndBox("UpdateSingleBook setAngle, Angle: "+((MarkerAngle - 90.0)*OrientMult))
		retVal.moveTo(BookMarkerStart,dx,dy,dz, false)
        ;Debug.TraceAndBox("positionBottle moveTo, BookMarkerStart: "+BookMarkerStart+", dx: "+dx+", dy: "+dy+", dz: "+dz)
	endif
	return retVal
EndFunction

Function UpdateBooks()
	GoToState("PlacingBooks") ; Future calls should not mess with this stuff
	ingotR1 = new float[128]
	ingotR2 = new float[128]
	ingotR3 = new float[128]
	ingotR4 = new float[128]
	stackedIngots = 0
	;Start updating book locations
	BookOffset=0
	int i=0
        ;Debug.TraceAndBox("UpdateBooks, NumBooks: "+NumBooks)
	while i<NumBooks
		if self.getItemCount(PlacedBooks[i]) == 0
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
        ;Debug.TraceAndBox("UpdateBooks, enable: "+i)
		else
			CleanArrays()
		endif
		i+=1
	endwhile
	CurrentBookAmount = NumBooks
EndFunction

Function CleanArrays()
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
EndFunction

Function RecoverOldBooks()
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
EndFunction

bool Function isFull()
	return (NumBooks >= MaxBooks)
EndFunction

State PlacingBooks
	Function UpdateBooks()
		; Already updating books, so ignore
	EndFunction
	
	EVENT OnActivate(ObjectReference akActionRef)
	EndEvent
EndState 

