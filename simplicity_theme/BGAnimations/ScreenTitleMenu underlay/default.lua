-- ScreenTitleMenu underlay

local t = Def.ActorFrame{
	Name="ScreenTitleMenuUnderlayActorFrame";
	-- GLOBAL black quad
	grid_a,
	LoadActor(THEME:GetPathG("","bg_generic"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- testing
--	LoadActor(THEME:GetPathG("","isometric_sm5"))..{
--		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
--	},
	-- GLOBAL theme color quad
	grid_u,
	-- GLOBAL dark gold header quad
	grid_b,
	-- GLOBAL dark gold footer quad
	grid_c,
	-- GLOBAL top border
	grid_d,
	-- GLOBAL bottom border
	grid_e,
	-- GLOBAL left border
	grid_f,
	-- GLOBAL right border
	grid_g,
	-- GLOBAL profile border
	grid_h,
	-- GLOBAL screen border
	grid_i,
	-- GLOBAL profile divider
	grid_s,
	-- menu items quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+314,SCREEN_BOTTOM/2-18,SCREEN_RIGHT-314,SCREEN_BOTTOM/2+18;diffuse,color("0,0,0,0.5"));
	},
	-- menu info quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-115,SCREEN_RIGHT-2,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	},
	-- neat arrows
	LoadActor(THEME:GetPathG("","arrow"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-96;y,SCREEN_CENTER_Y;baserotationz,90;SetSize,32,32);
		UpLeftCommand=function(self)
			self:x(SCREEN_CENTER_X-96-2);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X-96-1);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X-96+2);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X-96+1);
			self:sleep(0.02);
		end;
		MenuLeft1MessageCommand=cmd(playcommand,"UpLeft");
		MenuUp1MessageCommand=cmd(playcommand,"UpLeft");
		MenuLeft2MessageCommand=cmd(playcommand,"UpLeft");
		MenuUp2MessageCommand=cmd(playcommand,"UpLeft");
		MenuSelectionChangedMessageCommand=cmd(playcommand,"UpLeft");
	},
	LoadActor(THEME:GetPathG("","arrow"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+96;y,SCREEN_CENTER_Y;baserotationz,-90;SetSize,32,32);
		DownRightCommand=function(self)
			self:x(SCREEN_CENTER_X+96+2);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X+96+1);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X+96-2);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X+96-1);
			self:sleep(0.02);
		end;
		MenuRight1MessageCommand=cmd(playcommand,"DownRight");
		MenuDown1MessageCommand=cmd(playcommand,"DownRight");
		MenuRight2MessageCommand=cmd(playcommand,"DownRight");
		MenuDown2MessageCommand=cmd(playcommand,"DownRight");
		MenuSelectionChangedMessageCommand=cmd(playcommand,"DownRight");
	},
	-- GLOBAL screen text
	common_text("Title Screen"),
	-- logo text
	LoadFont("SpoOky")..{
		Text="STEPMANIA 5";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/3;diffuse,color(theme_color);zoom,3.0;align,0.5,0.5;shadowlength,3;shadowcolor,color(theme_background));
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
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
	-- product version text
	LoadFont("SpoOky")..{
		Text=ProductVersion();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+32;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
	},
	-- build date text
	LoadFont("SpoOky")..{
		Text=VersionDate();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+48;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
	},
	-- build time text
	LoadFont("SpoOky")..{
		Text=VersionTime();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+64;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
	},
	-- server text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+80;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			if GetServerName() == "" then
				self:settext("No Server Name");
			else
				self:settext(GetServerName());
			end;
		end;
	},
	-- server text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+96;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			if IsNetConnected() == true then
				self:settext("Connected");
			else
				self:settext("Disconnected");
			end;
		end;
	},
	-- life text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_CENTER_Y+136;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			local value = GetTimingDifficulty();
			self:settext("Life Difficulty: " .. tostring(value));
		end;
	},
	-- timing text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_CENTER_Y+136+16;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			local value = GetTimingDifficulty();
			self:settext("Timing Difficulty: " .. tostring(value));
		end;
	},
	-- group text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_CENTER_Y+136+32;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			local value = SONGMAN:GetNumSongGroups();
			self:settext("Song Groups: " .. tostring(value));
		end;
	},
	-- songs text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_CENTER_Y+136+48;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			local value = SONGMAN:GetNumSongs();
			self:settext("Song Total: " .. tostring(value));
		end;
	},
	-- game text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_CENTER_Y+136+64;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			local game = GAMESTATE:GetCurrentGame();
			local value = game:GetName();
			self:settext("Game Type: " .. tostring(value));
		end;
	},
	-- course groups text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_RIGHT-4;y,SCREEN_CENTER_Y+136;diffuse,color(theme_color);zoom,0.5;align,1,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			local value = SONGMAN:GetNumCourseGroups();
			self:settext("Course Groups: " .. tostring(value));
		end;
	},
	-- course total text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_RIGHT-4;y,SCREEN_CENTER_Y+136+16;diffuse,color(theme_color);zoom,0.5;align,1,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			local value = SONGMAN:GetNumCourses();
			self:settext("Courses: " .. tostring(value));
		end;
	},
	-- add courses text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_RIGHT-4;y,SCREEN_CENTER_Y+136+32;diffuse,color(theme_color);zoom,0.5;align,1,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			local value = SONGMAN:GetNumAdditionalCourses();
			self:settext("Additional Courses: " .. tostring(value));
		end;
	},
	-- add songs text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_RIGHT-4;y,SCREEN_CENTER_Y+136+48;diffuse,color(theme_color);zoom,0.5;align,1,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			local value = SONGMAN:GetNumAdditionalSongs();
			self:settext("Additional Songs: " .. tostring(value));
		end;
	},
	-- locks text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_RIGHT-4;y,SCREEN_CENTER_Y+136+64;diffuse,color(theme_color);zoom,0.5;align,1,0.5;shadowlength,1);
		-- this should be okay. i have to call it somehow... can't use init...
		OnCommand=function(self)
			local value = SONGMAN:GetNumLockedSongs();
			local other_value = SONGMAN:GetNumUnlockedSongs();
			self:settext("Locked/Unlocked Songs: " .. tostring(value) .. "/" .. tostring(other_value));
		end;
	},
	-- new theme skin i am experimenting with...
	LoadActor(THEME:GetPathG("","theme_skin"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- new theme skin i am experimenting with...
	LoadActor(THEME:GetPathG("","title_theme_skin"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- testing something
	-- test_text("Testing Something", 427, 240, "#FFFFFFFF"),
	-- GLOBAL play music
	main_song
};

return t;