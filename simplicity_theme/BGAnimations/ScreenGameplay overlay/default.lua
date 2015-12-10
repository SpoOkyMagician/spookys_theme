-- ScreenGameplay overlay

-- this is going to get messy... -_-'

local t = Def.ActorFrame{};

input_table = {};
input_table[0] = 0; -- input
input_table[1] = 0; -- count
input_table[2] = 0; -- total
input_table[3] = 0; -- average
input_table[4] = 0; -- peak

-- test

this_second = GetTimeSinceStart();
next_second = (this_second + 1);
total_p1 = 0;
count_p1 = 0;
nps_p1 = 0;
average_p1 = 0;
peak_p1 = 0;
chord_p1 = 0;

-- more test

song = GAMESTATE:GetCurrentSong();
this_beat = 0;
last_beat = 0;
end_beat = 0;


-- Update the Input Actor(Frame)

function InputUpdate(self)
	return self:GetChild("ScreenGameplayOverlayActorFrameInputTextActor"):settext("KPS: " .. tostring(input_table[0]) .. ", Peak KPS: " .. tostring(input_table[4]) .. ", Keys Total: " .. tostring(input_table[2]) .. ", Seconds Total: " .. tostring(input_table[1]) .. ", Average KPS: " .. tostring(input_table[3]));
end

-- function (Input Event)

function input(event)
	if event.type == "InputEventType_FirstPress" and event.PlayerNumber == "PlayerNumber_P1" then
		input_table[0] = (input_table[0] + 1);
	end;
	-- SCREENMAN:SystemMessage(event.button)
	return true;
end

function LifeP1Update(self)
	p1_lifebar = 0.5;
	p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
	if p1_lifebar ~= nil then
		p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
		local life_pa = p1_lifebar:GetLife();
		self:GetChild("PlayerOneLifeMeter"):finishtweening();
		self:GetChild("PlayerOneLifeMeter"):diffuse(color("1,0.25,0,1"));
		self:GetChild("PlayerOneLifeMeter"):stretchto(SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+102+(300*life_pa),SCREEN_TOP+28);
	end;
end

function LifeP2Update(self)
	p2_lifebar = 0.5;
	p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
	if p2_lifebar ~= nil then
		p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
		local life_pb = p2_lifebar:GetLife();
		self:GetChild("PlayerTwoLifeMeter"):finishtweening();
		self:GetChild("PlayerTwoLifeMeter"):diffuse(color("0,0.5,1,1"));
		self:GetChild("PlayerTwoLifeMeter"):stretchto(SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-402+(300*life_pb),SCREEN_TOP+28);
	end;
end

function RecalculateUpdate(self)
	this_second = GetTimeSinceStart();
	if this_second >= next_second then	
		next_second = (GetTimeSinceStart() + 1);
		if input_table[4] < input_table[0] then
			input_table[4] = input_table[0];
		end;
		input_table[2] = (input_table[2] + input_table[0]);
		input_table[0] = 0;
		input_table[1] = (input_table[1] + 1);
		input_table[3] = round(input_table[2] / input_table[1], 2);
		-- don't start until there are arrows.
		if total_p1 ~= 0 then
			input_table[5] = true;
			count_p1 = (count_p1 + 1);
			average_p1 = round(total_p1 / count_p1, 2);
			if peak_p1 < nps_p1 then
				peak_p1 = nps_p1;
			end;
			self:GetChild("NotesPerSecondText"):settext("NPS: " .. tostring(nps_p1) .. ", Peak NPS: " .. tostring(peak_p1) .. ", Note Total: " .. tostring(total_p1) .. ", Seconds Total: " .. tostring(count_p1) .. ", Average NPS: " .. tostring(average_p1) .. ", Chord Total: " .. tostring(chord_p1));
			nps_p1 = 0;
		end;
	end;
end

function RTTP1Update(self)
	local results = STATSMAN:GetCurStageStats();
	local tableresults = results:GetPlayerStageStats('PlayerNumber_P1');
	local combo = tableresults:MaxCombo();
	local released = tableresults:GetHoldNoteScores('HoldNoteScore_LetGo');
	local held = tableresults:GetHoldNoteScores('HoldNoteScore_Held');
	local flawless = tableresults:GetTapNoteScores('TapNoteScore_W1');
	local perfects = tableresults:GetTapNoteScores('TapNoteScore_W2');
	local greats = tableresults:GetTapNoteScores('TapNoteScore_W3');
	local goods = tableresults:GetTapNoteScores('TapNoteScore_W4');
	local bads = tableresults:GetTapNoteScores('TapNoteScore_W5');
	local misses = tableresults:GetTapNoteScores('TapNoteScore_Miss');
	self:GetChild("RTTTextP1Actor"):finishtweening();
	self:GetChild("RTTTextP1Actor"):align(0,0.5);
	self:GetChild("RTTTextP1Actor"):diffuse(color(theme_color));
	self:GetChild("RTTTextP1Actor"):x(SCREEN_LEFT+12);
	self:GetChild("RTTTextP1Actor"):y(SCREEN_BOTTOM/2);
	self:GetChild("RTTTextP1Actor"):settext("\n" .. tostring(flawless) .. "\n" .. tostring(perfects) .. "\n" .. tostring(greats) .. "\n" .. tostring(goods) .. "\n" .. tostring(bads) .. "\n" .. tostring(misses) .. "\n" .. tostring(held) .. "\n" .. tostring(released) .. "\n" .. tostring(combo));
