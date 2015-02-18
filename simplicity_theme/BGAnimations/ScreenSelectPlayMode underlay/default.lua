-- ScreenSelectPlayMode underlay

local t = Def.ActorFrame{
	Name="ScreenSelectPlayModeUnderlayActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Function (scripts)
	common_text("Select Play Mode"),
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