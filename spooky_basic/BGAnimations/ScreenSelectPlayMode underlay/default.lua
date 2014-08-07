local t = Def.ActorFrame{
	-- screen text
	LoadFont("Common normal")..{
		Text="Title Screen | Select Profile | Select Style | Select Game Mode |";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5);
	},
	-- neat arrows
	LoadActor("arrow")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-96;y,SCREEN_CENTER_Y;baserotationz,90;SetSize,32,32);
	},
	LoadActor("arrow")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+96;y,SCREEN_CENTER_Y;baserotationz,-90;SetSize,32,32);
	},
	-- GLOBAL play music
	sub_song
};

return t;