end

function RTTP2Update(self)
	local results = STATSMAN:GetCurStageStats();
	local tableresults = results:GetPlayerStageStats('PlayerNumber_P2');
	local combo = tableresults:MaxCombo();
	local released = tableresults:GetHoldNoteScores('HoldNoteScore_LetGo');
	local held = tableresults:GetHoldNoteScores('HoldNoteScore_Held');
	local flawless = tableresults:GetTapNoteScores('TapNoteScore_W1');
	local perfects = tableresults:GetTapNoteScores('TapNoteScore_W2');
	local greats = tableresults:GetTapNoteScores('TapNoteScore_W3');
	local goods = tableresults:GetTapNoteScores('TapNoteScore_W4');
	local bads = tableresults:GetTapNoteScores('TapNoteScore_W5');
	local misses = tableresults:GetTapNoteScores('TapNoteScore_Miss');
	self:GetChild("RTTTextP2Actor"):finishtweening();
	self:GetChild("RTTTextP2Actor"):align(1,0.5);
	self:GetChild("RTTTextP2Actor"):diffuse(color(theme_color));
	self:GetChild("RTTTextP2Actor"):x(SCREEN_RIGHT-12);
	self:GetChild("RTTTextP2Actor"):y(SCREEN_BOTTOM/2);
	self:GetChild("RTTTextP2Actor"):settext("\n" .. tostring(flawless) .. "\n" .. tostring(perfects) .. "\n" .. tostring(greats) .. "\n" .. tostring(goods) .. "\n" .. tostring(bads) .. "\n" .. tostring(misses) .. "\n" .. tostring(held) .. "\n" .. tostring(released) .. "\n" .. tostring(combo));
end

function ComboSoundP1Update(self)
	local stats = STATSMAN:GetCurStageStats();
	local player_stats = stats:GetPlayerStageStats('PlayerNumber_P1');
	local combo = player_stats:GetCurrentCombo();
	if combo == 100 or combo == 200 or combo == 300 or combo == 400 or combo == 500 or combo == 600 or combo == 700 or combo == 800 or combo == 900 or combo == 1000 or combo == 2000 or combo == 3000 or combo == 4000 or combo == 5000 or combo == 6000 or combo == 7000 or combo == 8000 or combo == 9000 or combo == 10000 or combo == 20000 or combo == 30000 or combo == 40000 or combo == 50000 or combo == 60000 or combo == 70000 or combo == 80000 or combo == 90000 or combo == 100000 or combo == 200000 or combo == 300000 or combo == 400000 or combo == 500000 or combo == 600000 or combo == 700000 or combo == 800000 or combo == 900000 or combo == 1000000 then
		self:GetChild("ComboNoiseP1"):play();
	end;
end

function ComboSoundP2Update(self)
	local stats = STATSMAN:GetCurStageStats();
	local player_stats = stats:GetPlayerStageStats('PlayerNumber_P2');
	local combo = player_stats:GetCurrentCombo();
	if combo == 100 or combo == 200 or combo == 300 or combo == 400 or combo == 500 or combo == 600 or combo == 700 or combo == 800 or combo == 900 or combo == 1000 or combo == 2000 or combo == 3000 or combo == 4000 or combo == 5000 or combo == 6000 or combo == 7000 or combo == 8000 or combo == 9000 or combo == 10000 or combo == 20000 or combo == 30000 or combo == 40000 or combo == 50000 or combo == 60000 or combo == 70000 or combo == 80000 or combo == 90000 or combo == 100000 or combo == 200000 or combo == 300000 or combo == 400000 or combo == 500000 or combo == 600000 or combo == 700000 or combo == 800000 or combo == 900000 or combo == 1000000 then
		self:GetChild("ComboNoiseP2"):play();
	end;
end

