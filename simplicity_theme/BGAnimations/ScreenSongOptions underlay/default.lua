-- ScreenSongOptions underlay

local t = Def.ActorFrame{
	Name="ScreenSongOptionsUnderlayActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Function (scripts)
	common_text("Select Song Options"),
	-- Actor (scripts)
	grid_t,
	-- Function (scripts)
	theme_skin("options_theme_skin")
};

return t;