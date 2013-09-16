Scriptname autoDeckGemContainerScript extends autoDeckContainerBase  

import debug
import utility

Keyword Property BookShelfBook01 Auto
;Keyword Property BookShelfBook02 Auto
Form Property PlacedBook01 Auto Hidden
;Form Property PlacedBook02 Auto Hidden
ObjectReference Property PlacedBook01Ref Auto Hidden
;ObjectReference Property PlacedBook02Ref Auto Hidden
Bool Property adAlreadyLoaded2 = FALSE Auto Hidden
Bool Property adAlreadyLoaded8 = FALSE Auto Hidden

;float minSize = 1.2
;float space = 0.2
int MaxBooks = 128

;Number of books on the shelf
int NumBooks = 0

;Distance from first to last book
;float TotalDistance = 0.0

;Fraction of total distance covered so far
;float BookOffset = 0.0
;float xDist = 0.0
;float yDist = 0.0
;float zDist = 0.0

;bool VerticalBooks = true
;float MarkerWidth = 23.0
;float MarkerHeight = 6.0
;float MarkerLength = 30.0
;float MarkerAngle
;float OrientMult = 1.0

;float[] ingotR1
;float[] ingotR2
;float[] ingotR3
;float[] ingotR4
;int stackedIngots

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
	;Debug.TraceAndBox("OnItemAdded, NumBooks: "+NumBooks+", MaxBooks: "+MaxBooks+", aiItemCount: "+aiItemCount)
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
		adAlreadyLoaded8 = true
	endif

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
	;Debug.TraceAndBox("autoDeckGemContainer.RemoveBooks()")

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

;float Function getBookAmount(ObjectReference BookRef, int orient = 0)
	;if !BookRef
		;return 0
	;endif
	;float dim = 0
	;if orient == 0
		;dim = BookRef.getHeight()
        ;Debug.TraceAndBox("getBookAmount, orient=0, obj: "+BookRef.getBaseObject()+", dim: "+dim)
	;elseif orient == 1
		;dim = BookRef.getLength() + 3
        ;Debug.TraceAndBox("getBookAmount, orient=1, obj: "+BookRef.getBaseObject()+", dim: "+dim)
	;else
		;dim = BookRef.getWidth() + 3
        ;Debug.TraceAndBox("getBookAmount, orient=2, obj: "+BookRef.getBaseObject()+", dim: "+dim)
	;endif
	;if dim<=3
		;dim += minSize
	;else
		;dim += space
	;endif
	;if dim<minSize
		;dim=minSize
	;endif
        ;Debug.TraceAndBox("getBookAmount, final, obj: "+BookRef.getBaseObject()+", dim: "+dim)
	;return dim
;endFunction

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


;Function CountMaxBooks()
	;if !BookMarkerEnd
        	;Debug.TraceAndBox("CountMaxBooks, BookMarkerEnd: "+BookMarkerEnd+", BookMarkerStart: "+BookMarkerStart)
	;endif
	; Checks how many books can be placed on this shelf
	;if GetLinkedRef(BookShelfBook02) 
		;BookMarkerEnd = GetLinkedRef(BookShelfBook02)
	;elseif GetLinkedRef(BookShelfBook01) 
		;BookMarkerEnd = GetLinkedRef(BookShelfBook01)
	;endif
	;xDist = BookMarkerEnd.getPositionX()-BookMarkerStart.getPositionX()
	;yDist = BookMarkerEnd.getPositionY()-BookMarkerStart.getPositionY()
	;zDist = BookMarkerEnd.getPositionZ()-BookMarkerStart.getPositionZ()
	;TotalDistance = Math.sqrt((xDist*xDist)+(yDist*yDist)+(zDist*zDist))
        ;Debug.TraceAndBox("CountMaxBooks, xDist: "+xDist+", yDist: "+yDist)
        ;Debug.TraceAndBox("CountMaxBooks, BookMarkerEnd: "+BookMarkerEnd+", BookMarkerStart: "+BookMarkerStart)
;endFunction


ObjectReference Function UpdateSingleBook(Form TargetBook, Int index)
	ObjectReference retVal
	;Debug.TraceAndBox("UpdateSingleBook, TargetBook: "+TargetBook)
	if TargetBook
		retVal = BookMarkerStart.PlaceAtMe(TargetBook)
		retVal.BlockActivation()
		;retVal.moveTo(BookMarkerStart,0,0,0)

		if index >= MaxBooks
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
	
	endIf
	return retVal
EndFunction


Function UpdateBooks()
	GoToState("PlacingBooks") ; Future calls should not mess with this stuff
	;ingotR1 = new float[128]
	;ingotR2 = new float[128]
	;ingotR3 = new float[128]
	;ingotR4 = new float[128]
	;stackedIngots = 0
	;Start updating book locations
	;BookOffset=0
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
	
	;Debug.TraceAndBox("UpdateBooks, i after Update: "+i)
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
	;PlacedBooks[1] = PlacedBook02
	;PlacedBooksRef[1] = PlacedBook02Ref
	;PlacedBook02 = None
	;PlacedBook02Ref = None
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

