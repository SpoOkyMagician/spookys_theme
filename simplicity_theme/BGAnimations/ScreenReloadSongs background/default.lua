-- ScreenReloadSongs background

local t = Def.ActorFrame{
	Name="ScreenReloadSongsBackgroundActorFrame";
	-- (Bugfix: don't translate/screen text here...)
	-- Actor (Generic BG)
	LoadActor(THEME:GetPathG("","bg_generic"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- Actor/Function (scripts)
	grid_d(),
	-- Actor (scripts)
	grid_a(),
	-- Actor/Function (scripts)
	grid_b(),
	-- Actor/Function (scripts)
	grid_c(),
	-- Actor/Function (scripts)
	theme_skin("theme_skin"),
	-- Actor/Function (scripts)
	slow_song()
};

return t;