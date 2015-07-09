-- ScreenNetworkOptions underlay

local t = Def.ActorFrame{
	Name="ScreenNetworkOptionsUnderlayActorFrame";
	-- Actor/Function (scripts)
	common_text("Network Options"),
	-- Actor/Function (scripts)
	grid_c(),
	-- Actor/Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor/Function (scripts)
	slow_song()
};

return t;