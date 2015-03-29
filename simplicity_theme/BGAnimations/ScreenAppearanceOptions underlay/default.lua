-- ScreenAppearanceOptions underlay

local t = Def.ActorFrame{
	Name="ScreenAppearanceOptionsUnderlayActorFrame";
	-- Function (scripts)
	common_text("Appearance Options"),
	-- Actor (scripts)
	grid_t,
	-- Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor (scripts)
	slow_song
};

return t;