function ComboTextP1Update(self)
	local stats = STATSMAN:GetCurStageStats();
	local player_stats = stats:GetPlayerStageStats('PlayerNumber_P1');
	local combo = player_stats:GetCurrentCombo();
	if combo >=2 then
		self:GetChild("ComboTextP1"):finishtweening();
		self:GetChild("ComboTextP1"):visible(true);
		self:GetChild("ComboTextP1"):settext(tostring(combo));
		self:GetChild("ComboTextP1"):diffuse(color("1,0.25,0,1"));
	else
		self:GetChild("ComboTextP1"):finishtweening();
		self:GetChild("ComboTextP1"):visible(false);
	end;
end

function ComboTextP2Update(self)
	local stats = STATSMAN:GetCurStageStats();
	local player_stats = stats:GetPlayerStageStats('PlayerNumber_P2');
	local combo = player_stats:GetCurrentCombo();
	if combo >=2 then
		self:GetChild("ComboTextP2"):finishtweening();
		self:GetChild("ComboTextP2"):visible(true);
		self:GetChild("ComboTextP2"):settext(tostring(combo));
		self:GetChild("ComboTextP2"):diffuse(color("0,0.5,1,1"));
	else
		self:GetChild("ComboTextP2"):finishtweening();
		self:GetChild("ComboTextP2"):visible(false);
	end;
end

function GradeP1Update(self)
	local stats = STATSMAN:GetCurStageStats();
	local player_stats = stats:GetPlayerStageStats('PlayerNumber_P1');
	local grade = player_stats:GetGrade();
	self:GetChild("GradeP1"):finishtweening();
	if grade ~= nil then
		self:GetChild("GradeP1"):Load(THEME:GetPathG("grade", grade));
	else
		self:GetChild("GradeP1"):Load(THEME:GetPathG("", "grade_unknown"));
	end;
end

function GradeP2Update(self)
	local stats = STATSMAN:GetCurStageStats();
	local player_stats = stats:GetPlayerStageStats('PlayerNumber_P2');
	local grade = player_stats:GetGrade();
	self:GetChild("GradeP2"):finishtweening();
	if grade ~= nil then
		self:GetChild("GradeP2"):Load(THEME:GetPathG("grade", grade));
	else
		self:GetChild("GradeP2"):Load(THEME:GetPathG("", "grade_unknown"));
	end;
end

function ScoreP1Update(self)
	local stats = STATSMAN:GetCurStageStats();
	local player_stats = stats:GetPlayerStageStats('PlayerNumber_P1');
	local score = player_stats:GetScore();
	local percentage = round(player_stats:GetPercentDancePoints()*100, 2);
	local pref = PREFSMAN:GetPreference("PercentageScoring");
	if pref == true then
		self:GetChild("ScoreP1"):settext(tostring(percentage).."%");
	else
		self:GetChild("ScoreP1"):settext(tostring(score));
	end;
	self:GetChild("ScoreP1"):finishtweening();
	self:GetChild("ScoreP1"):diffuse(color("1,0.25,0,1"));
end

function ScoreP2Update(self)
	local stats = STATSMAN:GetCurStageStats();
	local player_stats = stats:GetPlayerStageStats('PlayerNumber_P2');
	local score = player_stats:GetScore();
	local percentage = round(player_stats:GetPercentDancePoints()*100, 2);
	local pref = PREFSMAN:GetPreference("PercentageScoring");
	if pref == true then
		self:GetChild("ScoreP2"):settext(tostring(percentage).."%");
	else
		self:GetChild("ScoreP2"):settext(tostring(score));
	end;
	self:GetChild("ScoreP2"):finishtweening();
	self:GetChild("ScoreP2"):diffuse(color("0,0.5,1,1"));
end

function SongBeatUpdate(self)
	this_beat = GAMESTATE:GetSongBeat();
	if song ~= nil then
		if this_beat > last_beat then
			last_beat = GAMESTATE:GetSongBeat();
			local beat_current = (this_beat / end_beat) * 790;
			if beat_current > 790 then
				-- oops.
				beat_current = 790;
			end;
			self:GetChild("ProgressMeter"):finishtweening();
			self:GetChild("ProgressMeter"):stretchto(SCREEN_LEFT+32,SCREEN_TOP+33,(SCREEN_LEFT+32)+beat_current,SCREEN_TOP+49);
		end;
	end;
end

