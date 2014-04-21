Scriptname autoDeckPotionContainerScript extends autoDeckContainerBase

import debug
import utility

Form Property LItemPotionClutter Auto
{Clutter item list to fill the shelf with}

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
{List of required Keywords}

ObjectReference Property PotionMarker01 Auto Hidden
ObjectReference Property PotionMarker02 Auto Hidden
ObjectReference Property PotionMarker03 Auto Hidden
ObjectReference Property PotionMarker04 Auto Hidden
ObjectReference Property PotionMarker05 Auto Hidden
ObjectReference Property PotionMarker06 Auto Hidden
ObjectReference Property PotionMarker07 Auto Hidden
ObjectReference Property PotionMarker08 Auto Hidden
ObjectReference Property PotionMarker09 Auto Hidden
ObjectReference Property PotionMarker10 Auto Hidden
ObjectReference Property PotionMarker11 Auto Hidden
ObjectReference Property PotionMarker12 Auto Hidden
ObjectReference Property PotionMarker13 Auto Hidden
ObjectReference Property PotionMarker14 Auto Hidden
ObjectReference Property PotionMarker15 Auto Hidden
ObjectReference Property PotionMarker16 Auto Hidden
ObjectReference Property PotionMarker17 Auto Hidden
ObjectReference Property PotionMarker18 Auto Hidden
ObjectReference Property PotionShelfTrigger01Ref Auto Hidden
ObjectReference Property PotionShelfTrigger02Ref Auto Hidden
ObjectReference Property PotionShelfTrigger03Ref Auto Hidden
ObjectReference Property PotionShelfTrigger04Ref Auto Hidden

Int Property MaxPotionsAllowed Auto Hidden
{Max potions allowed on this partciular shelf}

;Int Property CurrentBookAmount Auto Hidden
;{The current amount of potions placed on the shelf}

Form Property EmptyForm Auto Hidden
{Null Form}

ObjectReference Property EmptyRef Auto Hidden
{Null Ref}

Form Property CurrentPotionForm Auto Hidden
{Potion Form we are working with at any one time}

ObjectReference Property CurrentPotionRef Auto Hidden
{Potion Ref we are working with at any one time}

Form Property PlacedPotion01 Auto Hidden
Form Property PlacedPotion02 Auto Hidden
Form Property PlacedPotion03 Auto Hidden
Form Property PlacedPotion04 Auto Hidden
Form Property PlacedPotion05 Auto Hidden
Form Property PlacedPotion06 Auto Hidden
Form Property PlacedPotion07 Auto Hidden
Form Property PlacedPotion08 Auto Hidden
Form Property PlacedPotion09 Auto Hidden
Form Property PlacedPotion10 Auto Hidden
Form Property PlacedPotion11 Auto Hidden
Form Property PlacedPotion12 Auto Hidden
Form Property PlacedPotion13 Auto Hidden
Form Property PlacedPotion14 Auto Hidden
Form Property PlacedPotion15 Auto Hidden
Form Property PlacedPotion17 Auto Hidden
Form Property PlacedPotion16 Auto Hidden
Form Property PlacedPotion18 Auto Hidden
{List of Placed Potion Forms}

ObjectReference Property PlacedPotion01Ref Auto Hidden
ObjectReference Property PlacedPotion02Ref Auto Hidden
ObjectReference Property PlacedPotion03Ref Auto Hidden
ObjectReference Property PlacedPotion04Ref Auto Hidden
ObjectReference Property PlacedPotion05Ref Auto Hidden
ObjectReference Property PlacedPotion06Ref Auto Hidden
ObjectReference Property PlacedPotion07Ref Auto Hidden
ObjectReference Property PlacedPotion08Ref Auto Hidden
ObjectReference Property PlacedPotion09Ref Auto Hidden
ObjectReference Property PlacedPotion10Ref Auto Hidden
ObjectReference Property PlacedPotion11Ref Auto Hidden
ObjectReference Property PlacedPotion12Ref Auto Hidden
ObjectReference Property PlacedPotion13Ref Auto Hidden
ObjectReference Property PlacedPotion14Ref Auto Hidden
ObjectReference Property PlacedPotion15Ref Auto Hidden
ObjectReference Property PlacedPotion17Ref Auto Hidden
ObjectReference Property PlacedPotion16Ref Auto Hidden
ObjectReference Property PlacedPotion18Ref Auto Hidden
{List of Placed Potion Refs}

