-- ScreenOptionsArcade underlay

local t = Def.ActorFrame{
	Name="ScreenOptionsArcadeUnderlayActorFrame";
	-- Actor/Function (scripts)
	common_text("Arcade Options"),
	-- Actor/Function (scripts)
	grid_c(),
	-- Actor/Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor/Function (scripts)
	slow_song()
};

return t;