function PlayerOneTwoPlayersHotDanger(self)
	p1_joined = false;
	p2_joined = false;
	p1_joined = GAMESTATE:IsPlayerEnabled('PlayerNumber_P1');
	p2_joined = GAMESTATE:IsPlayerEnabled('PlayerNumber_P2');
	self:GetChild("HotDangerP1TwoPlayers"):finishtweening();
	if p1_lifebar ~= nil and p2_lifebar ~= nil and p1_joined == true and p2_joined == true then
		p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
		if p1_lifebar:IsInDanger() == true then
			self:GetChild("HotDangerP1TwoPlayers"):visible(true);
			self:GetChild("HotDangerP1TwoPlayers"):diffuse(color("1,0,0,0.05"));
		elseif p1_lifebar:IsHot() == true then
			self:GetChild("HotDangerP1TwoPlayers"):visible(true);
			self:GetChild("HotDangerP1TwoPlayers"):diffuse(color("1,1,1,0.05"));
		elseif p1_lifebar:IsFailing() == true then
			self:GetChild("HotDangerP1TwoPlayers"):visible(true);
			self:GetChild("HotDangerP1TwoPlayers"):diffuse(color("0,0,0,0.05"));
		else
			self:GetChild("HotDangerP1TwoPlayers"):visible(false);
		end;
	end;
end

function PlayerTwoTwoPlayersHotDanger(self)
	p1_joined = false;
	p2_joined = false;
	p1_joined = GAMESTATE:IsPlayerEnabled('PlayerNumber_P1');
	p2_joined = GAMESTATE:IsPlayerEnabled('PlayerNumber_P2');
	self:GetChild("HotDangerP2TwoPlayers"):finishtweening();
	if p1_lifebar ~= nil and p2_lifebar ~= nil and p1_joined == true and p2_joined == true then
		p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
		if p2_lifebar:IsInDanger() == true then
			self:GetChild("HotDangerP2TwoPlayers"):visible(true);
			self:GetChild("HotDangerP2TwoPlayers"):diffuse(color("1,0,0,0.05"));
		elseif p2_lifebar:IsHot() == true then
			self:GetChild("HotDangerP2TwoPlayers"):visible(true);
			self:GetChild("HotDangerP2TwoPlayers"):diffuse(color("1,1,1,0.05"));
		elseif p2_lifebar:IsFailing() == true then
			self:GetChild("HotDangerP2TwoPlayers"):visible(true);
			self:GetChild("HotDangerP2TwoPlayers"):diffuse(color("0,0,0,0.05"));
		else
			self:GetChild("HotDangerP2TwoPlayers"):visible(false);
		end;
	end;
end

function OnePlayerCombinedHotDanger(self)
	p1_joined = false;
	p2_joined = false;
	p1_joined = GAMESTATE:IsPlayerEnabled('PlayerNumber_P1');
	p2_joined = GAMESTATE:IsPlayerEnabled('PlayerNumber_P2');
	self:GetChild("HotDangerAnyPlayer"):finishtweening();
	if p1_lifebar ~= nil and p1_joined == true and p2_joined == false then
		p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
		if p1_lifebar:IsInDanger() == true then
			self:GetChild("HotDangerAnyPlayer"):visible(true);
			self:GetChild("HotDangerAnyPlayer"):diffuse(color("1,0,0,0.05"));
		elseif p1_lifebar:IsHot() == true then
			self:GetChild("HotDangerAnyPlayer"):visible(true);
			self:GetChild("HotDangerAnyPlayer"):diffuse(color("1,1,1,0.05"));
		elseif p1_lifebar:IsFailing() == true then
			self:GetChild("HotDangerAnyPlayer"):visible(true);
			self:GetChild("HotDangerAnyPlayer"):diffuse(color("0,0,0,0.05"));
		else
			self:GetChild("HotDangerAnyPlayer"):visible(false);
		end;
	end;
	if p2_lifebar ~= nil and p2_joined == true and p1_joined == false then
		p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
		if p2_lifebar:IsInDanger() == true then
			self:GetChild("HotDangerAnyPlayer"):visible(true);
			self:GetChild("HotDangerAnyPlayer"):diffuse(color("1,0,0,0.05"));
		elseif p2_lifebar:IsHot() == true then
			self:GetChild("HotDangerAnyPlayer"):visible(true);
			self:GetChild("HotDangerAnyPlayer"):diffuse(color("1,1,1,0.05"));
		elseif p2_lifebar:IsFailing() == true then
			self:GetChild("HotDangerAnyPlayer"):visible(true);
			self:GetChild("HotDangerAnyPlayer"):diffuse(color("0,0,0,0.05"));
		else
			self:GetChild("HotDangerAnyPlayer"):visible(false);
		end;
	end;
end

-- lets try this... (ActorFrame 0)

t[#t+1]= use_newfield_actor(144);

-- common/simple actors (ActorFrame 1)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameCommon";
	-- Actor/Function (scripts)
	grid_a(),
	-- Actor/Function (scripts)
	grid_b(),
	-- Actor (Score Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_BOTTOM-30,SCREEN_RIGHT-2,SCREEN_BOTTOM-52;diffuse,color("0,0,0,0.75"));
	},
	-- Actor (Progress Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+30,SCREEN_RIGHT-2,SCREEN_TOP+52;diffuse,color("0,0,0,0.75"));
	}
};

