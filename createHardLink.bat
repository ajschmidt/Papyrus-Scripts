:: Source file goes in .../Papyrus-Scripts
:: Hardlink will appear in :
::   C:\Program Files (x86)\Steam\SteamApps\common\Skyrim\Data\Scripts\Source
:: You can now edit the file with the Creation Kit

mklink /h "C:\Program Files (x86)\Steam\SteamApps\common\Skyrim\Data\Scripts\Source\%1" "C:\Users\Main\My Documents\GitHub\Papyrus-Scripts\%1"

ECHO You can now edit the file with the Creation Kit
