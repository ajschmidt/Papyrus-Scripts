Scriptname TestAutoDeckTriggerScript extends ObjectReference  
{launches a test of the AutoDeck}
import debug
import utility

ObjectReference Property BowlRef auto
ObjectReference Property BookRef auto
ObjectReference Property PotionRef auto
ObjectReference Property WeaponRef auto
ObjectReference Property GemRef auto
ObjectReference Property SoulGemRef auto
ObjectReference Property NecklesRef auto
ObjectReference Property AmuletRef auto
ObjectReference Property IngotRef auto
ObjectReference Property GobletRef auto
ObjectReference Property StatueRef auto
ObjectReference Property MiscRef auto

event OnTriggerLeave(ObjectReference triggerActionRef)
	;debug.TraceAndBox("In Trigger")
	autoDeck adRef =  GetLinkedRef() as autoDeck
	adRef.AddItem( BowlRef.getBaseObject(), 11, false)
	adRef.AddItem( GobletRef.getBaseObject(), 11, false)
	adRef.AddItem( MiscRef.getBaseObject(), 11, false)
	adRef.AddItem( WeaponRef.getBaseObject(), 11, false)
	adRef.AddItem( BookRef.getBaseObject(), 11, false)
	adRef.AddItem( GemRef.getBaseObject(), 111, false)
	adRef.AddItem( StatueRef.getBaseObject(), 11, false)
	adRef.AddItem( IngotRef.getBaseObject(), 11, false)
	adRef.AddItem( NecklesRef.getBaseObject(), 11, false)
	adRef.AddItem( PotionRef.getBaseObject(), 11, false)
	adRef.AddItem( SoulGemRef.getBaseObject(), 11, false)
	adRef.Activate(triggerActionRef)
	;adRef.AddItem( Shadowmarks, 11, false)
	;adRef.AddItem( Book0DanceInFireV4, 11, false)
endEvent