-- Stage Actor (ActorFrame 2)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameStage";
	-- Actor (Stage Icon)
	LoadActor(THEME:GetPathG("", "stage_icon_unknown"))..{
		InitCommand=cmd(x,SCREEN_RIGHT/2;y,SCREEN_TOP+15);
		-- since this is only done once, I will leave this as is.
		OnCommand=function(self)
			if last_known_stage ~= nil then
				self:Load(THEME:GetPathG("icon", last_known_stage));
			else
				self:Load(THEME:GetPathG("", "stage_icon_unknown"));
			end;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("#FFFFFFFF"));
		end;
	}
};

-- Difficulty P1/P2 Actor (ActorFrame 3)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameDifficultyPlayers";
	-- Actor (Song Difficulty P1)
	LoadActor(THEME:GetPathG("", "icon_unknown"))..{
		InitCommand=cmd(x,SCREEN_LEFT+51;y,SCREEN_TOP+15);
		-- since this is only done once, I will leave this as is.
		OnCommand=function(self)
			if last_known_difficulty_P1 ~= nil then
				self:Load(THEME:GetPathG("icon", last_known_difficulty_P1));
			else
				self:Load(THEME:GetPathG("", "icon_unknown"));
			end;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("#FFFFFFFF"));
		end;
	},
	-- Actor (Song Difficulty P2)
	LoadActor(THEME:GetPathG("", "icon_unknown"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-51;y,SCREEN_TOP+15);
		-- since this is only done once, I will leave this as is.
		OnCommand=function(self)
			if last_known_difficulty_P2 ~= nil then
				self:Load(THEME:GetPathG("icon", last_known_difficulty_P2));
			else
				self:Load(THEME:GetPathG("", "icon_unknown"));
			end;
			self:finishtweening();
			self:diffuse(color("#FFFFFF00"));
			self:linear(0.4);
			self:diffuse(color("#FFFFFFFF"));
		end;
	}
};

-- Dance Meter Back Actor (ActorFrame 4)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameDanceMeterBack";
	-- Actor (Back Life Meter P1)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+402,SCREEN_TOP+28;diffuse,color("0.1,0.1,0.1,1"));
	},
	-- Actor (Back Life Meter P2)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28;diffuse,color("0.1,0.1,0.1,1"));
	}
};

-- P1 Dance Meter Actual Actor (ActorFrame 5)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameActualDanceMeter";
	InitCommand=function(self)
		self:SetUpdateFunction(LifeP1Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Front Life Meter P1)
	Def.Quad{
		Name="PlayerOneLifeMeter";
		InitCommand=cmd(stretchto,SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+402,SCREEN_TOP+28;diffuse,color("1,0.25,0,1"));
	},
};

-- P2 Dance Meter Actual Actor (ActorFrame 6)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameActualDanceMeter";
	InitCommand=function(self)
		self:SetUpdateFunction(LifeP2Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Front Life Meter P2)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28;diffuse,color("0,0.5,1,1"));
	}
};

-- Dance Meter Overlay Actor (ActorFrame 7)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameDanceMeterOverlay";
	-- Actor (Life Meter Overlay P1)
	LoadActor(THEME:GetPathG("", "life_meter_overlay"))..{
		InitCommand=cmd(x,SCREEN_LEFT+252;y,SCREEN_TOP+15);
	},
	-- Actor (Life Meter Overlay P2)
	LoadActor(THEME:GetPathG("", "life_meter_overlay"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-252;y,SCREEN_TOP+15);
	}
};

-- NPS Actor (ActorFrame 7)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameNotesPerSecond";
	InitCommand=function(self)
		self:SetUpdateFunction(RecalculateUpdate);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (P1 NPS)
	-- Note: fps is another problem as well. I cannot say how accurate this is anymore...
	LoadFont("Common","normal")..{
		Name="NotesPerSecondText";
		Text=" ";
		OnCommand=function(self)
			self:x(SCREEN_LEFT+8);
			self:y(SCREEN_TOP+64);
			self:align(0,0.5);
			self:diffuse(color(theme_color));
			self:shadowlength(1);
			self:zoom(0.5);
		end;
		JudgmentMessageCommand=function(self, param)
			chord_p1 = 0;
			if param.Player == 'PlayerNumber_P1' then
				for i=1,GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() do
					if param.Notes ~= nil and param.Notes[i] ~= nil then
						chord_p1 = (chord_p1 + 1)
					end;
				end;
				nps_p1 = (nps_p1 + chord_p1);
				total_p1 = (total_p1 + chord_p1);
			end;
			self:settext("NPS: " .. tostring(nps_p1) .. ", Peak NPS: - " .. ", Note Total: " .. tostring(total_p1) .. ", Seconds Total: - " .. ", Average NPS: - " .. ", Chord Total: " .. tostring(chord_p1));
		end;
	}
};

