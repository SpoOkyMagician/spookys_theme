-- ScreenReloadSongs background

local t = Def.ActorFrame{
	Name="ScreenReloadSongsBackgroundActorFrame";
	-- Actor (Generic BG)
	LoadActor(THEME:GetPathG("","bg_generic"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- Actor (scripts)
	grid_u,
	-- Actor (scripts)
	grid_b,
	-- Actor (scripts)
	grid_c,
	-- Function (scripts)
	common_text("Reload Songs"),
	-- Actor (scripts)
	grid_t,
	-- Function (scripts)
	theme_skin("theme_skin"),
	-- Actor (scripts)
	slow_song
};

return t;