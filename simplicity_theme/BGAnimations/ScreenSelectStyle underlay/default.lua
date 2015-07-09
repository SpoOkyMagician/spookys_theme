-- ScreenSelectStyle underlay

local t = Def.ActorFrame{
	Name="ScreenSelectStyleUnderlayActorFrame";
	-- Actor/Function (scripts)
	common_text("Select Style"),
	-- Actor/Function (scripts)
	grid_e(),
	-- Actor/Function (scripts)
	neat_arrow_left(),
	-- Actor/Function (scripts)
	neat_arrow_right(),
	-- Actor/Function (scripts)
	theme_skin("select_theme_skin"),
	-- Actor/Function (scripts)
	fast_song()
};

return t;