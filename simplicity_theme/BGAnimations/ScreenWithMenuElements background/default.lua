-- ScreenWithMenuElements background

local t = Def.ActorFrame{
	Name="ScreenWithMenuElementsBackgroundActorFrame";
	-- Function (scripts)
	refresh_color(),
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
	theme_skin("theme_skin")
};

return t;