-- ScreenOptionsInput underlay

local t = Def.ActorFrame{
	Name="ScreenOptionsInputUnderlayActorFrame";
	-- Actor/Function (scripts)
	common_text("Input Options"),
	-- Actor/Function (scripts)
	grid_c(),
	-- Actor/Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor/Function (scripts)
	slow_song()
};

return t;