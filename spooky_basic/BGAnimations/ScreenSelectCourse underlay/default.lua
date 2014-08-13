local t = Def.ActorFrame{
	--  GLOBAL banner/cd bottom border
	grid_j,
	-- GLOBAL banner/cd divider border
	grid_k,
	-- GLOBAL cd divider border
	grid_l,
	-- GLOBAL background divider border
	grid_m,
	-- GLOBAL information divider border
	grid_n,
	-- screen text
	LoadFont("SpoOky")..{
		Text="Title Screen | Select Profile | Select Style | Select Game Mode | Select Music |";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5);
	},
	-- song banner
	LoadActor(THEME:GetPathG("", "no_banner.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+70;zoomto,256,80);
		OnCommand=function(self)
			self:queuecommand('Banner');
		end;
		BannerCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse();
			if course ~= nil then
				if course:HasBanner() == true then
					self:Load(course:GetBannerPath());
				else
					self:Load(THEME:GetPathG("", "no_banner.png"));
				end;
				self:zoomto(256,80);
			end;
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Banner");
	},
	-- song background
	LoadActor(THEME:GetPathG("", "no_background.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+556;y,SCREEN_TOP+240;zoomto,592,420);
		OnCommand=function(self)
			self:queuecommand('BG');
		end;
		BGCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse();
			if course ~= nil then
				if course:HasBackground() == true then
					self:Load(course:GetBackgroundPath());
				else
					self:Load(THEME:GetPathG("", "no_background.png"));
				end;
			else
				self:Load(THEME:GetPathG("", "no_background.png"));
			end;
			self:zoomto(592,420);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"BG");
	},
	-- song difficulty p1
	LoadActor(THEME:GetPathG("", "difficulty_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+144;zoomto,64,64);
		OnCommand=function(self)
			self:queuecommand('DifficultyPA');
		end;
		DifficultyPACommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
			if trail ~= nil then
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
			else
				self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
			end;
			self:zoomto(64,64);
		end;
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"DifficultyPA");
	},
	-- song difficulty p2
	LoadActor(THEME:GetPathG("", "difficulty_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+208;zoomto,64,64);
		OnCommand=function(self)
			self:queuecommand('DifficultyPB');
		end;
		DifficultyPBCommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P2');
			if trail ~= nil then
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
			else
				self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
			end
			self:zoomto(64,64);
		end;
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"DifficultyPB");
	},
	-- song meter p1
	LoadActor(THEME:GetPathG("", "meter_0.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+144;zoomto,192,64);
		OnCommand=function(self)
			self:queuecommand('MeterPA');
		end;
		MeterPACommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
			if trail ~= nil then
				--[ use this instead... thanks again Kyzentun
				local half_meter=clamp(math.round(trail:GetMeter() / 2), 0, 10);
				self:Load(THEME:GetPathG("", "meter_"..half_meter..".png"));
			else
				self:Load(THEME:GetPathG("", "meter_0.png"));
			end;
			self:zoomto(192,64);
		end;
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"MeterPA");
	},
	-- song meter p2
	LoadActor(THEME:GetPathG("", "meter_0.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+208;zoomto,192,64);
		OnCommand=function(self)
			self:queuecommand('MeterPB');
		end;
		MeterPBCommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P2');
			if trail ~= nil then
				--[ use this instead... thanks again Kyzentun
				local half_meter=clamp(math.round(trail:GetMeter() / 2), 0, 10);
				self:Load(THEME:GetPathG("", "meter_"..half_meter..".png"));
			else
				self:Load(THEME:GetPathG("", "meter_0.png"));
			end;
			self:zoomto(192,64);
		end;
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"MeterPB");
	},
	-- song/trail information
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,1,0);
		OnCommand=function(self)
			self:queuecommand('Information');
		end;
		InformationCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse();
			if course ~= nil then
				local stage_course = course:GetEstimatedNumStages();
			--	local time_course = course:GetTotalSeconds();
			--	 .. "\nSeconds: " .. tostring(time_course)
				self:settext("Title: " .. course:GetDisplayFullTitle() .. "\nDescription: " .. course:GetDescription() .. "\nGroup Name: " .. course:GetGroupName() .. "\nCreator: " .. course:GetScripter() .. "\nStages: " .. tostring(stage_course));
			else
				self:settext("Title: " .. "N/A" .. "\nDescription: " .. "N/A" .. "\nGroup Name: " .. "N/A" .. "\nCreator: " .. "N/A" .. "\nStages: " .. "N/A");
			end;
			self:zoom(0.5);
			self:align(0,0.5);
			self:diffuse(color(theme_color));
			self:x(SCREEN_LEFT+4);
			self:y(SCREEN_TOP+310);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Information");
	},
	-- song/trail difficulty P1 text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,1,0);
		OnCommand=function(self)
			self:queuecommand('StringPA');
		end;
		StringPACommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P1');
			local stdifficulty = "Easy";
			if trail ~= nil then
				local difficultytrail = trail:GetDifficulty();
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
			else
				self:settext("N/A");
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
	-- song/trail difficulty P2 text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,1,0);
		OnCommand=function(self)
			self:queuecommand('StringPB');
		end;
		StringPBCommand=function(self)
			local trail = GAMESTATE:GetCurrentTrail('PlayerNumber_P2');
			local stdifficulty = "Easy";
			if trail ~= nil then
				local difficultytrail = trail:GetDifficulty();
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
			else
				self:settext("N/A");
			end;
			self:zoom(0.5);
			self:align(0,0.5);
			self:diffuse(color(theme_color));
			self:x(SCREEN_LEFT+72);
			self:y(SCREEN_TOP+223);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"StringPB");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"StringPB");
	},
	-- inform player of options screen...
	LoadFont("SpoOky")..{
		Text="Press Enter again to select options!";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("1,0.8,0,0");align,0.5,0.5;zoom,2.0);
		OffCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,0.5,0.5;zoom,2.0)
	},
	-- last known difficulty variable P1 fake actor
	LoadFont("SpoOky")..{
		Text="";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:queuecommand('VarPA');
		end;
		VarPACommand=function(self)
			local d = GAMESTATE:GetCurrentTrail('PlayerNumber_P1'):GetDifficulty();
			last_known_difficulty_P1 = d;
		end;
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"VarPA");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"VarPA");
	},
	-- last known difficulty variable P2 fake actor
	LoadFont("SpoOky")..{
		Text="";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:queuecommand('VarPB');
		end;
		VarPBCommand=function(self)
			local d = GAMESTATE:GetCurrentTrail('PlayerNumber_P2'):GetDifficulty();
			last_known_difficulty_P2 = d;
		end;
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"VarPB");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"VarPB");
	}
};

return t;