-- ScreenSetBGFit underlay

local t = Def.ActorFrame{
	Name="ScreenSetBGFitUnderlayActorFrame";
	-- GLOBAL screen text
	common_text("Select Background Fit"),
	-- GLOBAL dark quad
	grid_t,
	-- GLOBAL play music
	slow_song
};

return t;