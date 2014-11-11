-- ScreenCredits underlay

local t = Def.ActorFrame{
	Name="ScreenCreditsUnderlayActorFrame";
	-- GLOBAL screen text
	common_text("SM5 Credits"),
	-- GLOBAL dark quad
	grid_t,
	-- GLOBAL play music
	main_song
};

return t;