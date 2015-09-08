-- ScreenEditMenu underlay

local t = Def.ActorFrame{
	Name="ScreenEditMenuOverlayActorFrame";
	-- Actor/Function (scripts)
	common_text("Edit Songs and Steps"),
	-- Actor/Function (scripts)
	grid_c(),
	-- Actor/Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor/Function (scripts)
	slow_song()
};

return t;