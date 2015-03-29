-- ScreenOptionsInput underlay

local t = Def.ActorFrame{
	Name="ScreenOptionsInputUnderlayActorFrame";
	-- Function (scripts)
	common_text("Input Options"),
	-- Actor (scripts)
	grid_t,
	-- Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor (scripts)
	slow_song
};

return t;