local t = Def.ActorFrame{
	--[ screen text
	LoadFont("Common normal")..{
		Text="Title Screen | Options | Credits |";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5);
	},
	--[ play music
	main_song
};

return t;