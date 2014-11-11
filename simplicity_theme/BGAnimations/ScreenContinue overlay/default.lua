-- ScreenContinue overlay
-- i do not believe this is called anymore...
-- however, i will leave it in for now...

local t = Def.ActorFrame{
	Name="ScreenContinueOverlayActorFrame";
	-- GLOBAL screen text
	common_text("Continue?"),
	-- GLOBAL play music
	slow_song
};

return t;