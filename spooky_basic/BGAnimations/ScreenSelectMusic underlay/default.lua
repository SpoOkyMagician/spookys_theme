local t = Def.ActorFrame{
	-- banner/cd bottom border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP+110,SCREEN_LEFT+258,SCREEN_TOP+112;diffuse,color(theme_color));
	},
	-- banner/cd divider border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+258,SCREEN_TOP+28,SCREEN_LEFT+260,SCREEN_TOP+240;diffuse,color(theme_color));
	},
	-- cd divider border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+340,SCREEN_TOP+28,SCREEN_LEFT+342,SCREEN_TOP+112;diffuse,color(theme_color));
	},
	-- background divider border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+258,SCREEN_TOP+240,SCREEN_LEFT+260,SCREEN_TOP+450;diffuse,color(theme_color));
	},
	-- information divider border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+380,SCREEN_LEFT+260,SCREEN_TOP+382;diffuse,color(theme_color));
	},
	-- screen text
	LoadFont("SpoOky")..{
		Text="Title Screen | Select Profile | Select Style | Select Game Mode | Select Music |";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5);
	},
	-- song banner
	LoadActor(THEME:GetPathG("", "no_banner.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+70;zoomto,256,80);
		OnCommand=function(self)
			self:queuecommand("Banner");
		end;
		BannerCommand=function(self)
				local song = GAMESTATE:GetCurrentSong();
				if song ~= nil then
					if song:HasBanner() == true then
						self:Load(song:GetBannerPath());
					else
						self:Load(THEME:GetPathG("", "no_banner.png"));
					end;
				else
					self:Load(THEME:GetPathG("", "no_banner.png"));
				end;
			self:zoomto(256,80);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Banner");
	},
	-- song background
	LoadActor(THEME:GetPathG("", "no_background.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+556;y,SCREEN_TOP+240;zoomto,592,420);
		OnCommand=function(self)
			self:queuecommand('BG');
		end;
		BGCommand=function(self)
				local song = GAMESTATE:GetCurrentSong();
				if song ~= nil then
					if song:HasBackground() == true then
						self:Load(GetSongBackground());
					else
						self:Load(THEME:GetPathG("", "no_background.png"));
					end;
				else
					self:Load(THEME:GetPathG("", "no_background.png"));
				end;
			self:zoomto(592,420);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"BG");
	},
	-- song cd
	LoadActor(THEME:GetPathG("", "no_cd.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+300;y,SCREEN_TOP+69;zoomto,80,80);
		OnCommand=function(self)
			self:queuecommand('CD');
		end;
		CDCommand=function(self)
				local song = GAMESTATE:GetCurrentSong();
				if song ~= nil then
					if song:HasCDTitle() == true then
						self:Load(song:GetCDTitlePath());
					else
						self:Load(THEME:GetPathG("", "no_cd.png"));
					end;
				else
					self:Load(THEME:GetPathG("", "no_cd.png"));
				end;
		--	end;
			self:zoomto(80,80);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"CD");
	},
	-- song difficulty p1
	LoadActor(THEME:GetPathG("", "difficulty_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+144;zoomto,64,64);
		OnCommand=function(self)
			self:queuecommand('DifficultyPA');
		end;
		DifficultyPACommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
				if steps ~= nil then
					if steps:GetDifficulty() == 'Difficulty_Beginner' then
						self:Load(THEME:GetPathG("", "difficulty_beginner.png"));
					elseif steps:GetDifficulty() == 'Difficulty_Easy' then
						self:Load(THEME:GetPathG("", "difficulty_easy.png"));
					elseif steps:GetDifficulty() == 'Difficulty_Medium' then
						self:Load(THEME:GetPathG("", "difficulty_normal.png"));
					elseif steps:GetDifficulty() == 'Difficulty_Hard' then
						self:Load(THEME:GetPathG("", "difficulty_hard.png"));
					elseif steps:GetDifficulty() == 'Difficulty_Challenge' then
						self:Load(THEME:GetPathG("", "difficulty_challenge.png"));
					elseif steps:GetDifficulty() == 'Difficulty_Edit' then
						self:Load(THEME:GetPathG("", "difficulty_edit.png"));
					else
						self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
					end;
				else
					self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
				end;
			self:zoomto(64,64);
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"DifficultyPA");
		CurrentSongChangedMessageCommand=cmd(playcommand,"DifficultyPA");
	},
	-- song difficulty p2
	LoadActor(THEME:GetPathG("", "difficulty_unknown.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+208;zoomto,64,64);
		OnCommand=function(self)
			self:queuecommand('DifficultyPB');
		end;
		DifficultyPBCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
				if steps ~= nil then
					if steps:GetDifficulty() == 'Difficulty_Beginner' then
						self:Load(THEME:GetPathG("", "difficulty_beginner.png"));
					elseif steps:GetDifficulty() == 'Difficulty_Easy' then
						self:Load(THEME:GetPathG("", "difficulty_easy.png"));
					elseif steps:GetDifficulty() == 'Difficulty_Medium' then
						self:Load(THEME:GetPathG("", "difficulty_normal.png"));
					elseif steps:GetDifficulty() == 'Difficulty_Hard' then
						self:Load(THEME:GetPathG("", "difficulty_hard.png"));
					elseif steps:GetDifficulty() == 'Difficulty_Challenge' then
						self:Load(THEME:GetPathG("", "difficulty_challenge.png"));
					elseif steps:GetDifficulty() == 'Difficulty_Edit' then
						self:Load(THEME:GetPathG("", "difficulty_edit.png"));
					else
						self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
					end;
				else
					self:Load(THEME:GetPathG("", "difficulty_unknown.png"));
				end;
			self:zoomto(64,64);
		end;
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"DifficultyPB");
		CurrentSongChangedMessageCommand=cmd(playcommand,"DifficultyPB");
	},
	-- song meter p1
	LoadActor(THEME:GetPathG("", "meter_0.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+144;zoomto,192,64);
		OnCommand=function(self)
			self:queuecommand('MeterPA');
		end;
		MeterPACommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
				if steps ~= nil then
					--[ use this instead... thanks again Kyzentun
					local half_meter=clamp(math.round(steps:GetMeter() / 2), 0, 10);
					self:Load(THEME:GetPathG("", "meter_"..half_meter..".png"));
				else
					self:Load(THEME:GetPathG("", "meter_0.png"));
				end;
			self:zoomto(192,64);
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"MeterPA");
		CurrentSongChangedMessageCommand=cmd(playcommand,"MeterPA");
	},
	-- song meter p2
	LoadActor(THEME:GetPathG("", "meter_0.png"))..{
		InitCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+208;zoomto,192,64);
		OnCommand=function(self)
			self:queuecommand('MeterPB');
		end;
		MeterPBCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
				if steps ~= nil then
					--[ use this instead... thanks again Kyzentun
					local half_meter=clamp(math.round(steps:GetMeter() / 2), 0, 10);
					self:Load(THEME:GetPathG("", "meter_"..half_meter..".png"));
				else
					self:Load(THEME:GetPathG("", "meter_0.png"));
				end;
			self:zoomto(192,64);
		end;
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"MeterPB");
		CurrentSongChangedMessageCommand=cmd(playcommand,"MeterPB");
	},
	-- song/trail information
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,1,0);
		OnCommand=function(self)
			self:queuecommand('Information');
		end;
		InformationCommand=function(self)
				local song = GAMESTATE:GetCurrentSong();
				local length_result = "Normal";
				if song ~= nil then
					local tempo = song:GetDisplayBpms();
					local length_long = song:IsLong();
					local length_marathon = song:IsMarathon();
					local results_tempo = 1;
					if tempo[1] == tempo[2] then
						results_tempo = tostring(round(tempo[1],1));
					else
						results_tempo = tostring(round(tempo[1],1) .. " - " .. round(tempo[2],1));
					end;
					if length_long == true then
						length_result = "Long";
					elseif length_marathon == true then
						length_result = "Marathon";
					else
						length_result = "Normal";
					end;
					self:settext("Title: " .. song:GetDisplayMainTitle() .. "\nSub Title: " .. song:GetDisplaySubTitle() .. "\nSong Artist: " .. song:GetDisplayArtist() .. "\nTempo: " .. results_tempo .. "\nGenre: " .. song:GetGenre() .. "\nGroup: " .. song:GetGroupName() .. "\nLength: " .. length_result .. "\nSeconds: " .. round(song:MusicLengthSeconds(),1) );
				else
					self:settext("Title: " .. "N/A" .. "\nSub Title: " .. "N/A" .. "\nSong Artist: " .. "N/A" .. "\nTempo: " .. "N/A" .. "\nGenre: " .. "N/A" .. "\nGroup: " .. "N/A" .. "\nLength: " .. "N/A" .. "\nSeconds: " .. "N/A" );
				end;
			self:zoom(0.5);
			self:align(0,0.5);
			self:diffuse(color(theme_color));
			self:x(SCREEN_LEFT+4);
			self:y(SCREEN_TOP+310);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Information");
	},
	-- song/trail difficulty P1 text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,1,0);
		OnCommand=function(self)
			self:queuecommand('StringPA');
		end;
		StringPACommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
			local stdifficulty = "Easy";
			if steps ~= nil then
				local difficultysteps = steps:GetDifficulty();
				if difficultysteps == 'Difficulty_Beginner' then
					stdifficulty = "Beginner";
				elseif difficultysteps == 'Difficulty_Easy' then
					stdifficulty = "Easy";
				elseif difficultysteps == 'Difficulty_Medium' then
					stdifficulty = "Medium";
				elseif difficultysteps == 'Difficulty_Hard' then
					stdifficulty = "Hard";
				elseif difficultysteps == 'Difficulty_Challenge' then
					stdifficulty = "Challenge";
				elseif difficultysteps == 'Difficulty_Edit' then
					stdifficulty = "Edit (" .. steps:GetChartName() .. ")";
				end;
				self:settext("" .. stdifficulty .. " - " .. tostring(steps:GetMeter()) );
			else
				self:settext("N/A");
			end;
			self:zoom(0.5);
			self:align(0,0.5);
			self:diffuse(color(theme_color));
			self:x(SCREEN_LEFT+72);
			self:y(SCREEN_TOP+158);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StringPA");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"StringPA");
	},
	-- song/trail difficulty P2 text
	LoadFont("SpoOky")..{
		Text="N/A";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,1,0);
		OnCommand=function(self)
			self:queuecommand('StringPB');
		end;
		StringPBCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
			local stdifficulty = "Easy";
			if steps ~= nil then
				local difficultysteps = steps:GetDifficulty();
				if difficultysteps == 'Difficulty_Beginner' then
					stdifficulty = "Beginner";
				elseif difficultysteps == 'Difficulty_Easy' then
					stdifficulty = "Easy";
				elseif difficultysteps == 'Difficulty_Medium' then
					stdifficulty = "Medium";
				elseif difficultysteps == 'Difficulty_Hard' then
					stdifficulty = "Hard";
				elseif difficultysteps == 'Difficulty_Challenge' then
					stdifficulty = "Challenge";
				elseif difficultysteps == 'Difficulty_Edit' then
					stdifficulty = "Edit (" .. steps:GetChartName() .. ")";
				end;
				self:settext("" .. stdifficulty .. " - " .. tostring(steps:GetMeter()) );
			else
				self:settext("N/A");
			end;
			self:zoom(0.5);
			self:align(0,0.5);
			self:diffuse(color(theme_color));
			self:x(SCREEN_LEFT+72);
			self:y(SCREEN_TOP+223);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"StringPB");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"StringPB");
	},
	-- last known difficulty variable P1 fake actor
	LoadFont("SpoOky")..{
		Text="";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:queuecommand('VarPA');
		end;
		VarPACommand=function(self)
			local d = GAMESTATE:GetCurrentSteps('PlayerNumber_P1'):GetDifficulty();
			last_known_difficulty_P1 = d;
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"VarPA");
		CurrentSongChangedMessageCommand=cmd(playcommand,"VarPA");
	},
	-- last known difficulty variable P2 fake actor
	LoadFont("SpoOky")..{
		Text="";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:queuecommand('VarPB');
		end;
		VarPBCommand=function(self)
			local d = GAMESTATE:GetCurrentSteps('PlayerNumber_P2'):GetDifficulty();
			last_known_difficulty_P2 = d;
		end;
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"VarPB");
		CurrentSongChangedMessageCommand=cmd(playcommand,"VarPB");
	}
};

return t;