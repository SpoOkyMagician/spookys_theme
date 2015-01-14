-- ScreenSelectProfile underlay

local t = Def.ActorFrame{
	Name="ScreenSelectProfileUnderlayActorFrame";
	-- GLOBAL Function Theme Color
	refresh_color(),
	-- GLOBAL screen text
	common_text("Select Profile"),
	-- profile quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-115,SCREEN_RIGHT-2,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	},
	-- new theme skin i am experimenting with...
	LoadActor(THEME:GetPathG("","profile_theme_skin"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- GLOBAL play music
	fast_song
};

return t;