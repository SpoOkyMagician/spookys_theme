-- ScreenCredits underlay

local t = Def.ActorFrame{
	Name="ScreenCreditsUnderlayActorFrame";
	-- GLOBAL Function Theme Color
	refresh_color(),
	-- GLOBAL screen text
	common_text("SM5 Credits"),
	-- GLOBAL dark quad
	grid_t,
	-- GLOBAL play music
	main_song
};

return t;