Bool Property AlreadyLoaded = FALSE Auto Hidden
{Whether this scritp has already went through it's OnCellLoad() Event}

Bool Property BlockPotions = FALSE Auto Hidden
{Used for when you can't place any more potions}

Message Property PotionShelfFirstActivateMESSAGE Auto
{Display message when the player activates a potionshelf for the first time.  Only displays once.}

Message Property PotionShelfNoMoreRoomMESSAGE Auto
{Displayed message for when the amount of potions the player is placing excedes the shelf limit.}

Message Property PotionShelfNotAPotionMESSAGE Auto
{Message displayed when the player places a non potion form in the container.}

Message Property PotionShelfRoomLeftMESSAGE Auto
{Notification that tells the player how much room is left on the shelf upon first activating it.}

GlobalVariable Property PotionShelfGlobal Auto
{Global showing whether or not the player has ever activated a potionshelf}


EVENT OnCellLoad()
	if AlreadyLoaded == FALSE
		Trace("POTIONS - Running OnCellLoad()")
		; Get all the potion markers
		PotionMarker01 = GetLinkedRef(BookShelfBook01)
		PotionMarker02 = GetLinkedRef(BookShelfBook02)
		PotionMarker03 = GetLinkedRef(BookShelfBook03)
		PotionMarker04 = GetLinkedRef(BookShelfBook04)
		PotionMarker05 = GetLinkedRef(BookShelfBook05)
		PotionMarker06 = GetLinkedRef(BookShelfBook06)
		PotionMarker07 = GetLinkedRef(BookShelfBook07)
		PotionMarker08 = GetLinkedRef(BookShelfBook08)
		PotionMarker09 = GetLinkedRef(BookShelfBook09)
		PotionMarker10 = GetLinkedRef(BookShelfBook10)
		PotionMarker11 = GetLinkedRef(BookShelfBook11)
		PotionMarker12 = GetLinkedRef(BookShelfBook12)
		PotionMarker13 = GetLinkedRef(BookShelfBook13)
		PotionMarker14 = GetLinkedRef(BookShelfBook14)
		PotionMarker15 = GetLinkedRef(BookShelfBook15)
		PotionMarker16 = GetLinkedRef(BookShelfBook16)
		PotionMarker17 = GetLinkedRef(BookShelfBook17)
		PotionMarker18 = GetLinkedRef(BookShelfBook18)
		PotionShelfTrigger01Ref = (GetLinkedRef(BookShelfTrigger01) as autoDeckShelfTriggerScript)
		PotionShelfTrigger02Ref = (GetLinkedRef(BookShelfTrigger02) as autoDeckShelfTriggerScript)
		PotionShelfTrigger03Ref = (GetLinkedRef(BookShelfTrigger03) as autoDeckShelfTriggerScript)
		PotionShelfTrigger04Ref = (GetLinkedRef(BookShelfTrigger04) as autoDeckShelfTriggerScript)
		; Count how many potions can be placed on this shelf
		CountMaxPotions()
		Self.AddItem(LItemPotionClutter, MaxPotionsAllowed)
		Wait(0.1)
		PlacePotions()

		if PotionShelfTrigger01Ref
			PotionShelfTrigger01Ref.GoToState("WaitForPotions")
		endif
		if PotionShelfTrigger02Ref
			PotionShelfTrigger02Ref.GoToState("WaitForPotions")
		endif
		if PotionShelfTrigger03Ref
			PotionShelfTrigger03Ref.GoToState("WaitForPotions")
		endif
		if PotionShelfTrigger04Ref
			PotionShelfTrigger04Ref.GoToState("WaitForPotions")
		endif
		
		UnBlockActivate()

		AlreadyLoaded = TRUE
		;AddInventoryEventFilter(new Potion)
	endif
endEVENT



EVENT OnActivate(ObjectReference akActionRef)
	; Removing all items from container as a precaution
	Trace("POTIONS - I've been ACTIVATED!",3)
	PotionShelfRoomLeftMESSAGE.Show((MaxPotionsAllowed - CurrentBookAmount))
	;debug.Notification("You can place " + (MaxPotionsAllowed - CurrentBookAmount) + " more potions on this shelf.")

	if (PotionShelfGlobal.GetValue() == 0)
		PotionShelfFirstActivateMESSAGE.Show()
		PotionShelfGlobal.SetValue(1)
	endif

	if PotionShelfTrigger01Ref
		PotionShelfTrigger01Ref.GoToState("IgnorePotions")
	endif
	if PotionShelfTrigger02Ref
		PotionShelfTrigger02Ref.GoToState("IgnorePotions")
	endif
	if PotionShelfTrigger03Ref
		PotionShelfTrigger03Ref.GoToState("IgnorePotions")
	endif
	if PotionShelfTrigger04Ref
		PotionShelfTrigger04Ref.GoToState("IgnorePotions")
	endif

	Wait(0.25)
	; The following will fire when the player leaves inventory
	Trace("AD Potion Rack - Out of Inventory so placing all the potions")
	DeletePotions()
	PlacePotions()
	;Wait(3)
	UnBlockActivate()

	if PotionShelfTrigger01Ref
		PotionShelfTrigger01Ref.GoToState("WaitForPotions")
	endif
	if PotionShelfTrigger02Ref
		PotionShelfTrigger02Ref.GoToState("WaitForPotions")
	endif
	if PotionShelfTrigger03Ref
		PotionShelfTrigger03Ref.GoToState("WaitForPotions")
	endif
	if PotionShelfTrigger04Ref
		PotionShelfTrigger04Ref.GoToState("WaitForPotions")
	endif
endEVENT


Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	;if (akBaseItem as Potion)
		if BlockPotions == FALSE
			; If the item is a potion find the corresponding potion reference and remove it.
			Trace("POTIONS - Form being Removed " + akBaseItem + " is a Potion! Removing "+aiItemCount+" from the list")
			CurrentBookAmount = CurrentBookAmount - aiItemCount
			RemovePotions(akBaseItem, aiItemCount)
		else
			BlockPotions = FALSE
		endif
	;endif
endEvent

event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	;Trace("PotionRack - Adding " + akBaseItem + " to the Potion Container from : "+ akSourceContainer)
	int overCount = 0
	int addedCount = 0
	
	if aiItemCount > 0
		addedCount = AddPotions(akBaseItem, aiItemCount)
		CurrentBookAmount = CurrentBookAmount + addedCount
		; If there wasn't room to place them all then there will be an
		; overCount
		overCount = aiItemCount - addedCount
	endif

	if overCount > 0
		; There is no room on the shelf.  Tell the player this and give him his potion back.
		if (akSourceContainer)
			utility.waitMenuMode(0)
			;MessageBox("You can't place that many potions on this shelf")
			PotionShelfNoMoreRoomMESSAGE.Show()
			Trace("PotionRack - Remove it from this container...")
		endif
	        BlockPotions = TRUE
		self.RemoveItem(akBaseItem, overCount, true, OverflowContainer)
		Trace("PotionRack - ...and give it back to the player", 3)
	endif
	
endEvent


function UnBlockActivate()
	if PlacedPotion01Ref
		PlacedPotion01Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion02Ref
		PlacedPotion02Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion03Ref
		PlacedPotion03Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion04Ref
		PlacedPotion04Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion05Ref
		PlacedPotion05Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion06Ref
		PlacedPotion06Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion07Ref
		PlacedPotion07Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion08Ref
		PlacedPotion08Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion09Ref
		PlacedPotion09Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion10Ref
		PlacedPotion10Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion11Ref
		PlacedPotion11Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion12Ref
		PlacedPotion12Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion13Ref
		PlacedPotion13Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion14Ref
		PlacedPotion14Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion15Ref
		PlacedPotion15Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion16Ref
		PlacedPotion16Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion17Ref
		PlacedPotion17Ref.BlockActivation(FALSE)
	endif
	if PlacedPotion18Ref
		PlacedPotion18Ref.BlockActivation(FALSE)
	endif
endFunction

function RemoveBooks(Form BookBase, Int BookAmount)
	RemovePotions(BookBase, BookAmount)
endFunction

function RemovePotions(Form PotionBase, Int PotionAmount)
	; Find an empty potion form and place the new potion there
	While PotionAmount > 0
		if PlacedPotion01 == PotionBase
			TRACE("POTIONS - PlacedPotion01 matches, Removing this potion")
			PlacedPotion01 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion02 == PotionBase
			TRACE("POTIONS - PlacedPotion02 matches, Removing this potion")
			PlacedPotion02 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion03 == PotionBase
			TRACE("POTIONS - PlacedPotion03 matches, Removing this potion")
			PlacedPotion03 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion04 == PotionBase
			TRACE("POTIONS - PlacedPotion04 matches, Removing this potion")
			PlacedPotion04 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion05 == PotionBase
			TRACE("POTIONS - PlacedPotion05 matches, Removing this potion")
			PlacedPotion05 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion06 == PotionBase
			TRACE("POTIONS - PlacedPotion06 matches, Removing this potion")
			PlacedPotion06 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion07 == PotionBase
			TRACE("POTIONS - PlacedPotion07 matches, Removing this potion")
			PlacedPotion07 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion08 == PotionBase
			TRACE("POTIONS - PlacedPotion08 matches, Removing this potion")
			PlacedPotion08 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion09 == PotionBase
			TRACE("POTIONS - PlacedPotion09 matches, Removing this potion")
			PlacedPotion09 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion10 == PotionBase
			TRACE("POTIONS - PlacedPotion10 matches, Removing this potion")
			PlacedPotion10 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion11 == PotionBase
			TRACE("POTIONS - PlacedPotion11 matches, Removing this potion")
			PlacedPotion11 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion12 == PotionBase
			TRACE("POTIONS - PlacedPotion12 matches, Removing this potion")
			PlacedPotion12 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion13 == PotionBase
			TRACE("POTIONS - PlacedPotion13 matches, Removing this potion")
			PlacedPotion13 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion14 == PotionBase
			TRACE("POTIONS - PlacedPotion14 matches, Removing this potion")
			PlacedPotion14 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion15 == PotionBase
			TRACE("POTIONS - PlacedPotion15 matches, Removing this potion")
			PlacedPotion15 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion16 == PotionBase
			TRACE("POTIONS - PlacedPotion16 matches, Removing this potion")
			PlacedPotion16 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion17 == PotionBase
			TRACE("POTIONS - PlacedPotion17 matches, Removing this potion")
			PlacedPotion17 = EmptyForm
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion18 == PotionBase
			TRACE("POTIONS - PlacedPotion18 matches, Removing this potion")
			PlacedPotion18 = EmptyForm
			PotionAmount = PotionAmount - 1
		else
			TRACE("POTIONS - No Potions matching, decrementing counter.")
			PotionAmount = PotionAmount - 1
		endif

	endWhile
endFunction


function DeletePotions()
	; Disables then deletes all the current potions on the shelf.
	if PlacedPotion01Ref
		PlacedPotion01Ref.Disable()
		PlacedPotion01Ref.Delete()
	endif
	if PlacedPotion02Ref
		PlacedPotion02Ref.Disable()
		PlacedPotion02Ref.Delete()
	endif
	if PlacedPotion03Ref
		PlacedPotion03Ref.Disable()
		PlacedPotion03Ref.Delete()
	endif
	if PlacedPotion04Ref
		PlacedPotion04Ref.Disable()
		PlacedPotion04Ref.Delete()
	endif
	if PlacedPotion05Ref
		PlacedPotion05Ref.Disable()
		PlacedPotion05Ref.Delete()
	endif
	if PlacedPotion06Ref
		PlacedPotion06Ref.Disable()
		PlacedPotion06Ref.Delete()
	endif
	if PlacedPotion07Ref
		PlacedPotion07Ref.Disable()
		PlacedPotion07Ref.Delete()
	endif
	if PlacedPotion08Ref
		PlacedPotion08Ref.Disable()
		PlacedPotion08Ref.Delete()
	endif
	if PlacedPotion09Ref
		PlacedPotion09Ref.Disable()
		PlacedPotion09Ref.Delete()
	endif
	if PlacedPotion10Ref
		PlacedPotion10Ref.Disable()
		PlacedPotion10Ref.Delete()
	endif
	if PlacedPotion11Ref
		PlacedPotion11Ref.Disable()
		PlacedPotion11Ref.Delete()
	endif
	if PlacedPotion12Ref
		PlacedPotion12Ref.Disable()
		PlacedPotion12Ref.Delete()
	endif
	if PlacedPotion13Ref
		PlacedPotion13Ref.Disable()
		PlacedPotion13Ref.Delete()
	endif
	if PlacedPotion14Ref
		PlacedPotion14Ref.Disable()
		PlacedPotion14Ref.Delete()
	endif
	if PlacedPotion15Ref
		PlacedPotion15Ref.Disable()
		PlacedPotion15Ref.Delete()
	endif
	if PlacedPotion16Ref
		PlacedPotion16Ref.Disable()
		PlacedPotion16Ref.Delete()
	endif
	if PlacedPotion17Ref
		PlacedPotion17Ref.Disable()
		PlacedPotion17Ref.Delete()
	endif
	if PlacedPotion18Ref
		PlacedPotion18Ref.Disable()
		PlacedPotion18Ref.Delete()
	endif
	
endFunction


function PlacePotions()
	GoToState("PlacingPotions")
	; Placeds all the potions added to the container in the designated forms
	if PlacedPotion01
		PlacedPotion01Ref = PotionMarker01.PlaceAtMe(PlacedPotion01)
		PlacedPotion01Ref.BlockActivation()
	endif
	if PlacedPotion02
		PlacedPotion02Ref = PotionMarker02.PlaceAtMe(PlacedPotion02)
		PlacedPotion02Ref.BlockActivation()
	endif
	if PlacedPotion03
		PlacedPotion03Ref = PotionMarker03.PlaceAtMe(PlacedPotion03)
		PlacedPotion03Ref.BlockActivation()
	endif
	if PlacedPotion04
		PlacedPotion04Ref = PotionMarker04.PlaceAtMe(PlacedPotion04)
		PlacedPotion04Ref.BlockActivation()
	endif
	if PlacedPotion05
		PlacedPotion05Ref = PotionMarker05.PlaceAtMe(PlacedPotion05)
		PlacedPotion05Ref.BlockActivation()
	endif
	if PlacedPotion06
		PlacedPotion06Ref = PotionMarker06.PlaceAtMe(PlacedPotion06)
		PlacedPotion06Ref.BlockActivation()
	endif
	if PlacedPotion07
		PlacedPotion07Ref = PotionMarker07.PlaceAtMe(PlacedPotion07)
		PlacedPotion07Ref.BlockActivation()
	endif
	if PlacedPotion08
		PlacedPotion08Ref = PotionMarker08.PlaceAtMe(PlacedPotion08)
		PlacedPotion08Ref.BlockActivation()
	endif
	if PlacedPotion09
		PlacedPotion09Ref = PotionMarker09.PlaceAtMe(PlacedPotion09)
		PlacedPotion09Ref.BlockActivation()
	endif
	if PlacedPotion10
		PlacedPotion10Ref = PotionMarker10.PlaceAtMe(PlacedPotion10)
		PlacedPotion10Ref.BlockActivation()
	endif
	if PlacedPotion11
		PlacedPotion11Ref = PotionMarker11.PlaceAtMe(PlacedPotion11)
		PlacedPotion11Ref.BlockActivation()
	endif
	if PlacedPotion12
		PlacedPotion12Ref = PotionMarker12.PlaceAtMe(PlacedPotion12)
		PlacedPotion12Ref.BlockActivation()
	endif
	if PlacedPotion13
		PlacedPotion13Ref = PotionMarker13.PlaceAtMe(PlacedPotion13)
		PlacedPotion13Ref.BlockActivation()
	endif
	if PlacedPotion14
		PlacedPotion14Ref = PotionMarker14.PlaceAtMe(PlacedPotion14)
		PlacedPotion14Ref.BlockActivation()
	endif
	if PlacedPotion15
		PlacedPotion15Ref = PotionMarker15.PlaceAtMe(PlacedPotion15)
		PlacedPotion15Ref.BlockActivation()
	endif
	if PlacedPotion16
		PlacedPotion16Ref = PotionMarker16.PlaceAtMe(PlacedPotion16)
		PlacedPotion16Ref.BlockActivation()
	endif
	if PlacedPotion17
		PlacedPotion17Ref = PotionMarker17.PlaceAtMe(PlacedPotion17)
		PlacedPotion17Ref.BlockActivation()
	endif
	if PlacedPotion18
		PlacedPotion18Ref = PotionMarker18.PlaceAtMe(PlacedPotion18)
		PlacedPotion18Ref.BlockActivation()
	endif
	GoToState("")
endFunction


function AddPotionRef(ObjectReference PotionRef, Int PotionAmount)
	; Find an empty potion form and place the new potion there
  	Form PotionBase = PotionRef.GetBaseObject() 

	While PotionAmount > 0
		if PlacedPotion01 == EmptyForm
			TRACE("POTIONS - PlacedPotion01 is empty, placing potion there")
			PlacedPotion01 = PotionBase
		        PlacedPotion01Ref = PotionMarker01.PlaceAtMe(PlacedPotion01)
		        PlacedPotion01Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion02 == EmptyForm
			TRACE("POTIONS - PlacedPotion02 is empty, placing potion there")
			PlacedPotion02 = PotionBase
		        PlacedPotion02Ref = PotionMarker02.PlaceAtMe(PlacedPotion02)
		        PlacedPotion02Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion03 == EmptyForm
			TRACE("POTIONS - PlacedPotion03 is empty, placing potion there")
			PlacedPotion03 = PotionBase
		        PlacedPotion03Ref = PotionMarker03.PlaceAtMe(PlacedPotion03)
		        PlacedPotion03Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion04 == EmptyForm
			TRACE("POTIONS - PlacedPotion04 is empty, placing potion there")
			PlacedPotion04 = PotionBase
		        PlacedPotion04Ref = PotionMarker04.PlaceAtMe(PlacedPotion04)
		        PlacedPotion04Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion05 == EmptyForm
			TRACE("POTIONS - PlacedPotion05 is empty, placing potion there")
			PlacedPotion05 = PotionBase
		        PlacedPotion05Ref = PotionMarker05.PlaceAtMe(PlacedPotion05)
		        PlacedPotion05Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion06 == EmptyForm
			TRACE("POTIONS - PlacedPotion06 is empty, placing potion there")
			PlacedPotion06 = PotionBase
		        PlacedPotion06Ref = PotionMarker06.PlaceAtMe(PlacedPotion06)
		        PlacedPotion06Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion07 == EmptyForm
			TRACE("POTIONS - PlacedPotion07 is empty, placing potion there")
			PlacedPotion07 = PotionBase
		        PlacedPotion07Ref = PotionMarker07.PlaceAtMe(PlacedPotion07)
		        PlacedPotion07Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion08 == EmptyForm
			TRACE("POTIONS - PlacedPotion08 is empty, placing potion there")
			PlacedPotion08 = PotionBase
		        PlacedPotion08Ref = PotionMarker08.PlaceAtMe(PlacedPotion08)
		        PlacedPotion08Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion09 == EmptyForm
			TRACE("POTIONS - PlacedPotion09 is empty, placing potion there")
			PlacedPotion09 = PotionBase
		        PlacedPotion09Ref = PotionMarker09.PlaceAtMe(PlacedPotion09)
		        PlacedPotion09Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion10 == EmptyForm
			TRACE("POTIONS - PlacedPotion10 is empty, placing potion there")
			PlacedPotion10 = PotionBase
		        PlacedPotion10Ref = PotionMarker10.PlaceAtMe(PlacedPotion10)
		        PlacedPotion10Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion11 == EmptyForm
			TRACE("POTIONS - PlacedPotion11 is empty, placing potion there")
			PlacedPotion11 = PotionBase
		        PlacedPotion11Ref = PotionMarker11.PlaceAtMe(PlacedPotion11)
		        PlacedPotion11Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion12 == EmptyForm
			TRACE("POTIONS - PlacedPotion12 is empty, placing potion there")
			PlacedPotion12 = PotionBase
		        PlacedPotion12Ref = PotionMarker12.PlaceAtMe(PlacedPotion12)
		        PlacedPotion12Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion13 == EmptyForm
			TRACE("POTIONS - PlacedPotion13 is empty, placing potion there")
			PlacedPotion13 = PotionBase
		        PlacedPotion13Ref = PotionMarker13.PlaceAtMe(PlacedPotion13)
		        PlacedPotion13Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion14 == EmptyForm
			TRACE("POTIONS - PlacedPotion14 is empty, placing potion there")
			PlacedPotion14 = PotionBase
		        PlacedPotion14Ref = PotionMarker14.PlaceAtMe(PlacedPotion14)
		        PlacedPotion14Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion15 == EmptyForm
			TRACE("POTIONS - PlacedPotion15 is empty, placing potion there")
			PlacedPotion15 = PotionBase
		        PlacedPotion15Ref = PotionMarker15.PlaceAtMe(PlacedPotion15)
		        PlacedPotion15Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion16 == EmptyForm
			TRACE("POTIONS - PlacedPotion16 is empty, placing potion there")
			PlacedPotion16 = PotionBase
		        PlacedPotion16Ref = PotionMarker16.PlaceAtMe(PlacedPotion16)
		        PlacedPotion16Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion17 == EmptyForm
			TRACE("POTIONS - PlacedPotion17 is empty, placing potion there")
			PlacedPotion17 = PotionBase
		        PlacedPotion17Ref = PotionMarker17.PlaceAtMe(PlacedPotion17)
		        PlacedPotion17Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		elseif PlacedPotion18 == EmptyForm
			TRACE("POTIONS - PlacedPotion18 is empty, placing potion there")
			PlacedPotion18 = PotionBase
		        PlacedPotion18Ref = PotionMarker18.PlaceAtMe(PlacedPotion18)
		        PlacedPotion18Ref.BlockActivation()
			PotionAmount = PotionAmount - 1
		endif
	endWhile
endFunction

; returns the number of potions added
int function AddPotions(Form PotionBase, Int PotionAmount)
	; Find an empty potion form and place the new potion there
	int addCount = 0
	while PotionAmount > addCount
		if PlacedPotion01 == EmptyForm
			TRACE("POTIONS - PlacedPotion01 is empty, placing potion there")
			PlacedPotion01 = PotionBase
			addCount += 1
		elseif PlacedPotion02 == EmptyForm
			TRACE("POTIONS - PlacedPotion02 is empty, placing potion there")
			PlacedPotion02 = PotionBase
			addCount += 1
		elseif PlacedPotion03 == EmptyForm
			TRACE("POTIONS - PlacedPotion03 is empty, placing potion there")
			PlacedPotion03 = PotionBase
			addCount += 1
		elseif PlacedPotion04 == EmptyForm
			TRACE("POTIONS - PlacedPotion04 is empty, placing potion there")
			PlacedPotion04 = PotionBase
			addCount += 1
		elseif PlacedPotion05 == EmptyForm
			TRACE("POTIONS - PlacedPotion05 is empty, placing potion there")
			PlacedPotion05 = PotionBase
			addCount += 1
		elseif PlacedPotion06 == EmptyForm
			TRACE("POTIONS - PlacedPotion06 is empty, placing potion there")
			PlacedPotion06 = PotionBase
			addCount += 1
		elseif PlacedPotion07 == EmptyForm
			TRACE("POTIONS - PlacedPotion07 is empty, placing potion there")
			PlacedPotion07 = PotionBase
			addCount += 1
		elseif PlacedPotion08 == EmptyForm
			TRACE("POTIONS - PlacedPotion08 is empty, placing potion there")
			PlacedPotion08 = PotionBase
			addCount += 1
		elseif PlacedPotion09 == EmptyForm
			TRACE("POTIONS - PlacedPotion09 is empty, placing potion there")
			PlacedPotion09 = PotionBase
			addCount += 1
		elseif PlacedPotion10 == EmptyForm
			TRACE("POTIONS - PlacedPotion10 is empty, placing potion there")
			PlacedPotion10 = PotionBase
			addCount += 1
		elseif PlacedPotion11 == EmptyForm
			TRACE("POTIONS - PlacedPotion11 is empty, placing potion there")
			PlacedPotion11 = PotionBase
			addCount += 1
		elseif PlacedPotion12 == EmptyForm
			TRACE("POTIONS - PlacedPotion12 is empty, placing potion there")
			PlacedPotion12 = PotionBase
			addCount += 1
		elseif PlacedPotion13 == EmptyForm
			TRACE("POTIONS - PlacedPotion13 is empty, placing potion there")
			PlacedPotion13 = PotionBase
			addCount += 1
		elseif PlacedPotion14 == EmptyForm
			TRACE("POTIONS - PlacedPotion14 is empty, placing potion there")
			PlacedPotion14 = PotionBase
			addCount += 1
		elseif PlacedPotion15 == EmptyForm
			TRACE("POTIONS - PlacedPotion15 is empty, placing potion there")
			PlacedPotion15 = PotionBase
			addCount += 1
		elseif PlacedPotion16 == EmptyForm
			TRACE("POTIONS - PlacedPotion16 is empty, placing potion there")
			PlacedPotion16 = PotionBase
			addCount += 1
		elseif PlacedPotion17 == EmptyForm
			TRACE("POTIONS - PlacedPotion17 is empty, placing potion there")
			PlacedPotion17 = PotionBase
			addCount += 1
		elseif PlacedPotion18 == EmptyForm
			TRACE("POTIONS - PlacedPotion18 is empty, placing potion there")
			PlacedPotion18 = PotionBase
			addCount += 1
		else
			return addCount
		endif
	endWhile
	return addCount
endFunction


function CountMaxPotions()
	; Checks how many potions can be placed on this shelf
	if PotionMarker01 == EmptyRef
		MaxPotionsAllowed = 0
	elseif PotionMarker02 == EmptyRef
		MaxPotionsAllowed = 1
	elseif PotionMarker03 == EmptyRef
		MaxPotionsAllowed = 2
	elseif PotionMarker04 == EmptyRef
		MaxPotionsAllowed = 3
	elseif PotionMarker05 == EmptyRef
		MaxPotionsAllowed = 4
	elseif PotionMarker06 == EmptyRef
		MaxPotionsAllowed = 5
	elseif PotionMarker07 == EmptyRef
		MaxPotionsAllowed = 6
	elseif PotionMarker08 == EmptyRef
		MaxPotionsAllowed = 7
	elseif PotionMarker09 == EmptyRef
		MaxPotionsAllowed = 8
	elseif PotionMarker10 == EmptyRef
		MaxPotionsAllowed = 9
	elseif PotionMarker11 == EmptyRef
		MaxPotionsAllowed = 10
	elseif PotionMarker12 == EmptyRef
		MaxPotionsAllowed = 11
	elseif PotionMarker13 == EmptyRef
		MaxPotionsAllowed = 12
	elseif PotionMarker14 == EmptyRef
		MaxPotionsAllowed = 13
	elseif PotionMarker15 == EmptyRef
		MaxPotionsAllowed = 14
	elseif PotionMarker16 == EmptyRef
		MaxPotionsAllowed = 15
	elseif PotionMarker17 == EmptyRef
		MaxPotionsAllowed = 16
	elseif PotionMarker18 == EmptyRef
		MaxPotionsAllowed = 17
	elseif PotionMarker18
		MaxPotionsAllowed = 18
	endif
	Trace("POTIONS - " + MaxPotionsAllowed + " potions can be placed on this shelf")
endFunction

bool function isFull()
	if (CurrentBookAmount < MaxPotionsAllowed)
		return false
	else
		return true
	endif
endFunction

state PlacingPotions
	function PlacePotions()
	endfunction
	event OnActivate(ObjectReference akActionRef)
	endEvent
	function RemovePotions(Form PotionBase, Int PotionAmount)
	endFunction
	function DeletePotions()
	endFunction
endState

	
