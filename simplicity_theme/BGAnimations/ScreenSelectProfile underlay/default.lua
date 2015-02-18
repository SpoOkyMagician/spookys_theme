-- ScreenSelectProfile underlay

local t = Def.ActorFrame{
	Name="ScreenSelectProfileUnderlayActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Function (scripts)
	common_text("Select Profile"),
	-- Actor (Profile Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-115,SCREEN_RIGHT-2,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	},
	-- Function (scripts)
	theme_skin("profile_theme_skin"),
	-- Actor (scripts)
	fast_song
};

return t;