-- ScreenMapControllers underlay

local t = Def.ActorFrame{
	Name="ScreenMapControllersUnderlayActorFrame";
	-- GLOBAL Function Theme Color
	refresh_color(),
	-- GLOBAL screen text
	common_text("Configure Keys/Joysticks"),
	-- GLOBAL dark quad
	grid_t,
	-- GLOBAL play music
	slow_song
};

return t;