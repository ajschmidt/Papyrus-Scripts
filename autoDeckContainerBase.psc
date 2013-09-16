scriptname autoDeckContainerBase extends ObjectReference  

import debug
import utility

int Property CurrentBookAmount Auto Hidden
int Property MaxBooksAllowed Auto Hidden
bool Property adAlreadyLoaded = FALSE Auto Hidden
{Whether this script has already went through it's OnCellLoad() Event}

Keyword Property BookShelfTrigger01 Auto
Keyword Property BookShelfTrigger02 Auto
Keyword Property BookShelfTrigger03 Auto
Keyword Property BookShelfTrigger04 Auto
ObjectReference Property BookShelfTrigger01Ref Auto Hidden
ObjectReference Property BookShelfTrigger02Ref Auto Hidden
ObjectReference Property BookShelfTrigger03Ref Auto Hidden
ObjectReference Property BookShelfTrigger04Ref Auto Hidden

ObjectReference Property BookMarkerStart Auto Hidden 
ObjectReference Property BookMarkerEnd Auto Hidden 

Form[] Property PlacedBooks Auto Hidden
{List of Placed Book Forms}

ObjectReference[] Property PlacedBooksRef Auto Hidden
{List of Placed Book Refs}


Bool Property BlockBooks = FALSE Auto Hidden
{Used for when you can't place any more books}

Message Property BookShelfFirstActivateMESSAGE Auto
{Display message when the player activates a bookshelf for the first time.  Only displays once.}

Message Property BookShelfNoMoreRoomMESSAGE Auto
{Displayed message for when the amount of books the player is placing excedes the shelf limit.}

Message Property BookShelfNotABookMESSAGE Auto
{Message displayed when the player places the wrong form in the container.}

Message Property BookShelfRoomLeftMESSAGE Auto
{Notification that tells the player how much room is left on the shelf upon first activating it.}

GlobalVariable Property BookShelfGlobal Auto
{Global showing whether or not the player has ever activated a bookshelf}

function adAddItem(ObjectReference adActionRef, int refAmount)
	Debug.TraceAndBox("autoDeckContainerBase.adAddItem()")
endFunction


function RemoveBooks(Form BookBase, Int BookAmount)
	Debug.TraceAndBox("autoDeckContainerBase.RemoveBooks()")
endFunction

bool function isFull()
	Debug.TraceAndBox("autoDeckContainerBase.isFull()")
endFunction
