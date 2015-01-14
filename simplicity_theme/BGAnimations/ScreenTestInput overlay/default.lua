-- ScreenTestInput overlay

local t = Def.ActorFrame{
	Name="ScreenTestInputOverlayActorFrame";
	-- GLOBAL Function Theme Color
	refresh_color(),
	-- GLOBAL screen text
	common_text("Test Input"),
	-- GLOBAL play music
	slow_song
};

return t;