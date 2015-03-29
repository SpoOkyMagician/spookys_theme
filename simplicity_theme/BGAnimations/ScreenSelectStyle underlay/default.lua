-- ScreenSelectStyle underlay

local t = Def.ActorFrame{
	Name="ScreenSelectStyleUnderlayActorFrame";
	-- Function (scripts)
	common_text("Select Style"),
	-- Function (scripts)
	grid_m(),
	-- Function (scripts)
	neat_arrow_left(),
	-- Function (scripts)
	neat_arrow_right(),
	-- Function (scripts)
	theme_skin("select_theme_skin"),
	-- Actor (scripts)
	fast_song
};

return t;