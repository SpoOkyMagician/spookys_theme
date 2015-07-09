-- ScreenNetRoom underlay

local t = Def.ActorFrame{
	Name="ScreenNetRoomUnderlayActorFrame";
	-- Actor/Function (scripts)
	common_text("StepMania Online Lobby"),
	-- Actor (Last Round Info Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+8,SCREEN_TOP+40,SCREEN_RIGHT-8,SCREEN_TOP+204;diffuse,color(theme_background);basealpha,0.75);
	},
	-- Actor (Chat Output Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+8,SCREEN_TOP+208,SCREEN_LEFT+280,SCREEN_TOP+372;diffuse,color(theme_background);basealpha,0.75);
	},
	-- Actor (Chat Input Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+8,SCREEN_TOP+376,SCREEN_LEFT+280,SCREEN_TOP+446;diffuse,color(theme_background);basealpha,0.75);
	},
	-- Actor (Other Stuff Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+284,SCREEN_TOP+208,SCREEN_RIGHT-8,SCREEN_TOP+446;diffuse,color(theme_background);basealpha,0.75);
	},
	-- Actor/Function (scripts)
	theme_skin("lobby_theme_skin"),
	-- Actor/Function (scripts)
	slow_song()
};

return t;