-- ScreenSelectProfile underlay

local t = Def.ActorFrame{
	Name="ScreenSelectProfileUnderlayActorFrame";
	-- Actor/Function (scripts)
	common_text("Select Profile"),
	-- Actor (Profile Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-115,SCREEN_RIGHT-2,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	},
	-- Actor/Function (scripts)
	theme_skin("profile_theme_skin"),
	-- Actor/Function (scripts)
	fast_song()
};

return t;