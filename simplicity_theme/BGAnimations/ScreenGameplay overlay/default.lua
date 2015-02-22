-- ScreenGameplay overlay

local t = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrame";
	-- Function
	refresh_color(),
	-- Actor (scripts)
	grid_b,
	-- Actor (scripts)
	grid_c,
	-- Actor (Score Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-30,SCREEN_RIGHT-2,SCREEN_BOTTOM-52;diffuse,color("0,0,0,0.75"));
	},
	-- Actor (Progress Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+30,SCREEN_RIGHT-2,SCREEN_TOP+52;diffuse,color("0,0,0,0.75"));
	},
	-- Actor (Stage Icon)
	LoadActor(THEME:GetPathG("", "stage_icon_unknown"))..{
		InitCommand=cmd(x,SCREEN_RIGHT/2;y,SCREEN_TOP+15);
		OnCommand=function(self)
			self:queuecommand('StageIcon');
		end;
		StageIconCommand=function(self)
			if last_known_stage ~= nil then
				self:Load(THEME:GetPathG("icon", last_known_stage));
			else
				self:Load(THEME:GetPathG("", "stage_icon_unknown"));
			end;
		end;
	},
	-- Actor (Song Difficulty P1)
	LoadActor(THEME:GetPathG("", "icon_unknown"))..{
		InitCommand=cmd(x,SCREEN_LEFT+51;y,SCREEN_TOP+15);
		-- this should be okay. i have to call it somehow... there are other messagecommands but, this is good...
		OnCommand=function(self)
			self:queuecommand('IconPA');
		end;
		IconPACommand=function(self)
			if last_known_difficulty_P1 ~= nil then
				self:Load(THEME:GetPathG("icon", last_known_difficulty_P1));
			else
				self:Load(THEME:GetPathG("", "icon_unknown"));
			end;
		end;
	},
	-- Actor (Song Difficulty P2)
	LoadActor(THEME:GetPathG("", "icon_unknown"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-51;y,SCREEN_TOP+15);
		OnCommand=function(self)
			self:queuecommand('IconPB');
		end;
		IconPBCommand=function(self)
			if last_known_difficulty_P2 ~= nil then
				self:Load(THEME:GetPathG("icon", last_known_difficulty_P2));
			else
				self:Load(THEME:GetPathG("", "icon_unknown"));
			end;
		end;
	},
	-- Actor (Back Life Meter P1)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+402,SCREEN_TOP+28;diffuse,color("0.1,0.1,0.1,1"));
	},
	-- Actor (Front Life Meter P1)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+402,SCREEN_TOP+28;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			p1_lifebar = nil;
			p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
			self:queuecommand('PALife');
		end;
		PALifeCommand=function(self)
			if p1_lifebar ~= nil then
				p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
				local life_pa = p1_lifebar:GetLife();
				self:finishtweening();
				self:diffuse(color("1,0.5,0,1"));
				self:stretchto(SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+102+(300*life_pa),SCREEN_TOP+28);
				self:sleep(0.05);
				self:diffuse(color("1,0.25,0,1"));
				self:stretchto(SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+102+(300*life_pa),SCREEN_TOP+28);
				self:diffuse(color("1,0.25,0,1"));
			end;
		end;
		LifeMeterChangedP1MessageCommand=cmd(playcommand,"PALife");
	},
	-- Actor (Life Meter Overlay P1)
	LoadActor(THEME:GetPathG("", "life_meter_overlay"))..{
		InitCommand=cmd(x,SCREEN_LEFT+252;y,SCREEN_TOP+15);
	},
	-- Actor (Back Life Meter P2)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28;diffuse,color("0.1,0.1,0.1,1"));
	},
	-- Actor (Front Life Meter P2)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			p2_lifebar = nil;
			p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
			self:queuecommand('PBLife');
		end;
		PBLifeCommand=function(self)
			if p2_lifebar ~= nil then
				p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
				local life_pb = p2_lifebar:GetLife();
				self:finishtweening();
				self:diffuse(color("0,0.75,1,1"));
				self:stretchto(SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-402+(300*life_pb),SCREEN_TOP+28);
				self:sleep(0.05);
				self:diffuse(color("0,0.5,1,1"));
				self:stretchto(SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-402+(300*life_pb),SCREEN_TOP+28);
				self:diffuse(color("0,0.5,1,1"));
			end;
		end;
		LifeMeterChangedP2MessageCommand=cmd(playcommand,"PBLife");
	},
	-- Actor (Life Meter Overlay P2)
	LoadActor(THEME:GetPathG("", "life_meter_overlay"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-252;y,SCREEN_TOP+15);
	},
	-- Actor (P1 NPS)
	LoadFont("Common","normal")..{
		Text="NPS: 0";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+64;align,0,0.5;diffuse,color(theme_color);shadowlength,1);
		OnCommand=function(self)
			total_p1 = 0;
			last_second_p1 = -1;
			current_second_p1 = Second();
		end;
		TotalACommand=function(self)
			last_second_p1 = current_second_p1;
			current_second_p1 = Second();
			if current_second_p1 ~= last_second_p1 then
				local nps_p1 = total_p1;
				total_p1 = 0;
				self:settext("NPS: " .. tostring(nps_p1));
			else
				total_p1 = (total_p1 + 1);
			end;
		end;
		CurrentComboChangedP1MessageCommand=cmd(playcommand,"TotalA");
	},
	-- Actor (P2 NPS)
	LoadFont("Common","normal")..{
		Text="NPS: 0";
		InitCommand=cmd(x,SCREEN_RIGHT-8;y,SCREEN_TOP+64;align,1,0.5;diffuse,color(theme_color);shadowlength,1);
		OnCommand=function(self)
			total_p2 = 0;
			last_second_p2 = -1;
			current_second_p2 = Second();
		end;
		TotalACommand=function(self)
			last_second_p2 = current_second_p2;
			current_second_p2 = Second();
			if current_second_p2 ~= last_second_p2 then
				local nps_p2 = total_p2;
				total_p2 = 0;
				self:settext("NPS: " .. tostring(nps_p2));
			else
				total_p2 = (total_p2 + 1);
			end;
		end;
		CurrentComboChangedP1MessageCommand=cmd(playcommand,"TotalA");
	},
	-- Actor (Combo Text P1)
	LoadFont("Common","normal")..{
		Text="0";
		InitCommand=cmd(x,SCREEN_RIGHT/2-4;y,SCREEN_BOTTOM-40;align,1,0.5;diffuse,color("1,0.25,0,1");visible,false;shadowlength,1);
		PAComboCommand=function(self)
			local stats = STATSMAN:GetCurStageStats();
			local player_stats = stats:GetPlayerStageStats('PlayerNumber_P1');
			local combo = player_stats:GetCurrentCombo();
			if combo >=2 then
				self:finishtweening();
				self:visible(true);
				self:settext(tostring(combo));
				self:zoom(1.25);
				self:diffuse(color("1,0.5,0.5,1"));
				self:sleep(0.05);
				self:zoom(1.0);
				self:diffuse(color("1,0.25,0,1"));
			else
				self:visible(false);
			end;
		end;
		CurrentComboChangedP1MessageCommand=cmd(playcommand,"PACombo");
	},
	-- Actor (Combo Text P2)
	LoadFont("Common","normal")..{
		Text="0";
		InitCommand=cmd(x,SCREEN_RIGHT/2+4;y,SCREEN_BOTTOM-40;align,0,0.5;diffuse,color("0,0.5,1,1");visible,false;shadowlength,1);
		PBComboCommand=function(self)
			local stats = STATSMAN:GetCurStageStats();
			local player_stats = stats:GetPlayerStageStats('PlayerNumber_P2');
			local combo = player_stats:GetCurrentCombo();
			if combo >=2 then
				self:finishtweening();
				self:visible(true);
				self:settext(tostring(combo));
				self:zoom(1.25);
				self:diffuse(color("0.5,0.75,1,1"));
				self:sleep(0.05);
				self:zoom(1.0);
				self:diffuse(color("0,0.5,1,1"));
			else
				self:visible(false);
			end;
		end;
		CurrentComboChangedP2MessageCommand=cmd(playcommand,"PBCombo");
	},
	-- Actor (Score Text P1)
	LoadFont("Common","normal")..{
		Text="0";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_BOTTOM-40;align,0,0.5;diffuse,color("1,0.25,0,1");shadowlength,1);
		OnCommand=function(self)
			self:queuecommand("PAScore");
		end;
		PAScoreCommand=function(self)
			local stats = STATSMAN:GetCurStageStats();
			local player_stats = stats:GetPlayerStageStats('PlayerNumber_P1');
			local score = player_stats:GetScore();
			local percentage = round(player_stats:GetPercentDancePoints()*100, 2);
			local pref = PREFSMAN:GetPreference("PercentageScoring");
			self:finishtweening();
			if pref == true then
				self:settext(tostring(percentage).."%");
			else
				self:settext(tostring(score));
			end;
			self:diffuse(color("1,0.5,0.5,1"));
			self:sleep(0.05);
			self:diffuse(color("1,0.25,0,1"));
		end;
		CurrentComboChangedP1MessageCommand=cmd(playcommand,"PAScore");
	},
	-- Actor (Score Text P2)
	LoadFont("Common","normal")..{
		Text="0";
		InitCommand=cmd(x,SCREEN_RIGHT-4;y,SCREEN_BOTTOM-40;align,1,0.5;diffuse,color("0,0.5,1,1");shadowlength,1);
		OnCommand=function(self)
			self:queuecommand("PBScore");
		end;
		PBScoreCommand=function(self)
			local stats = STATSMAN:GetCurStageStats();
			local player_stats = stats:GetPlayerStageStats('PlayerNumber_P2');
			local score = player_stats:GetScore();
			local percentage = round(player_stats:GetPercentDancePoints()*100, 2);
			local pref = PREFSMAN:GetPreference("PercentageScoring");
			self:finishtweening();
			if pref == true then
				self:settext(tostring(percentage).."%");
			else
				self:settext(tostring(score));
			end;
			self:diffuse(color("0.5,0.75,1,1"));
			self:sleep(0.05);
			self:diffuse(color("0,0.5,1,1"));
		end;
		CurrentComboChangedP2MessageCommand=cmd(playcommand,"PBScore");
	},
	-- Actor (Back Song Remaining Length Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+32,SCREEN_TOP+33,SCREEN_RIGHT-32,SCREEN_TOP+49;diffuse,color(theme_dark_color));
	},
	-- Actor (Front Song Remaining Length Quad)
	-- Note: somewhat buggy but, it works for now...
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+32,SCREEN_TOP+33,SCREEN_RIGHT-32,SCREEN_TOP+49;diffuse,color(theme_color));
		OnCommand=function(self)
			song = GAMESTATE:GetCurrentSong();
			beat_start = 0;
			beat_end = song:GetLastBeat();
			self:queuecommand("Progress");
		end;
		ResetCommand=function(self)
			song = GAMESTATE:GetCurrentSong();
			beat_start = 0;
			beat_end = song:GetLastBeat();
			self:queuecommand("Progress");
		end;
		ProgressCommand=function(self)
			if song ~= nil then
				if beat_start <= beat_end-1 then
					beat_start = beat_start + 1;
				end;
				local beat_current = (beat_start / beat_end) * 790;
				self:finishtweening();
				self:stretchto(SCREEN_LEFT+32,SCREEN_TOP+33,(SCREEN_LEFT+32)+beat_current,SCREEN_TOP+49);
			end;
		end;
		BeatCrossedMessageCommand=cmd(playcommand,"Progress");
		DoneLoadingNextSongMessageCommand=cmd(playcommand,"Reset");
	},
	-- Actor (Overlay Song Remaining Length Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+32,SCREEN_TOP+33,SCREEN_RIGHT-32,SCREEN_TOP+49;diffuseleftedge,color("0,0,0,0.5");diffusealpha,0.25);
	},
	-- Actor (Progress Meter Overlay)
	LoadActor(THEME:GetPathG("", "progress_meter"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+41);
	},
	-- Actor (P1 (2 Players) Danger/Hot Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+54,SCREEN_LEFT+427,SCREEN_BOTTOM-54;diffuse,color("1,0,0,0.10");visible,false);
		OnCommand=function(self)
			p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
			p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
			self:queuecommand('P1Performance');
		end;
		P1PerformanceCommand=function(self)
			p1_joined = false;
			p2_joined = false;
			p1_joined = GAMESTATE:IsPlayerEnabled('PlayerNumber_P1');
			p2_joined = GAMESTATE:IsPlayerEnabled('PlayerNumber_P2');
			if p1_lifebar ~= nil and p2_lifebar ~= nil and p1_joined == true and p2_joined == true then
				p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
				if p1_lifebar:IsInDanger() == true then
					self:visible(true);
					self:diffuse(color("1,0,0,0.10"));
				elseif p1_lifebar:IsHot() == true then
					self:visible(true);
					self:diffuse(color("1,1,1,0.10"));
				elseif p1_lifebar:IsFailing() == true then
					self:visible(true);
					self:diffuse(color("0,0,0,0.10"));
				else
					self:visible(false);
				end;
			end;
		end;
		LifeMeterChangedP1MessageCommand=cmd(playcommand,"P1Performance");
	},
	-- Actor (P2 (2 Players) Danger/Hot Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-2,SCREEN_TOP+54,SCREEN_RIGHT-427,SCREEN_BOTTOM-54;diffuse,color("1,0,0,0.10");visible,false);
		OnCommand=function(self)
			p1_joined = false;
			p2_joined = false;
			p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
			p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
			self:queuecommand('P2Performance');
		end;
		P2PerformanceCommand=function(self)
			p1_joined = false;
			p2_joined = false;
			p1_joined = GAMESTATE:IsPlayerEnabled('PlayerNumber_P1');
			p2_joined = GAMESTATE:IsPlayerEnabled('PlayerNumber_P2');
			if p1_lifebar ~= nil and p2_lifebar ~= nil and p1_joined == true and p2_joined == true then
				p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
				if p2_lifebar:IsInDanger() == true then
					self:visible(true);
					self:diffuse(color("1,0,0,0.10"));
				elseif p2_lifebar:IsHot() == true then
					self:visible(true);
					self:diffuse(color("1,1,1,0.10"));
				elseif p2_lifebar:IsFailing() == true then
					self:visible(true);
					self:diffuse(color("0,0,0,0.10"));
				else
					self:visible(false);
				end;
			end;
		end;
		LifeMeterChangedP2MessageCommand=cmd(playcommand,"P2Performance");
	},
	-- Actor (P1/P2 (1 Player) Danger/Hot Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+54,SCREEN_RIGHT-2,SCREEN_BOTTOM-54;diffuse,color("1,1,1,0.10");visible,false);
		OnCommand=function(self)
			p1_joined = false;
			p2_joined = false;
			p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
			p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
			self:queuecommand('P1P2Performance');
		end;
		P1P2PerformanceCommand=function(self)
			p1_joined = false;
			p2_joined = false;
			p1_joined = GAMESTATE:IsPlayerEnabled('PlayerNumber_P1');
			p2_joined = GAMESTATE:IsPlayerEnabled('PlayerNumber_P2');
			if p1_lifebar ~= nil and p1_joined == true and p2_joined == false then
				p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
				if p1_lifebar:IsInDanger() == true then
					self:visible(true);
					self:diffuse(color("1,0,0,0.10"));
				elseif p1_lifebar:IsHot() == true then
					self:visible(true);
					self:diffuse(color("1,1,1,0.10"));
				elseif p1_lifebar:IsFailing() == true then
					self:visible(true);
					self:diffuse(color("0,0,0,0.10"));
				else
					self:visible(false);
				end;
			end;
			if p2_lifebar ~= nil and p2_joined == true and p1_joined == false then
				p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
				if p2_lifebar:IsInDanger() == true then
					self:visible(true);
					self:diffuse(color("1,0,0,0.25"));
				elseif p2_lifebar:IsHot() == true then
					self:visible(true);
					self:diffuse(color("1,1,1,0.25"));
				elseif p2_lifebar:IsFailing() == true then
					self:visible(true);
					self:diffuse(color("0,0,0,0.25"));
				else
					self:visible(false);
				end;
			end;
		end;
		LifeMeterChangedP1MessageCommand=cmd(playcommand,"P1P2Performance");
		LifeMeterChangedP2MessageCommand=cmd(playcommand,"P1P2Performance");
	},
	-- Function (scripts)
	theme_skin("theme_skin"),
	-- Function (scripts)
	theme_skin("gameplay_theme_skin")
};

return t;