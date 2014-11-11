-- ScreenJukeboxMenu underlay

local t = Def.ActorFrame{
	Name="ScreenJukeboxMenuUnderlayActorFrame";
	-- GLOBAL screen text
	common_text("Jukebox Options"),
	-- GLOBAL dark quad
	grid_t,
	-- GLOBAL play music
	slow_song
};

return t;