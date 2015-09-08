-- ScreenEdit underlay

local t = Def.ActorFrame{
	Name="ScreenEditUnderlayActorFrame";
	-- Actor/Function (scripts)
	common_text("Editor"),
	-- Actor (left info quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+30,SCREEN_LEFT+152,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	},
	-- Actor (right info quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-2,SCREEN_TOP+30,SCREEN_RIGHT-152,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	}
};

return t;