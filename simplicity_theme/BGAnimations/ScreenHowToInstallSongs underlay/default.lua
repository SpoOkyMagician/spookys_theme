-- ScreenSelectProfile underlay

local t = Def.ActorFrame{
	-- GLOBAL screen text
	common_text("No Songs Loaded"),
	-- GLOBAL dark quad
	grid_t,
	-- no songs text
	LoadFont("SpoOky")..{
		Text="Oops! You do not have any songs installed! Install songs in StepMania is pretty easy. Follow these instructions below:\n\n1) Songs should be installed in your userdata directory. It should look something like this:\n\n    WINDOWS: C: - Users - <user> - AppData - Roaming - StepMania 5 - Songs - <Song Group> - <Song Folder> - <Files>\n    MAC: Library - Application Support - StepMania 5 - Songs - <Song Group> - <Song Folder> - <Files>\n    LINUX: .StepMania 5 - Songs - <Song Group> - <Song Folder> - <Files>\n\n    EXAMPLE: C: - Users - <user> - AppData - Roaming - StepMania 5 - Songs - In The Groove - (72 Song Folders) - (Specific Song)\n\n2) Once you have installed a song pack, go back to the main menu from here.\n3) Go to Settings/Options.\n4) Select Reload Songs/Courses.\n5) Enjoy!";
		InitCommand=cmd(x,SCREEN_LEFT+32;y,SCREEN_CENTER_Y;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
	},
	-- GLOBAL play music
	asian_song
};

return t;