-- ScreenSelectPlayMode underlay

local t = Def.ActorFrame{
	-- GLOBAL screen text
	common_text("Select Play Mode"),
	-- menu items quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+314,SCREEN_BOTTOM/2-18,SCREEN_RIGHT-314,SCREEN_BOTTOM/2+18;diffuse,color("0,0,0,0.5"));
	},
	-- neat arrows
	LoadActor(THEME:GetPathG("","arrow"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-96;y,SCREEN_CENTER_Y;baserotationz,90;SetSize,32,32;bob;effectmagnitude,2,0,0;effecttiming,0.25,0.25,0.25,0.25);
	},
	LoadActor(THEME:GetPathG("","arrow"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+96;y,SCREEN_CENTER_Y;baserotationz,-90;SetSize,32,32;bob;effectmagnitude,2,0,0;effecttiming,0.25,0.25,0.25,0.25);
	},
	-- GLOBAL play music
	sub_song
};

return t;