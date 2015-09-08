-- ScreenOptionsEdit underlay

local t = Def.ActorFrame{
	Name="ScreenOptionsEditUnderlayActorFrame";
	-- Actor/Function (scripts)
	common_text("Edit"),
	-- Actor/Function (scripts)
	grid_c(),
	-- new theme skin i am experimenting with...
	theme_skin("options_theme_skin"),
	-- Actor/Function (scripts)
	slow_song()
};

return t;