-- ActorFrame (Input Related ActorFrame 8)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameInputActor";
	OnCommand=function(self) SCREENMAN:GetTopScreen():AddInputCallback(input) end;
	InitCommand=function(self)
		self:SetUpdateFunction(InputUpdate);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Experimental KPS)
	LoadFont("Common","normal")..{
		Name="ScreenGameplayOverlayActorFrameInputTextActor";
		Text="KPS: 0, (Average: 0 )";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+64+12;align,0,0.5;diffuse,color(theme_color);shadowlength,1;zoom,0.5);
	}
};

-- RTT Actor (ActorFrame 9)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameRealTimeTiming";
	-- Actor (Real Time Timing Graphic P1)
	LoadActor(THEME:GetPathG("icon", "rtt"))..{
		InitCommand=cmd(x,SCREEN_LEFT+2;y,SCREEN_BOTTOM/2+12;align,0,0.5);
	},
	-- Actor (Real Time Timing Graphic P2)
	LoadActor(THEME:GetPathG("icon", "rtt"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-2;y,SCREEN_BOTTOM/2+12;align,1,0.5);
	}
};

-- RTT Text Actor (ActorFrame 10)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameRealTimeTimingTextP1";
	InitCommand=function(self)
		self:SetUpdateFunction(RTTP1Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Results P1 Actual Text)
	LoadFont("Common", "normal")..{
		Name="RTTTextP1Actor";
		Text=" ";
		InitCommand=cmd(x,SCREEN_LEFT+12;y,SCREEN_BOTTOM/2;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.75);
	}
};

-- RTT Text Actor (ActorFrame 11)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameRealTimeTimingTextP2";
	InitCommand=function(self)
		self:SetUpdateFunction(RTTP2Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Results P2 Actual Text)
	LoadFont("Common", "normal")..{
		Name="RTTTextP2Actor";
		Text=" ";
		InitCommand=cmd(x,SCREEN_RIGHT-12;y,SCREEN_BOTTOM/2;diffuse,color(theme_color);align,1,0.5;shadowlength,1;zoom,0.75);
	}
};

-- Combo Noise P1 Actor (ActorFrame 12)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameComboNoiseP1";
	InitCommand=function(self)
		self:SetUpdateFunction(ComboSoundP1Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Combo Noise)
	LoadActor(THEME:GetPathS("","combo_tick"))..{
		Name="ComboNoiseP1";
	}
};

-- Combo Noise P2 Actor (ActorFrame 13)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameComboNoiseP2";
	InitCommand=function(self)
		self:SetUpdateFunction(ComboSoundP2Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Combo Noise)
	LoadActor(THEME:GetPathS("","combo_tick"))..{
		Name="ComboNoiseP2";
	}
};

-- Combo Text P1 Actor (ActorFrame 14)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameComboTextP1";
	InitCommand=function(self)
		self:SetUpdateFunction(ComboTextP1Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Combo Text P1)
	LoadFont("Common","normal")..{
		Name="ComboTextP1";
		Text="0";
		InitCommand=cmd(x,SCREEN_RIGHT/2-4;y,SCREEN_BOTTOM-42;align,1,0.5;diffuse,color("1,0.25,0,1");visible,false;shadowlength,1);
	}
};

-- Combo Text P2 Actor (ActorFrame 15)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameComboTextP2";
	InitCommand=function(self)
		self:SetUpdateFunction(ComboTextP2Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Combo Text P2)
	LoadFont("Common","normal")..{
		Name="ComboTextP2";
		Text="0";
		InitCommand=cmd(x,SCREEN_RIGHT/2+4;y,SCREEN_BOTTOM-42;align,0,0.5;diffuse,color("0,0.5,1,1");visible,false;shadowlength,1);
	}
};

-- Grade Actor (ActorFrame 16)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameGradeIconP1";
	InitCommand=function(self)
		self:SetUpdateFunction(GradeP1Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Grade P1)
	LoadActor(THEME:GetPathG("", "grade_unknown"))..{
		Name="GradeP1";
		InitCommand=cmd(x,SCREEN_LEFT+16;y,SCREEN_TOP+124);
	}
};

-- Grade Actor (ActorFrame 17)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameGradeIconP2";
	InitCommand=function(self)
		self:SetUpdateFunction(GradeP2Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Grade P2)
	LoadActor(THEME:GetPathG("", "grade_unknown"))..{
		Name="GradeP2";
		InitCommand=cmd(x,SCREEN_RIGHT-16;y,SCREEN_TOP+124);
	}
};

