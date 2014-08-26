-- ScreenSelectStyle underlay

local t = Def.ActorFrame{
	-- screen text
	LoadFont("SpoOky")..{
		Text="Select Style";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
	},
	-- menu items quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+314,SCREEN_BOTTOM/2-18,SCREEN_RIGHT-314,SCREEN_BOTTOM/2+18;diffuse,color("0,0,0,0.25"));
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