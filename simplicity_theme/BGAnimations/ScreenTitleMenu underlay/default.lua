-- ScreenTitleMenu underlay

local t = Def.ActorFrame{
	Name="ScreenTitleMenuUnderlayActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Actor (scripts)
	LoadActor(THEME:GetPathG("","bg_generic"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- Actor (scripts)
	grid_u,
	-- Actor (scripts)
	grid_b,
	-- Actor (scripts)
	grid_c,
	-- Function (scripts)
	grid_m(),
	-- Actor (Menu Info Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-115,SCREEN_RIGHT-2,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	},
	neat_arrow_left(),
	neat_arrow_right(),
	-- Function (scripts)
	common_text("Title Screen"),
	-- Actor (Logo Text)
	LoadFont("Common","normal")..{
		Text="STEPMANIA 5";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/3;diffuse,color(theme_color);zoom,3.0;align,0.5,0.5;shadowlength,3;shadowcolor,color(theme_background));
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			self:finishtweening();
			self:diffuseupperleft(color("1,0.9,1,1"));
			self:zoom(1.0);
			self:diffusealpha(0.2);
			self:sleep(0.02);
			self:zoom(1.25);
			self:diffusealpha(0.3);
			self:sleep(0.03);
			self:zoom(1.5);
			self:diffusealpha(0.4);
			self:sleep(0.04);
			self:zoom(1.75);
			self:diffusealpha(0.5);
			self:sleep(0.05);
			self:zoom(2.0);
			self:diffusealpha(0.6);
			self:sleep(0.06);
			self:zoom(2.25);
			self:diffusealpha(0.7);
			self:sleep(0.07);
			self:zoom(2.5);
			self:diffusealpha(0.8);
			self:sleep(0.08);
			self:zoom(2.75);
			self:diffusealpha(0.9);
			self:sleep(0.09);
			self:zoom(3.0);
			self:diffusealpha(1);
			self:sleep(0.1);
		end;
	},
	-- Actor (Product Version Text)
	LoadFont("Common","normal")..{
		Text=ProductVersion();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+32;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
	},
	-- Actor (Build Date Text)
	LoadFont("Common","normal")..{
		Text=VersionDate();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+48;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
	},
	-- Actor (Build Time Text)
	LoadFont("Common","normal")..{
		Text=VersionTime();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+64;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
	},
	-- Actor (Server Name Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+80;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
		OnCommand=function(self)
			if GetServerName() == "" then
				self:settext(ScreenString("No Server Name"));
			else
				self:settext(GetServerName());
			end;
			self:finishtweening();
		end;
	},
	-- Actor (Server Status Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+96;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
		OnCommand=function(self)
			if IsNetConnected() == true then
				self:settext(ScreenString("Connected"));
			else
				self:settext(ScreenString("Disconnected"));
			end;
			self:finishtweening();
		end;
	},
	-- Actor (Life Difficulty Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_CENTER_Y+136;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
		OnCommand=function(self)
			local value = GetTimingDifficulty();
			self:finishtweening();
			self:settext(ScreenString("Life Difficulty") .. ": " .. tostring(value));
		end;
	},
	-- Actor (Timing Difficulty Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_CENTER_Y+136+16;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
		OnCommand=function(self)
			local value = GetTimingDifficulty();
			self:finishtweening();
			self:settext(ScreenString("Timing Difficulty") .. ": " .. tostring(value));
		end;
	},
	-- Actor (Song Group Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_CENTER_Y+136+32;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
		OnCommand=function(self)
			local value = SONGMAN:GetNumSongGroups();
			self:finishtweening();
			self:settext(ScreenString("Song Groups") .. ": " .. tostring(value));
		end;
	},
	-- Actor (Songs Total Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_CENTER_Y+136+48;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
		OnCommand=function(self)
			local value = SONGMAN:GetNumSongs();
			self:finishtweening();
			self:settext(ScreenString("Song Total") .. ": " .. tostring(value));
		end;
	},
	-- Actor (Game Type Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_CENTER_Y+136+64;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
		OnCommand=function(self)
			local game = GAMESTATE:GetCurrentGame();
			local value = game:GetName();
			self:finishtweening();
			self:settext(ScreenString("Game Type") .. ": " .. tostring(value));
		end;
	},
	-- Actor (Course Groups Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_RIGHT-4;y,SCREEN_CENTER_Y+136;diffuse,color(theme_color);zoom,0.5;align,1,0.5;shadowlength,1);
		OnCommand=function(self)
			local value = SONGMAN:GetNumCourseGroups();
			self:finishtweening();
			self:settext(ScreenString("Course Groups") .. ": " .. tostring(value));
		end;
	},
	-- Actor (Course Total Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_RIGHT-4;y,SCREEN_CENTER_Y+136+16;diffuse,color(theme_color);zoom,0.5;align,1,0.5;shadowlength,1);
		OnCommand=function(self)
			local value = SONGMAN:GetNumCourses();
			self:finishtweening();
			self:settext(ScreenString("Courses") .. ": " .. tostring(value));
		end;
	},
	-- Actor (Additional Courses Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_RIGHT-4;y,SCREEN_CENTER_Y+136+32;diffuse,color(theme_color);zoom,0.5;align,1,0.5;shadowlength,1);
		OnCommand=function(self)
			local value = SONGMAN:GetNumAdditionalCourses();
			self:finishtweening();
			self:settext(ScreenString("Additional Courses") .. ": " .. tostring(value));
		end;
	},
	-- Actor (Additional Songs Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_RIGHT-4;y,SCREEN_CENTER_Y+136+48;diffuse,color(theme_color);zoom,0.5;align,1,0.5;shadowlength,1);
		OnCommand=function(self)
			local value = SONGMAN:GetNumAdditionalSongs();
			self:finishtweening();
			self:settext(ScreenString("Additional Songs") .. ": " .. tostring(value));
		end;
	},
	-- Actor (Locked/Unlocked Songs Text)
	LoadFont("Common","normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_RIGHT-4;y,SCREEN_CENTER_Y+136+64;diffuse,color(theme_color);zoom,0.5;align,1,0.5;shadowlength,1);
		OnCommand=function(self)
			local value = SONGMAN:GetNumLockedSongs();
			local other_value = SONGMAN:GetNumUnlockedSongs();
			self:finishtweening();
			self:settext(ScreenString("Locked/Unlocked Songs") .. ": " .. tostring(value) .. "/" .. tostring(other_value));
		end;
	},
	-- Function (scripts)
	theme_skin("theme_skin"),
	-- Function (scripts)
	theme_skin("title_theme_skin"),
	-- Actor (scripts)
	main_song
};

return t;