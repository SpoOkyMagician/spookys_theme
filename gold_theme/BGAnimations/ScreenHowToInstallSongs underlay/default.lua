-- ScreenSelectProfile underlay

local t = Def.ActorFrame{
	-- screen text
	LoadFont("SpoOky")..{
		Text="No Songs Loaded";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
	},
	-- menu items quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-30,SCREEN_RIGHT-2,SCREEN_TOP+30;diffuse,color("0,0,0,0.75"));
	},
	-- no songs text
	LoadFont("SpoOky")..{
		Text="Oops! You do not have any songs installed! Install songs in StepMania is pretty easy. Follow these instructions below:\n\n1) Songs should be installed in your userdata directory. It should look something like this:\n\n    WINDOWS: C: - Users - <user> - AppData - Roaming - StepMania 5 - Songs - <Song Group> - <Song Folder> - <Files>\n    MAC: Library - Application Support - StepMania 5 - Songs - <Song Group> - <Song Folder> - <Files>\n    LINUX: .StepMania 5 - Songs - <Song Group> - <Song Folder> - <Files>\n\n    EXAMPLE: C: - Users - <user> - AppData - Roaming - StepMania 5 - Songs - In The Groove - (72 Song Folders) - (Specific Song)\n\n2) Once you have installed a song pack, go back to the main menu from here.\n3) Go to Settings/Options.\n4) Select Reload Songs/Courses.\n5) Enjoy!";
		InitCommand=cmd(x,SCREEN_LEFT+32;y,SCREEN_CENTER_Y;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
	},
	-- GLOBAL play music
	asian_song
};

return t;