-- ScreenMapControllers underlay

local t = Def.ActorFrame{
	Name="ScreenMapControllersUnderlayActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Function (scripts)
	common_text("Configure Keys/Joysticks"),
	--Actor (scripts)
	grid_t,
	-- Actor (scripts)
	slow_song
};

return t;