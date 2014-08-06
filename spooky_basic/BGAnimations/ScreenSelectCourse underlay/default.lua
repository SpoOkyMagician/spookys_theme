local t = Def.ActorFrame{
	--[ banner/cd bottom border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP+110,SCREEN_RIGHT,SCREEN_TOP+112;diffuse,color(theme_color));
	},
	--[ banner/cd divider border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+258,SCREEN_TOP+28,SCREEN_LEFT+260,SCREEN_TOP+240;diffuse,color(theme_color));
	},
	--[ cd divider border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+340,SCREEN_TOP+28,SCREEN_LEFT+342,SCREEN_TOP+112;diffuse,color(theme_color));
	},
	--[ background divider border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+258,SCREEN_TOP+240,SCREEN_LEFT+260,SCREEN_TOP+450;diffuse,color(theme_color));
	},
	--[ information divider border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+380,SCREEN_LEFT+260,SCREEN_TOP+382;diffuse,color(theme_color));
	},
	--[ screen text
	LoadFont("Common normal")..{
		Text="Title Screen | Select Profile | Select Style | Select Game Mode | Select Music |";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5);
	},
	--[ song banner
	LoadActor(THEME:GetPathG("", "no_banner.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+70;zoomto,256,80;center);
		OnCommand=function(self)
			self:queuecommand('Banner');
		end;
		BannerCommand=function(self)
			local c = GAMESTATE:GetCurrentCourse();
			if c then
				sellf:Load(c:GetBannerPath());
			else
				self:Load(THEME:GetPathG("", "no_banner.png"));
			end;
			self:zoomto(256,80);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Banner");
	},
	--[ song background
	LoadActor(THEME:GetPathG("", "no_background.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+556;y,SCREEN_TOP+240;zoomto,592,422;center);
		OnCommand=function(self)
			self:queuecommand('BG');
		end;
		BGCommand=function(self)
			local c = GAMESTATE:GetCurrentCourse();
			if c:HasBackground() == true then
				self:Load(c:GetBackgroundPath());
			else
				self:Load(THEME:GetPathG("", "no_background.png"));
			end;
			self:zoomto(592,422);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"BG");
	},
	--[ song cd
	LoadActor(THEME:GetPathG("", "no_cd.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+300;y,SCREEN_TOP+69;zoomto,80,80;center);
		OnCommand=function(self)
			self:queuecommand('CD');
		end;
		CDCommand=function(self)
			local nc = GAMESTATE:GetCurrentCourse();
			if nc then
				self:Load(THEME:GetPathG("", "no_cd.png"));
			else
				self:Load(THEME:GetPathG("", "no_cd.png"));
			end;
			self:zoomto(80,80);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"CD");
	},
	--[ song difficulty p1
	LoadActor(THEME:GetPathG("", "difficulty_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+144;zoomto,64,64;center);
		OnCommand=function(self)
			self:queuecommand('DifficultyPA');
		end;
		DifficultyPACommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
			if trail then
				if trail:GetDifficulty() == 'Difficulty_Beginner' then
					self:Load(THEME:GetPathG("", "difficulty_beginner.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Easy' then
					self:Load(THEME:GetPathG("", "difficulty_easy.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Medium' then
					self:Load(THEME:GetPathG("", "difficulty_normal.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Hard' then
					self:Load(THEME:GetPathG("", "difficulty_hard.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Challenge' then
					self:Load(THEME:GetPathG("", "difficulty_challenge.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Edit' then
					self:Load(THEME:GetPathG("", "difficulty_edit.png"));
				else
					self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
				end;
			end;
			self:zoomto(64,64);
		end;
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"DifficultyPA");
	},
	--[ song difficulty p2
	LoadActor(THEME:GetPathG("", "difficulty_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+208;zoomto,64,64;center);
		OnCommand=function(self)
			self:queuecommand('DifficultyPB');
		end;
		DifficultyPBCommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P2');
			if trail then
				if trail:GetDifficulty() == 'Difficulty_Beginner' then
					self:Load(THEME:GetPathG("", "difficulty_beginner.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Easy' then
					self:Load(THEME:GetPathG("", "difficulty_easy.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Medium' then
					self:Load(THEME:GetPathG("", "difficulty_normal.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Hard' then
					self:Load(THEME:GetPathG("", "difficulty_hard.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Challenge' then
					self:Load(THEME:GetPathG("", "difficulty_challenge.png"));
				elseif trail:GetDifficulty() == 'Difficulty_Edit' then
					self:Load(THEME:GetPathG("", "difficulty_edit.png"));
				else
					self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
				end;
			end
			self:zoomto(64,64);
		end;
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"DifficultyPB");
	},
	--[ song meter p1
	LoadActor(THEME:GetPathG("", "meter_0.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+144;zoomto,192,64;center);
		OnCommand=function(self)
			self:queuecommand('MeterPA');
		end;
		MeterPACommand=function(self)
			local m = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
			if m then
				if m:GetMeter() == 1 or m:GetMeter() == 2 then
					self:Load(THEME:GetPathG("", "meter_1.png"));
				elseif m:GetMeter() == 3 or m:GetMeter() == 4 then
					self:Load(THEME:GetPathG("", "meter_2.png"));
				elseif m:GetMeter() == 5 or m:GetMeter() == 6 then
					self:Load(THEME:GetPathG("", "meter_3.png"));
				elseif m:GetMeter() == 7 or m:GetMeter() == 8 then
					self:Load(THEME:GetPathG("", "meter_4.png"));
				elseif m:GetMeter() == 9 or m:GetMeter() == 10 then
					self:Load(THEME:GetPathG("", "meter_5.png"));
				elseif m:GetMeter() == 11 or m:GetMeter() == 12 then
					self:Load(THEME:GetPathG("", "meter_6.png"));
				elseif m:GetMeter() == 13 or m:GetMeter() == 14 then
					self:Load(THEME:GetPathG("", "meter_7.png"));
				elseif m:GetMeter() == 15 or m:GetMeter() == 16 then
					self:Load(THEME:GetPathG("", "meter_8.png"));
				elseif m:GetMeter() == 17 or m:GetMeter() == 18 then
					self:Load(THEME:GetPathG("", "meter_9.png"));
				elseif m:GetMeter() == 19 or m:GetMeter() == 20 then
					self:Load(THEME:GetPathG("", "meter_10.png"));
				else
					self:Load(THEME:GetPathG("", "meter_0.png"));
				end;
			end;
			self:zoomto(192,64);
		end;
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"MeterPA");
	},
	--[ song meter p2
	LoadActor(THEME:GetPathG("", "meter_0.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+208;zoomto,192,64;center);
		OnCommand=function(self)
			self:queuecommand('MeterPB');
		end;
		MeterPBCommand=function(self)
			local m = GAMESTATE:GetCurrentTrail('PlayerNumber_P2');
			if m then
				if m:GetMeter() == 1 or m:GetMeter() == 2 then
					self:Load(THEME:GetPathG("", "meter_1.png"));
				elseif m:GetMeter() == 3 or m:GetMeter() == 4 then
					self:Load(THEME:GetPathG("", "meter_2.png"));
				elseif m:GetMeter() == 5 or m:GetMeter() == 6 then
					self:Load(THEME:GetPathG("", "meter_3.png"));
				elseif m:GetMeter() == 7 or m:GetMeter() == 8 then
					self:Load(THEME:GetPathG("", "meter_4.png"));
				elseif m:GetMeter() == 9 or m:GetMeter() == 10 then
					self:Load(THEME:GetPathG("", "meter_5.png"));
				elseif m:GetMeter() == 11 or m:GetMeter() == 12 then
					self:Load(THEME:GetPathG("", "meter_6.png"));
				elseif m:GetMeter() == 13 or m:GetMeter() == 14 then
					self:Load(THEME:GetPathG("", "meter_7.png"));
				elseif m:GetMeter() == 15 or m:GetMeter() == 16 then
					self:Load(THEME:GetPathG("", "meter_8.png"));
				elseif m:GetMeter() == 17 or m:GetMeter() == 18 then
					self:Load(THEME:GetPathG("", "meter_9.png"));
				elseif m:GetMeter() == 19 or m:GetMeter() >= 20 then
					self:Load(THEME:GetPathG("", "meter_10.png"));
				else
					self:Load(THEME:GetPathG("", "meter_0.png"));
				end;
			end;
			self:zoomto(192,64);
		end;
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"MeterPB");
	},
	--[ song/trail information
	LoadFont("Common normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;left;diffuse,color(theme_color));
		OnCommand=function(self)
			self:queuecommand('Information');
		end;
		InformationCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse();
			local stage_course = course:GetEstimatedNumStages();
			local time_course = course:GetTotalSeconds();
			self:settext("Title: " .. course:GetDisplayFullTitle() .. "\nDescription: " .. course:GetDescription() .. "\nGroup Name: " .. course:GetGroupName() .. "\nCreator: " .. course:GetScripter() .. "\nStages: " .. tostring(stage_course) .. "\nSeconds: " .. tostring(time_course));
			self:zoom(0.5);
			self:align(0,0.5);
			self:diffuse(color(theme_color));
			self:x(SCREEN_LEFT+4);
			self:y(SCREEN_TOP+310);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Information");
	},
	--[ song/trail difficulty P1 text
	LoadFont("Common normal")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;left;diffuse,color(theme_color));
		OnCommand=function(self)
			self:queuecommand('StringPA');
		end;
		StringPACommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
			local difficultytrail = trail:GetDifficulty();
			local stdifficulty = "Easy";
			if trail then
				if difficultytrail == 'Difficulty_Beginner' then
					stdifficulty = "Beginner";
				elseif difficultytrail == 'Difficulty_Easy' then
					stdifficulty = "Easy";
				elseif difficultytrail == 'Difficulty_Medium' then
					stdifficulty = "Medium";
				elseif difficultytrail == 'Difficulty_Hard' then
					stdifficulty = "Hard";
				elseif difficultytrail == 'Difficulty_Challenge' then
					stdifficulty = "Challenge";
				elseif difficultytrail == 'Difficulty_Edit' then
					stdifficulty = "Edit";
				end;
				self:settext("" .. stdifficulty .. " - " .. tostring(trail:GetMeter()) );
			end;
			self:zoom(0.5);
			self:align(0,0.5);
			self:diffuse(color(theme_color));
			self:x(SCREEN_LEFT+72);
			self:y(SCREEN_TOP+158);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"StringPA");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"StringPA");
	},
	--[ inform player of options screen...
	LoadFont("Common normal")..{
		Text="Press Enter again to select options!";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("1,0.8,0,0");align,0.5,0.5;zoom,2.0);
		OffCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,0.5,0.5;zoom,2.0)
	}
};

return t;