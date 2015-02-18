-- ScreenOptionsAdvanced underlay

local t = Def.ActorFrame{
	Name="ScreenOptionsAdvancedUnderlayActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Function (scripts)
	common_text("Advanced Options"),
	-- Actor (scripts)
	grid_t,
	-- Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor (scripts)
	slow_song
};

return t;