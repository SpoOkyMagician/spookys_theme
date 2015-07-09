-- ScreenOptionsAdvanced underlay

local t = Def.ActorFrame{
	Name="ScreenOptionsAdvancedUnderlayActorFrame";
	-- Actor/Function (scripts)
	common_text("Advanced Options"),
	-- Actor/Function (scripts)
	grid_c(),
	-- Actor/Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor/Function (scripts)
	slow_song()
};

return t;