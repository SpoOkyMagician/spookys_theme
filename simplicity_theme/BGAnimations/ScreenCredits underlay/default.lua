-- ScreenCredits underlay

local t = Def.ActorFrame{
	Name="ScreenCreditsUnderlayActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Function (scripts)
	common_text("StepMania Credits"),
	-- Actor (scripts)
	grid_t,
	-- Actor (scripts)
	main_song
};

return t;