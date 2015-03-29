-- ScreenHowToInstallSongs underlay
-- They should technically never reach this but, just in case, I will leave this here...

local t = Def.ActorFrame{
	Name="ScreenHowToInstallSongsActorFrame";
	-- function (scripts)
	common_text("No Songs Loaded"),
	-- Actor (scripts)
	grid_t,
	-- Actor (No Songs Text)
	LoadFont("Common","normal")..{
		Text="Oops! You do not have any songs installed! Install songs in StepMania is pretty easy. Follow these instructions below:\n\n1) Songs should be installed in your userdata directory. It should look something like this:\n\n    WINDOWS: C: - Users - <user> - AppData - Roaming - StepMania 5 - Songs - <Song Group> - <Song Folder> - <Files>\n    MAC: Library - Application Support - StepMania 5 - Songs - <Song Group> - <Song Folder> - <Files>\n    LINUX: .StepMania 5 - Songs - <Song Group> - <Song Folder> - <Files>\n\n    EXAMPLE: C: - Users - <user> - AppData - Roaming - StepMania 5 - Songs - In The Groove - (72 Song Folders) - (Specific Song)\n\n2) Once you have installed a song pack, go back to the main menu from here.\n3) Go to Settings/Options.\n4) Select Reload Songs/Courses.\n5) Enjoy!";
		InitCommand=cmd(x,SCREEN_LEFT+32;y,SCREEN_CENTER_Y;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
	},
	-- Actor (scripts)
	slow_song
};

return t;