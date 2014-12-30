-- ScreenEdit underlay

local t = Def.ActorFrame{
	Name="ScreenEditUnderlayActorFrame";
	-- GLOBAL screen text
	common_text("Editor"),
	-- left info quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+30,SCREEN_LEFT+152,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	},
	-- right info quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-2,SCREEN_TOP+30,SCREEN_RIGHT-152,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	},
	-- new theme skin i am experimenting with...
	LoadActor(THEME:GetPathG("","edit_theme_skin"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	}
};

return t;