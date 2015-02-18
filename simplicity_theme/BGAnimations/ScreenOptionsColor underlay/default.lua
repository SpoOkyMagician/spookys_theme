-- ScreenOptionsColor underlay

local t = Def.ActorFrame{
	Name="ScreenOptionsColorUnderlayActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Function (scripts)
	common_text("Theme Color"),
	-- Actor (scripts)
	grid_t,
	-- Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor (scripts)
	slow_song
};

return t;