-- Score Text Actor (ActorFrame 18)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameScoreText";
	InitCommand=function(self)
		self:SetUpdateFunction(ScoreP1Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Score Text P1)
	LoadFont("Common","normal")..{
		Name="ScoreP1";
		Text="0";
		InitCommand=cmd(x,SCREEN_LEFT+4;y,SCREEN_BOTTOM-42;align,0,0.5;diffuse,color("1,0.25,0,1");shadowlength,1);
	}
};

-- Score Text Actor (ActorFrame 19)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameScoreText";
	InitCommand=function(self)
		self:SetUpdateFunction(ScoreP2Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Score Text P2)
	LoadFont("Common","normal")..{
		Name="ScoreP2";
		Text="0";
		InitCommand=cmd(x,SCREEN_RIGHT-4;y,SCREEN_BOTTOM-42;align,1,0.5;diffuse,color("0,0.5,1,1");shadowlength,1);
	}
};

-- Song Remaining Back Actor (ActorFrame 20)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameSongRemainingBack";
	-- Actor (Back Song Remaining Length Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+32,SCREEN_TOP+33,SCREEN_RIGHT-32,SCREEN_TOP+49;diffuse,color(theme_dark_color));
	}
};

-- Song Remaining Actual Actor (ActorFrame 21)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameActualSongRemaining";
	InitCommand=function(self)
		self:SetUpdateFunction(SongBeatUpdate);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Front Song Remaining Length Quad)
	-- Note: somewhat buggy but, it works for now...
	Def.Quad{
		Name="ProgressMeter";
		InitCommand=cmd(stretchto,SCREEN_LEFT+32,SCREEN_TOP+33,SCREEN_RIGHT-32,SCREEN_TOP+49;diffuse,color(theme_color));
		OnCommand=function(self)
			this_beat = song:GetFirstBeat();
			last_beat = song:GetFirstBeat();
			end_beat = song:GetLastBeat();
		end;
	}
};

-- Song Remaining Front Actor (ActorFrame 22)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameSongRemainingFront";
	-- Actor (Overlay Song Remaining Length Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+32,SCREEN_TOP+33,SCREEN_RIGHT-32,SCREEN_TOP+49;diffuseleftedge,color("0,0,0,0.5");diffusealpha,0.25);
	},
	-- Actor (Progress Meter Overlay)
	LoadActor(THEME:GetPathG("", "progress_meter"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+41);
	}
};

