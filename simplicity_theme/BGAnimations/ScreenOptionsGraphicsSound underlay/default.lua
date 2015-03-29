-- ScreenOptionsGraphicsSound underlay

local t = Def.ActorFrame{
	Name="ScreenOptionsGraphicsSoundUnderlayActorFrame";
	-- Function (scripts)
	common_text("Graphics and Sound Options"),
	-- Actor (scripts)
	grid_t,
	-- Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor (scripts)
	slow_song
};

return t;