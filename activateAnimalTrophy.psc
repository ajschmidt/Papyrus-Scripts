Scriptname activateAnimalTrophy extends ObjectReference  
{enables the trophy upon accomplishment}

EVENT OnCellLoad()
	if Game.QueryStat("Animals Killed") > killThreshold
		Enable()		
	endif
endEVENT

Int Property killThreshold  Auto  
{number of automatons killed enable trophy}

