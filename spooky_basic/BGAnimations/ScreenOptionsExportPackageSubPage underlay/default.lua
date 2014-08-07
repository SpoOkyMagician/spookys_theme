local t = Def.ActorFrame{
	-- screen text
	LoadFont("Common normal")..{
		Text="Title Screen | Edit | Export Packages | Exports |";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5);
	}
	-- GLOBAL play music
	-- edit: this breaks it... (plays music twice) don't do this...
};

return t;