-- Judgment Bar P1/P2 (ActorFrame 23)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameComboJudgment";
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(SCREEN_LEFT+2,SCREEN_TOP+82,SCREEN_LEFT+30,SCREEN_TOP+110);
			self:diffuse(color("0,0,0,1"));
		end;
		JudgmentMessageCommand=function(self, param)
			self:finishtweening();
			if param.Player == 'PlayerNumber_P1' then
				if param.TapNoteScore == 'TapNoteScore_W1' then
					self:diffuse(color("0,1,1,1"));
				elseif param.TapNoteScore == 'TapNoteScore_W2' then
					self:diffuse(color("1,1,0,1"));
				elseif param.TapNoteScore == 'TapNoteScore_W3' then
					self:diffuse(color("0,1,0,1"));
				elseif param.TapNoteScore == 'TapNoteScore_W4' then
					self:diffuse(color("0,0,1,1"));
				elseif param.TapNoteScore == 'TapNoteScore_W5' then
					self:diffuse(color("1,0,1,1"));
				elseif param.TapNoteScore == 'TapNoteScore_Miss' then
					self:diffuse(color("1,0,0,1"));
				elseif param.TapNoteScore == 'TapNoteScore_CheckpointHit' then
					self:diffuse(color("1,1,1,1"));
				elseif param.TapNoteScore == 'TapNoteScore_CheckpointMiss' then
					self:diffuse(color("0.5,0.5,0.5,1"));
				elseif param.TapNoteScore == 'TapNoteScore_HitMine' then
					self:diffuse(color("1,0.8,0,1"));
				elseif param.TapNoteScore == 'TapNoteScore_AvoidMine' then
					self:diffuse(color("0.75,0.75,0.75,1"));
				elseif param.HoldNoteScore == 'HoldNoteScore_Held' then
					self:diffuse(color("0.5,1,0,1"));
				elseif param.HoldNoteScore == 'HoldNoteScore_LetGo' then
					self:diffuse(color("1,0.5,0,1"));
				elseif param.HoldNoteScore == 'HoldNoteScore_MissedHold' then
					self:diffuse(color("0.5,0.5,0.5,1"));
				else
					self:diffuse(color("0,0,0,1"));
				end;
			end;
			self:accelerate(0.25)
			self:diffuse(color("0,0,0,1"));
		end;
	},
	Def.Quad{
		OnCommand=function(self)
			self:stretchto(SCREEN_RIGHT-30,SCREEN_TOP+82,SCREEN_RIGHT-2,SCREEN_TOP+110);
			self:diffuse(color("0,0,0,1"));
		end;
		JudgmentMessageCommand=function(self, param)
			self:finishtweening();
			if param.Player == 'PlayerNumber_P2' then
				if param.TapNoteScore == 'TapNoteScore_W1' then
					self:diffuse(color("0,1,1,1"));
				elseif param.TapNoteScore == 'TapNoteScore_W2' then
					self:diffuse(color("1,1,0,1"));
				elseif param.TapNoteScore == 'TapNoteScore_W3' then
					self:diffuse(color("0,1,0,1"));
				elseif param.TapNoteScore == 'TapNoteScore_W4' then
					self:diffuse(color("0,0,1,1"));
				elseif param.TapNoteScore == 'TapNoteScore_W5' then
					self:diffuse(color("1,0,1,1"));
				elseif param.TapNoteScore == 'TapNoteScore_Miss' then
					self:diffuse(color("1,0,0,1"));
				elseif param.TapNoteScore == 'TapNoteScore_CheckpointHit' then
					self:diffuse(color("1,1,1,1"));
				elseif param.TapNoteScore == 'TapNoteScore_CheckpointMiss' then
					self:diffuse(color("0.5,0.5,0.5,1"));
				elseif param.TapNoteScore == 'TapNoteScore_HitMine' then
					self:diffuse(color("1,0.8,0,1"));
				elseif param.TapNoteScore == 'TapNoteScore_AvoidMine' then
					self:diffuse(color("0.75,0.75,0.75,1"));
				elseif param.HoldNoteScore == 'HoldNoteScore_Held' then
					self:diffuse(color("0.5,1,0,1"));
				elseif param.HoldNoteScore == 'HoldNoteScore_LetGo' then
					self:diffuse(color("1,0.5,0,1"));
				elseif param.HoldNoteScore == 'HoldNoteScore_MissedHold' then
					self:diffuse(color("0.5,0.5,0.5,1"));
				else
					self:diffuse(color("0,0,0,1"));
				end;
			end;
			self:accelerate(0.25)
			self:diffuse(color("0,0,0,1"));
		end;
	}
};

-- Hot/Danger Actor (ActorFrame 24)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameHotAndDanger";
	InitCommand=function(self)
		self:SetUpdateFunction(PlayerOneTwoPlayersHotDanger);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (P1 (2 Players) Danger/Hot Quad)
	Def.Quad{
		Name="HotDangerP1TwoPlayers";
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+54,SCREEN_LEFT+427,SCREEN_BOTTOM-54;diffuse,color("1,0,0,0.10");visible,false);
		OnCommand=function(self)
			self:sleep(0.1);
			p1_joined = false;
			p2_joined = false;
			p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
			p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
		end;
	}
};

-- Hot/Danger Actor (ActorFrame 25)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameHotAndDanger";
	InitCommand=function(self)
		self:SetUpdateFunction(PlayerTwoTwoPlayersHotDanger);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (P2 (2 Players) Danger/Hot Quad)
	Def.Quad{
		Name="HotDangerP2TwoPlayers";
		InitCommand=cmd(stretchto,SCREEN_RIGHT-2,SCREEN_TOP+54,SCREEN_RIGHT-427,SCREEN_BOTTOM-54;diffuse,color("1,0,0,0.10");visible,false);
		OnCommand=function(self)
			self:sleep(1);
			p1_joined = false;
			p2_joined = false;
			p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
			p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
		end;
	}
};

-- Hot/Danger Actor (ActorFrame 26)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameHotAndDanger";
	InitCommand=function(self)
		self:SetUpdateFunction(OnePlayerCombinedHotDanger);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (P1/P2 (1 Player) Danger/Hot Quad)
	Def.Quad{
		Name="HotDangerAnyPlayer";
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+54,SCREEN_RIGHT-2,SCREEN_BOTTOM-54;diffuse,color("1,1,1,0.10");visible,false);
		OnCommand=function(self)
			self:sleep(1);
			p1_joined = false;
			p2_joined = false;
			p1_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
			p2_lifebar = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
		end;
	}
};

-- Theme Skin Overlay Actor (ActorFrame 27)

t[#t+1] = Def.ActorFrame{
	Name="ScreenGameplayOverlayActorFrameThemeSkinOverlay";
	-- Actor/Function (scripts)
	theme_skin("theme_skin"),
	-- Actor/Function (scripts)
	theme_skin("gameplay_theme_skin")
};
	
return t;