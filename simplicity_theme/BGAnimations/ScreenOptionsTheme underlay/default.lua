-- ScreenOptionsTheme underlay

local t = Def.ActorFrame{
	Name="ScreenOptionsThemeUnderlayActorFrame";
	-- Function (scripts)
	common_text("Theme Options"),
	-- Actor (scripts)
	grid_t,
	-- Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor (scripts)
	slow_song
};

return t;