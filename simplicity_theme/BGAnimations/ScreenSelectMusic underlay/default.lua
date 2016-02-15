-- ScreenSelectMusic underlay

-- time for another update... -_-'

local t = Def.ActorFrame{};

-- good lord, thank you for helping me out with this Kyzentun...
-- now i understand the problem...

-- note: I figured out even more... I feel like a dumbass not using trace more... wheel/type was not updating because I was not redeclaring the variables... finally fixed it.
-- note: Crap! That crashed the game... Thankfully, I found a fix that seems to prevent the crash. I still need to do some further testing though...

-- let's set some variables to organize/re-use later...

local wheel = {}; -- SCREENMAN:GetTopScreen():GetMusicWheel();
local type = {}; -- wheel:GetSelectedType();
local p1_steps = {}; -- GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
local p2_steps = {}; -- GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
local p1_values = 0; -- p1_steps:GetRadarValues('PlayerNumber_P1');
local p2_values = 0; -- p2_steps:GetRadarValues('PlayerNumber_P2');
local difficulty_p1_steps = 'Difficulty_Edit'; -- p1_steps:GetDifficulty();
local difficulty_p2_steps = 'Difficulty_Edit'; -- p2_steps:GetDifficulty();
local sort = 'SortOrder_Group'; -- GAMESTATE:GetSortOrder();
local song = {}; -- GAMESTATE:GetCurrentSong();
local banner = " "; -- self:LoadFromSong(song);
local cd_path = " "; -- song:GetCDImagePath();
local group = "N/A"; -- GAMESTATE:GetExpandedSectionName();

-- These global variables needs to be reset.

steps_p1_table = {};
steps_p2_table = {};

steps_p1_table[1] = 0;
steps_p1_table[2] = 0;
steps_p1_table[3] = 0;
steps_p1_table[4] = 0;
steps_p1_table[5] = 0;
steps_p1_table[6] = 0;
steps_p1_table[7] = 0;
steps_p1_table[8] = 0;
steps_p1_table[9] = 0;

steps_p2_table[1] = 0;
steps_p2_table[2] = 0;
steps_p2_table[3] = 0;
steps_p2_table[4] = 0;
steps_p2_table[5] = 0;
steps_p2_table[6] = 0;
steps_p2_table[7] = 0;
steps_p2_table[8] = 0;
steps_p2_table[9] = 0;

p1_percentage_taps = 0;
p1_percentage_jumps = 0;
p1_percentage_holds = 0;
p1_percentage_mines = 0;
p1_percentage_hands = 0;
p1_percentage_rolls = 0;
p1_percentage_lifts = 0;
p1_percentage_fakes = 0;

p2_percentage_taps = 0;
p2_percentage_jumps = 0;
p2_percentage_holds = 0;
p2_percentage_mines = 0;
p2_percentage_hands = 0;
p2_percentage_rolls = 0;
p2_percentage_lifts = 0;
p2_percentage_fakes = 0;

function WheelStuffUpdate()
	-- Let's keep track of this stuff here...
	wheel = SCREENMAN:GetTopScreen():GetMusicWheel();
	type = wheel:GetSelectedType();
	if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
		p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
		p1_values = p1_steps:GetRadarValues('PlayerNumber_P1');
		difficulty_p1_steps = p1_steps:GetDifficulty();
		steps_p1_table[1] = p1_values:GetValue('RadarCategory_TapsAndHolds');
		steps_p1_table[2] = p1_values:GetValue('RadarCategory_Jumps');
		steps_p1_table[3] = p1_values:GetValue('RadarCategory_Holds');
		steps_p1_table[4] = p1_values:GetValue('RadarCategory_Mines');
		steps_p1_table[5] = p1_values:GetValue('RadarCategory_Hands');
		steps_p1_table[6] = p1_values:GetValue('RadarCategory_Rolls');
		steps_p1_table[7] = p1_values:GetValue('RadarCategory_Lifts');
		steps_p1_table[8] = p1_values:GetValue('RadarCategory_Fakes');
		steps_p1_table[9] = steps_p1_table[1] + steps_p1_table[2] + steps_p1_table[3] + steps_p1_table[4] + steps_p1_table[5] + steps_p1_table[6] + steps_p1_table[7] + steps_p1_table[8];
	end;
	if GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
		p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
		p2_values = p2_steps:GetRadarValues('PlayerNumber_P2');
		difficulty_p2_steps = p2_steps:GetDifficulty();
		steps_p2_table[1] = p2_values:GetValue('RadarCategory_TapsAndHolds');
		steps_p2_table[2] = p2_values:GetValue('RadarCategory_Jumps');
		steps_p2_table[3] = p2_values:GetValue('RadarCategory_Holds');
		steps_p2_table[4] = p2_values:GetValue('RadarCategory_Mines');
		steps_p2_table[5] = p2_values:GetValue('RadarCategory_Hands');
		steps_p2_table[6] = p2_values:GetValue('RadarCategory_Rolls');
		steps_p2_table[7] = p2_values:GetValue('RadarCategory_Lifts');
		steps_p2_table[8] = p2_values:GetValue('RadarCategory_Fakes');
		steps_p2_table[9] = steps_p2_table[1] + steps_p2_table[2] + steps_p2_table[3] + steps_p2_table[4] + steps_p2_table[5] + steps_p2_table[6] + steps_p2_table[7] + steps_p2_table[8];
	end;
	sort = GAMESTATE:GetSortOrder();
	song = GAMESTATE:GetCurrentSong();
	group = GAMESTATE:GetExpandedSectionName();
	-- Might need this...
--	Trace("+--------+");
--	Trace("| DEBUG  |");
--	Trace("+--------+");
--	Trace("| LKD P1: " .. tostring(last_known_difficulty_P1));
--	Trace("| ST P1: " .. tostring(steps_p1_table[1]) .. ", " .. tostring(steps_p1_table[2]) .. ", " .. tostring(steps_p1_table[3]) .. ", " .. tostring(steps_p1_table[4]) .. ", " .. tostring(steps_p1_table[5]) .. ", " .. tostring(steps_p1_table[6]) .. ", " .. tostring(steps_p1_table[7]) .. ", " .. tostring(steps_p1_table[8]) .. " = " .. tostring(steps_p1_table[9]));
--	Trace("+--------+");
--	Trace("| LKD P2: " .. tostring(last_known_difficulty_P2));
--	Trace("| ST P2: " .. tostring(steps_p2_table[1]) .. ", " .. tostring(steps_p2_table[2]) .. ", " .. tostring(steps_p2_table[3]) .. ", " .. tostring(steps_p2_table[4]) .. ", " .. tostring(steps_p2_table[5]) .. ", " .. tostring(steps_p2_table[6]) .. ", " .. tostring(steps_p2_table[7]) .. ", " .. tostring(steps_p2_table[8]) .. " = " .. tostring(steps_p2_table[9]));
--	Trace("+--------+");
--	Trace("| type: " .. tostring(type));
--	Trace("+--------+");
end

function SongBannerUpdate(self)
	self:GetChild("ScreenSelectMusicUnderlayActorSongBanner"):finishtweening();
	if wheel and type == 'WheelItemDataType_Roulette' then
		self:GetChild("ScreenSelectMusicUnderlayActorSongBanner"):Load(THEME:GetPathG("", "roulette"));
	end;
	if wheel and type == 'WheelItemDataType_Section' then
		banner = self:GetChild("ScreenSelectMusicUnderlayActorSongBanner"):LoadFromSongGroup(group);
	--	SCREENMAN:SystemMessage("What is this? " .. tostring(banner));
	end;
	if wheel and type == 'WheelItemDataType_Song' and song ~= nil then
		if song:HasBanner() == true then
			self:GetChild("ScreenSelectMusicUnderlayActorSongBanner"):LoadFromSong(song);
		else
			self:GetChild("ScreenSelectMusicUnderlayActorSongBanner"):LoadFromSongGroup(group);
		end;
	end;
end

function SongBackgroundUpdate(self)
	self:GetChild("ScreenSelectMusicUnderlayActorSongBackground"):finishtweening();
	if wheel and type == 'WheelItemDataType_Song' and song ~= nil then
		if song:HasBackground() == true then
			last_known_background = song:GetBackgroundPath();
			self:GetChild("ScreenSelectMusicUnderlayActorSongBackground"):Load(last_known_background);
		else
			local path = THEME:GetPathG("", "no_background");
			last_known_background=path;
			self:GetChild("ScreenSelectMusicUnderlayActorSongBackground"):Load(THEME:GetPathG("", "no_background"));
		end;
	else
		local path = THEME:GetPathG("", "no_background");
		last_known_background=path;
		self:GetChild("ScreenSelectMusicUnderlayActorSongBackground"):Load(THEME:GetPathG("", "no_background"));
	end;
end

function SongCDUpdate(self)
	self:GetChild("ScreenSelectMusicUnderlayActorSongCD"):finishtweening();
	if wheel and type == 'WheelItemDataType_Song' and song ~= nil then
		if song:HasCDImage() == true then
			cd_path = song:GetCDImagePath();
			self:GetChild("ScreenSelectMusicUnderlayActorSongCD"):Load(cd_path);
		else
			cd_path = THEME:GetPathG("", "no_cd");
			self:GetChild("ScreenSelectMusicUnderlayActorSongCD"):Load(cd_path);
		end;
	else
		cd_path = THEME:GetPathG("", "no_cd");
		self:GetChild("ScreenSelectMusicUnderlayActorSongCD"):Load(cd_path);
	end;
end

function SortUpdate(self)
	self:GetChild("ScreenSelectMusicUnderlayActorSort"):finishtweening();
	if sort ~= nil then
		self:GetChild("ScreenSelectMusicUnderlayActorSort"):Load(THEME:GetPathG("icon", sort));
	else
		self:Load(THEME:GetPathG("", "sort_icon_unknown"));
	end;
end

function SongDifficultyP1Update(self)
	self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyP1"):finishtweening();
	if wheel and type == 'WheelItemDataType_Song' and p1_steps ~= nil then
		if difficulty_p1_steps ~= nil then
			self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyP1"):Load(THEME:GetPathG("other", difficulty_p1_steps));
		else
			self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyP1"):Load(THEME:GetPathG("", "difficulty_unknown"));
		end;
	else
		self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyP1"):Load(THEME:GetPathG("", "difficulty_unknown"));
	end;
end

function SongDifficultyP2Update(self)
	self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyP2"):finishtweening();
	if wheel and type == 'WheelItemDataType_Song' and p2_steps ~= nil then
		if difficulty_p2_steps ~= nil then
			self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyP2"):Load(THEME:GetPathG("other", difficulty_p2_steps));
		else
			self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyP2"):Load(THEME:GetPathG("", "difficulty_unknown"));
		end;
	else
		self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyP2"):Load(THEME:GetPathG("", "difficulty_unknown"));
	end;
end

function SongMeterP1Update(self)
	self:GetChild("ScreenSelectMusicUnderlayActorSongMeterP1"):finishtweening();
	if wheel and type == 'WheelItemDataType_Song' and p1_steps ~= nil then
		-- Thanks Kyzentun
		local half_meter = 0;
		if p1_steps:GetMeter() ~= nil then
			-- wtf? stop showing an error...
			half_meter = clamp(math.round(p1_steps:GetMeter() / 2), 0, 10);
		end;
		self:GetChild("ScreenSelectMusicUnderlayActorSongMeterP1"):Load(THEME:GetPathG("", "meter_" .. half_meter .. "_display"));
	else
		self:GetChild("ScreenSelectMusicUnderlayActorSongMeterP1"):Load(THEME:GetPathG("", "meter_0"));
	end;
end

function SongMeterP2Update(self)
	self:GetChild("ScreenSelectMusicUnderlayActorSongMeterP2"):finishtweening();
	if wheel and type == 'WheelItemDataType_Song' and p2_steps ~= nil then
		-- Thanks Kyzentun
		local half_meter = 0;
		if p2_steps:GetMeter() ~= nil then
			-- wtf? stop showing an error...
			half_meter = clamp(math.round(p2_steps:GetMeter() / 2), 0, 10);
		end;
		self:GetChild("ScreenSelectMusicUnderlayActorSongMeterP2"):Load(THEME:GetPathG("", "meter_"..half_meter.."_display"));
	else
		self:GetChild("ScreenSelectMusicUnderlayActorSongMeterP2"):Load(THEME:GetPathG("", "meter_0"));
	end;
end

function WheelInfoUpdate(self)
	self:GetChild("ScreenSelectMusicUnderlayActorWheelInfo"):finishtweening();
	local length_result = "Normal";
	if wheel and type == 'WheelItemDataType_Song' and song ~= nil then
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
		self:GetChild("ScreenSelectMusicUnderlayActorWheelInfo"):settext(song:GetDisplayMainTitle() .. "\n" .. song:GetDisplaySubTitle() .. "\n" .. song:GetDisplayArtist() .. "\n" .. results_tempo .. " BPM" .. "\n" .. song:GetGenre() .. "\n" .. song:GetGroupName() .. "\n" .. length_result .. "\n" .. round(song:MusicLengthSeconds(),1) .. " Seconds" );
	end;
	if wheel and type == 'WheelItemDataType_Roulette' then
		self:GetChild("ScreenSelectMusicUnderlayActorWheelInfo"):settext("Random");
	end;
	if wheel and type == 'WheelItemDataType_Section' then
		self:GetChild("ScreenSelectMusicUnderlayActorWheelInfo"):settext(wheel:GetSelectedSection());
	end;
	self:GetChild("ScreenSelectMusicUnderlayActorWheelInfo"):scaletofit(SCREEN_LEFT+2, SCREEN_TOP+118, SCREEN_LEFT+256, SCREEN_TOP+242);
	self:GetChild("ScreenSelectMusicUnderlayActorWheelInfo"):diffuse(color(theme_color));
	self:GetChild("ScreenSelectMusicUnderlayActorWheelInfo"):align(0, 0.5);
	self:GetChild("ScreenSelectMusicUnderlayActorWheelInfo"):shadowlength(1);
end

function SongDifficultyTextP1Update(self)
	self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyTextP1"):finishtweening();
	if wheel and type == 'WheelItemDataType_Song' then
		p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
		local stdifficulty = "Unknown";
		if p1_steps ~= nil then
			local difficultysteps = p1_steps:GetDifficulty();
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
				stdifficulty = "Edit";
			else
				stdifficulty = "Unknown";
			end;
			self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyTextP1"):settext("" .. stdifficulty .. " " .. tostring(p1_steps:GetMeter()) );
		end;
	else
		self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyTextP1"):settext(" ");
	end;
	self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyTextP1"):diffuse(color("1,0.25,0,1"));
end

function SongDifficultyTextP2Update(self)
	self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyTextP2"):finishtweening();
	if wheel and type == 'WheelItemDataType_Song' then
		p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
		local stdifficulty = "Unknown";
		if p2_steps ~= nil then
			local difficultysteps = p2_steps:GetDifficulty();
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
				stdifficulty = "Edit";
			else
				stdifficulty = "Unknown";
			end;
			self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyTextP2"):settext("" .. stdifficulty .. " " .. tostring(p2_steps:GetMeter()) );
		end;
	else
		self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyTextP2"):settext(" ");
	end;
	self:GetChild("ScreenSelectMusicUnderlayActorSongDifficultyTextP2"):diffuse(color("0,0.5,1,1"));
end

function StepTableP1Update(self)
	self:GetChild("ScreenSelectMusicUnderlayActorStepTableP1"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorStepTableP1"):settext("TAPS: " .. tostring(steps_p1_table[1]) .. "\n" .. "JUMPS: " .. tostring(steps_p1_table[2]) .. "\n" .. "HOLDS: " .. tostring(steps_p1_table[3]) .. "\n" .. "MINES: " .. tostring(steps_p1_table[4]) .. "\n" .. "HANDS: " .. tostring(steps_p1_table[5]) .. "\n" .. "ROLLS: " .. tostring(steps_p1_table[6]) .. "\n" .. "LIFTS: " .. tostring(steps_p1_table[7]) .. "\n" .. "FAKES: " .. tostring(steps_p1_table[8]) .. "\n" .. "TOTAL: " .. tostring(steps_p1_table[9]));
	self:GetChild("ScreenSelectMusicUnderlayActorStepTableP1"):diffuse(color("1,0.25,0,1"));
end

function StepTableP2Update(self)
	self:GetChild("ScreenSelectMusicUnderlayActorStepTableP2"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorStepTableP2"):settext("TAPS: " .. tostring(steps_p2_table[1]) .. "\n" .. "JUMPS: " .. tostring(steps_p2_table[2]) .. "\n" .. "HOLDS: " .. tostring(steps_p2_table[3]) .. "\n" .. "MINES: " .. tostring(steps_p2_table[4]) .. "\n" .. "HANDS: " .. tostring(steps_p2_table[5]) .. "\n" .. "ROLLS: " .. tostring(steps_p2_table[6]) .. "\n" .. "LIFTS: " .. tostring(steps_p2_table[7]) .. "\n" .. "FAKES: " .. tostring(steps_p2_table[8]) .. "\n" .. "TOTAL: " .. tostring(steps_p2_table[9]));
	self:GetChild("ScreenSelectMusicUnderlayActorStepTableP2"):diffuse(color("0,0.5,1,1"));
end

function HighscoreTableP1Update(self)
	self:GetChild("ScreenSelectMusicUnderlayActorHighscoreTableP1"):finishtweening();
	if wheel and type == 'WheelItemDataType_Song' then
		p1_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P1');
		if p1_steps ~= nil then
			local profile = GetPlayerOrMachineProfile('PlayerNumber_P1');
			local highscore_list = profile:GetHighScoreListIfExists(song, p1_steps);
			local highscore = highscore_list:GetHighScores();
			if highscore ~= nil and highscore[1] ~= nil then
				local highest_grade = highscore[1]:GetGrade();
				local string_grade = "AAAA";
				if highest_grade == 'Grade_Tier01' then
					string_grade = "AAAA";
				elseif highest_grade == 'Grade_Tier02' then
					string_grade = "AAA";
				elseif highest_grade == 'Grade_Tier03' then
					string_grade = "AA";
				elseif highest_grade == 'Grade_Tier04' then
					string_grade = "A";
				elseif highest_grade == 'Grade_Tier05' then
					string_grade = "B";
				elseif highest_grade == 'Grade_Tier06' then
					string_grade = "C";
				elseif highest_grade == 'Grade_Tier07' then
					string_grade = "D";
				elseif highest_grade == 'Grade_Failed' then
					string_grade = "F";
				else
					string_grade = "ERROR";
				end;
				local highest_score = highscore[1]:GetScore();
				local highest_percent = round(highscore[1]:GetPercentDP() * 100, 2);
				local highest_maxcombo = highscore[1]:GetMaxCombo();
				local highest_datetime = highscore[1]:GetDate();
				self:GetChild("ScreenSelectMusicUnderlayActorHighscoreTableP1"):settext("Grade: " .. tostring(string_grade) .. "\nPercent: " .. tostring(highest_percent) .. "%\nScore: " .. tostring(highest_score) .. "\nMax Combo: " .. tostring(highest_maxcombo) .. "\nDate/Time: " .. tostring(highest_datetime) );
			else
				self:GetChild("ScreenSelectMusicUnderlayActorHighscoreTableP1"):settext("Grade: - " ..  "\nPercent: - " .. "\nScore: - " .. "\nMax Combo: - " .. "\nDate/Time: - ");
			end;
		else
			self:GetChild("ScreenSelectMusicUnderlayActorHighscoreTableP1"):settext("Grade: - " ..  "\nPercent: - " .. "\nScore: - " .. "\nMax Combo: - " .. "\nDate/Time: - ");
		end;
	else
		self:GetChild("ScreenSelectMusicUnderlayActorHighscoreTableP1"):settext("Grade: - " ..  "\nPercent: - " .. "\nScore: - " .. "\nMax Combo: - " .. "\nDate/Time: - ");
	end;
	self:GetChild("ScreenSelectMusicUnderlayActorHighscoreTableP1"):diffuse(color("1,0.25,0,1"));
end

function HighscoreTableP2Update(self)
	self:GetChild("ScreenSelectMusicUnderlayActorHighscoreTableP2"):finishtweening();
	if wheel and type == 'WheelItemDataType_Song' then
		p2_steps = GAMESTATE:GetCurrentSteps('PlayerNumber_P2');
		if p2_steps ~= nil then
			local profile = GetPlayerOrMachineProfile('PlayerNumber_P2');
			local highscore_list = profile:GetHighScoreListIfExists(song, p2_steps);
			local highscore = highscore_list:GetHighScores();
			if highscore ~= nil and highscore[1] ~= nil then
				local highest_grade = highscore[1]:GetGrade();
				local string_grade = "AAAA";
				if highest_grade == 'Grade_Tier01' then
					string_grade = "AAAA";
				elseif highest_grade == 'Grade_Tier02' then
					string_grade = "AAA";
				elseif highest_grade == 'Grade_Tier03' then
					string_grade = "AA";
				elseif highest_grade == 'Grade_Tier04' then
					string_grade = "A";
				elseif highest_grade == 'Grade_Tier05' then
					string_grade = "B";
				elseif highest_grade == 'Grade_Tier06' then
					string_grade = "C";
				elseif highest_grade == 'Grade_Tier07' then
					string_grade = "D";
				elseif highest_grade == 'Grade_Failed' then
					string_grade = "F";
				else
					string_grade = "ERROR";
				end;
				local highest_score = highscore[1]:GetScore();
				local highest_percent = round(highscore[1]:GetPercentDP() * 100, 2);
				local highest_maxcombo = highscore[1]:GetMaxCombo();
				local highest_datetime = highscore[1]:GetDate();
				self:GetChild("ScreenSelectMusicUnderlayActorHighscoreTableP2"):settext("Grade: " .. tostring(string_grade) .. "\nPercent: " .. tostring(highest_percent) .. "%\nScore: " .. tostring(highest_score) .. "\nMax Combo: " .. tostring(highest_maxcombo) .. "\nDate/Time: " .. tostring(highest_datetime) );
			else
				self:GetChild("ScreenSelectMusicUnderlayActorHighscoreTableP2"):settext("Grade: - " ..  "\nPercent: - " .. "\nScore: - " .. "\nMax Combo: - " .. "\nDate/Time: - ");
			end;
		else
			self:GetChild("ScreenSelectMusicUnderlayActorHighscoreTableP2"):settext("Grade: - " ..  "\nPercent: - " .. "\nScore: - " .. "\nMax Combo: - " .. "\nDate/Time: - ");
		end;
	else
		self:GetChild("ScreenSelectMusicUnderlayActorHighscoreTableP2"):settext("Grade: - " ..  "\nPercent: - " .. "\nScore: - " .. "\nMax Combo: - " .. "\nDate/Time: - ");
	end;
	self:GetChild("ScreenSelectMusicUnderlayActorHighscoreTableP2"):diffuse(color("0,0.5,1,1"));
end

function RadarStuffP1Update(self)
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Taps"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Jumps"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Holds"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Mines"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Hands"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Rolls"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Lifts"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Fakes"):finishtweening();
	if wheel and type == 'WheelItemDataType_Song' then
		p1_percentage_taps = (steps_p1_table[1] / steps_p1_table[9])*100;
		p1_percentage_jumps = (steps_p1_table[2] / steps_p1_table[9])*100;
		p1_percentage_holds = (steps_p1_table[3] / steps_p1_table[9])*100;
		p1_percentage_mines = (steps_p1_table[4] / steps_p1_table[9])*100;
		p1_percentage_hands = (steps_p1_table[5] / steps_p1_table[9])*100;
		p1_percentage_rolls = (steps_p1_table[6] / steps_p1_table[9])*100;
		p1_percentage_lifts = (steps_p1_table[7] / steps_p1_table[9])*100;
		p1_percentage_fakes = (steps_p1_table[8] / steps_p1_table[9])*100;
	else
		p1_percentage_taps = 1;
		p1_percentage_jumps = 1;
		p1_percentage_holds = 1;
		p1_percentage_mines = 1;
		p1_percentage_hands = 1;
		p1_percentage_rolls = 1;
		p1_percentage_lifts = 1;
		p1_percentage_fakes = 1;
	end;
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Taps"):stretchto(SCREEN_LEFT+15,SCREEN_TOP+386,SCREEN_LEFT+15+p1_percentage_taps,SCREEN_TOP+390);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Taps"):diffuse(color("1,0.25,0,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Jumps"):stretchto(SCREEN_LEFT+15,SCREEN_TOP+393,SCREEN_LEFT+15+p1_percentage_jumps,SCREEN_TOP+397);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Jumps"):diffuse(color("1,0.25,0,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Holds"):stretchto(SCREEN_LEFT+15,SCREEN_TOP+400,SCREEN_LEFT+15+p1_percentage_holds,SCREEN_TOP+404);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Holds"):diffuse(color("1,0.25,0,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Mines"):stretchto(SCREEN_LEFT+15,SCREEN_TOP+407,SCREEN_LEFT+15+p1_percentage_mines,SCREEN_TOP+411);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Mines"):diffuse(color("1,0.25,0,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Hands"):stretchto(SCREEN_LEFT+15,SCREEN_TOP+414,SCREEN_LEFT+15+p1_percentage_hands,SCREEN_TOP+418);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Hands"):diffuse(color("1,0.25,0,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Rolls"):stretchto(SCREEN_LEFT+15,SCREEN_TOP+421,SCREEN_LEFT+15+p1_percentage_rolls,SCREEN_TOP+425);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Rolls"):diffuse(color("1,0.25,0,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Lifts"):stretchto(SCREEN_LEFT+15,SCREEN_TOP+428,SCREEN_LEFT+15+p1_percentage_lifts,SCREEN_TOP+432);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Lifts"):diffuse(color("1,0.25,0,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Fakes"):stretchto(SCREEN_LEFT+15,SCREEN_TOP+434,SCREEN_LEFT+15+p1_percentage_fakes,SCREEN_TOP+438);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP1Fakes"):diffuse(color("1,0.25,0,1"));
end

function RadarStuffP2Update(self)
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Taps"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Jumps"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Holds"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Mines"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Hands"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Rolls"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Lifts"):finishtweening();
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Fakes"):finishtweening();
	if wheel and type == 'WheelItemDataType_Song' then
		p2_percentage_taps = (steps_p2_table[1] / steps_p2_table[9])*100;
		p2_percentage_jumps = (steps_p2_table[2] / steps_p2_table[9])*100;
		p2_percentage_holds = (steps_p2_table[3] / steps_p2_table[9])*100;
		p2_percentage_mines = (steps_p2_table[4] / steps_p2_table[9])*100;
		p2_percentage_hands = (steps_p2_table[5] / steps_p2_table[9])*100;
		p2_percentage_rolls = (steps_p2_table[6] / steps_p2_table[9])*100;
		p2_percentage_lifts = (steps_p2_table[7] / steps_p2_table[9])*100;
		p2_percentage_fakes = (steps_p2_table[8] / steps_p2_table[9])*100;
	else
		p2_percentage_taps = 1;
		p2_percentage_jumps = 1;
		p2_percentage_holds = 1;
		p2_percentage_mines = 1;
		p2_percentage_hands = 1;
		p2_percentage_rolls = 1;
		p2_percentage_lifts = 1;
		p2_percentage_fakes = 1;
	end;
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Taps"):stretchto(SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+143+p2_percentage_taps,SCREEN_TOP+390);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Taps"):diffuse(color("0,0.5,1,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Jumps"):stretchto(SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+143+p2_percentage_jumps,SCREEN_TOP+397);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Jumps"):diffuse(color("0,0.5,1,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Holds"):stretchto(SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+143+p2_percentage_holds,SCREEN_TOP+404);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Holds"):diffuse(color("0,0.5,1,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Mines"):stretchto(SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+143+p2_percentage_mines,SCREEN_TOP+411);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Mines"):diffuse(color("0,0.5,1,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Hands"):stretchto(SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+143+p2_percentage_hands,SCREEN_TOP+418);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Hands"):diffuse(color("0,0.5,1,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Rolls"):stretchto(SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+143+p2_percentage_rolls,SCREEN_TOP+425);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Rolls"):diffuse(color("0,0.5,1,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Lifts"):stretchto(SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+143+p2_percentage_lifts,SCREEN_TOP+432);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Lifts"):diffuse(color("0,0.5,1,1"));
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Fakes"):stretchto(SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+143+p2_percentage_fakes,SCREEN_TOP+438);
	self:GetChild("ScreenSelectMusicUnderlayActorRadarStuffP2Fakes"):diffuse(color("0,0.5,1,1"));
end

--	-- Actor (P2 Taps)
--	InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+143,SCREEN_TOP+390;diffuse,color("0,0.5,1,1"));
--	-- Actor (P2 Jumps)
--	InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+143,SCREEN_TOP+397;diffuse,color("0,0.5,1,1"));
--	-- Actor (P2 Holds)
--	InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+143,SCREEN_TOP+404;diffuse,color("0,0.5,1,1"));
--	-- Actor (P2 Mines)
--	InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+143,SCREEN_TOP+411;diffuse,color("0,0.5,1,1"));
--	-- Actor (P2 Hands)
--	InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+143,SCREEN_TOP+418;diffuse,color("0,0.5,1,1"));
--	-- Actor (P2 Rolls)
--	InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+143,SCREEN_TOP+425;diffuse,color("0,0.5,1,1"));
--	-- Actor (P2 Lifts)
--	InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+143,SCREEN_TOP+432;diffuse,color("0,0.5,1,1"));
--	-- Actor (P2 Fakes)
--	InitCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+143,SCREEN_TOP+438;diffuse,color("0,0.5,1,1"));

-- common/simple actors (ActorFrame 1)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameCommon";
	-- Function (scripts)
	common_text("Select Music"),
	-- Actor (Radar Background)
	Def.Sprite{
		OnCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+417;scaletoclipped,256,70;Load,THEME:GetPathG("", "radar_values"));
	}
};

-- P1/P2 Wheel Related Stuff Actor (ActorFrame 2)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameWheelStuff";
	InitCommand=function(self)
		self:SetUpdateFunction(WheelStuffUpdate);
		self:SetUpdateRate(0.001);
	end;
};

-- Song Banner Actor (ActorFrame 3)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameSongBanner";
	InitCommand=function(self)
		self:SetUpdateFunction(SongBannerUpdate);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Song Banner)
	Def.Banner{
		Name="ScreenSelectMusicUnderlayActorSongBanner";
		OnCommand=cmd(x,SCREEN_LEFT+130;y,SCREEN_TOP+70;scaletoclipped,256,80;Load,THEME:GetPathG("", "no_banner"));
	}
};

-- Song Background Actor (ActorFrame 4)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameSongBackground";
	InitCommand=function(self)
		self:SetUpdateFunction(SongBackgroundUpdate);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Song Background)
	Def.Sprite{
		Name="ScreenSelectMusicUnderlayActorSongBackground";
		OnCommand=cmd(x,SCREEN_LEFT+556;y,SCREEN_TOP+240;scaletoclipped,592,420;Load,THEME:GetPathG("", "no_background"));
	}
};

-- Song CD Actor (ActorFrame 5)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameSongCD";
	InitCommand=function(self)
		self:SetUpdateFunction(SongCDUpdate);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Song CD)
	Def.Sprite{
		Name="ScreenSelectMusicUnderlayActorSongCD";
		OnCommand=cmd(x,SCREEN_RIGHT-44;y,SCREEN_TOP+72;scaletoclipped,80,80;Load,THEME:GetPathG("", "no_cd"));
	}
};

-- Song Sort Actor (ActorFrame 6)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameSort";
	InitCommand=function(self)
		self:SetUpdateFunction(SortUpdate);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Sort Icon)
	Def.Sprite{
		Name="ScreenSelectMusicUnderlayActorSort";
		OnCommand=cmd(x,SCREEN_RIGHT-26;y,SCREEN_TOP+15;scaletoclipped,50,28;Load,THEME:GetPathG("", "sort_icon_unknown"));
	}
};

-- Song Difficulty P1 Actor (ActorFrame 7)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameSongDifficultyP1";
	InitCommand=function(self)
		self:SetUpdateFunction(SongDifficultyP1Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Song Difficulty P1)
	Def.Sprite{
		Name="ScreenSelectMusicUnderlayActorSongDifficultyP1";
		OnCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+286;scaletoclipped,64,64;Load,THEME:GetPathG("", "difficulty_unknown"));
	}
};

-- Song Difficulty P2 Actor (ActorFrame 8)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameSongDifficultyP2";
	InitCommand=function(self)
		self:SetUpdateFunction(SongDifficultyP2Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Song Difficulty P2)
	Def.Sprite{
		Name="ScreenSelectMusicUnderlayActorSongDifficultyP2";
		OnCommand=cmd(x,SCREEN_LEFT+34;y,SCREEN_TOP+350;scaletoclipped,64,64;Load,THEME:GetPathG("", "difficulty_unknown"));
	}
};

-- Song Meter P1 Actor (ActorFrame 9)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameSongDifficultyP1";
	InitCommand=function(self)
		self:SetUpdateFunction(SongMeterP1Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Song Meter P1)
	Def.Sprite{
		Name="ScreenSelectMusicUnderlayActorSongMeterP1";
		OnCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+286;scaletoclipped,192,64;Load,THEME:GetPathG("", "meter_0"));
	}
};

-- Song Meter P2 Actor (ActorFrame 10)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameSongDifficultyP2";
	InitCommand=function(self)
		self:SetUpdateFunction(SongMeterP2Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Song Meter P2)
	Def.Sprite{
		Name="ScreenSelectMusicUnderlayActorSongMeterP2";
		OnCommand=cmd(x,SCREEN_LEFT+162;y,SCREEN_TOP+350;scaletoclipped,192,64;Load,THEME:GetPathG("", "meter_0"));
	}
};

-- Wheel Information Actor (ActorFrame 11)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameWheelInfo";
	InitCommand=function(self)
		self:SetUpdateFunction(WheelInfoUpdate);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Song/Group/Sort/etc. Information)
	LoadFont("Common","normal")..{
		Text="N/A";
		Name="ScreenSelectMusicUnderlayActorWheelInfo";
		OnCommand=cmd(scaletofit,SCREEN_LEFT+2,SCREEN_TOP+118,SCREEN_LEFT+256,SCREEN_TOP+242;diffuse,color(theme_color);align,0,0.5;shadowlength,1);
	}
};

-- Song Difficulty Text P1 Actor (ActorFrame 12)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameSongDifficultyTextP1";
	InitCommand=function(self)
		self:SetUpdateFunction(SongDifficultyTextP1Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Song Difficulty P1 Text)
	LoadFont("Common","normal")..{
		Name="ScreenSelectMusicUnderlayActorSongDifficultyTextP1";
		Text="N/A";
		OnCommand=cmd(x,SCREEN_LEFT+72;y,SCREEN_TOP+300;diffuse,color(theme_color);align,0,0.5;shadowlength,1);
	}
};

-- Song Difficulty Text P2 Actor (ActorFrame 13)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameSongDifficultyTextP2";
	InitCommand=function(self)
		self:SetUpdateFunction(SongDifficultyTextP2Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (Song Difficulty P2 Text)
	LoadFont("Common","normal")..{
		Name="ScreenSelectMusicUnderlayActorSongDifficultyTextP2";
		Text="N/A";
		OnCommand=cmd(x,SCREEN_LEFT+72;y,SCREEN_TOP+365;diffuse,color(theme_color);align,0,0.5;shadowlength,1);
	}
};

-- Highscore/NPS Quad Actor (ActorFrame 14)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameHighscoreNPSQuads";
	-- Actor (Step Table Quad)
	Def.Quad{
		OnCommand=cmd(stretchto,SCREEN_LEFT+260,SCREEN_TOP+30,SCREEN_LEFT+650,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	},
	-- Actor (NPS Quad)
	Def.Quad{
		OnCommand=cmd(stretchto,SCREEN_RIGHT-196,SCREEN_BOTTOM-96,SCREEN_RIGHT-3,SCREEN_BOTTOM-30;diffuse,color("0,0,0,0.5"));
	}
};

-- Step Table P1 Actor (ActorFrame 15)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameStepTableP1";
	InitCommand=function(self)
		self:SetUpdateFunction(StepTableP1Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (P1 Step Table)
	LoadFont("Common","normal")..{
		Name="ScreenSelectMusicUnderlayActorStepTableP1";
		Text="Step Table P1";
		OnCommand=cmd(x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y-128;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
	}
};

-- Step Table P2 Actor (ActorFrame 16)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameStepTableP2";
	InitCommand=function(self)
		self:SetUpdateFunction(StepTableP2Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (P2 Step Table)
	LoadFont("Common","normal")..{
		Name="ScreenSelectMusicUnderlayActorStepTableP2";
		Text="Step Table P2";
		OnCommand=cmd(x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y+128;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
	}
};

-- Highscore Table P1 Actor (ActorFrame 17)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameHighscoreTableP1";
	InitCommand=function(self)
		self:SetUpdateFunction(HighscoreTableP1Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (P1 Highscore Table)
	LoadFont("Common","normal")..{
		Name="ScreenSelectMusicUnderlayActorHighscoreTableP1";
		Text="P1 Highscore Table";
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-128;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
	}
};

-- Highscore Table P2 Actor (ActorFrame 18)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameHighscoreTableP2";
	InitCommand=function(self)
		self:SetUpdateFunction(HighscoreTableP2Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (P2 Highscore Table)
	LoadFont("Common","normal")..{
		Name="ScreenSelectMusicUnderlayActorHighscoreTableP2";
		Text="P2 Highscore Table";
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+128;diffuse,color(theme_color);align,0,0.5;shadowlength,1;zoom,0.5);
	}
};

-- NPS Text Actor (ActorFrame 19)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameNPSText";
	-- Actor (NPS Text)
	LoadFont("Common","normal")..{
		Name="ScreenSelectMusicUnderlayActorHighscoreTableP2";
		Text="P2 Highscore Table";
		InitCommand=cmd();
		OnCommand=function(self)
			self:x(SCREEN_CENTER_X+234);
			self:y(SCREEN_CENTER_Y+170);
			self:diffuse(color(theme_color));
			self:align(0, 0.5);
			self:shadowlength(1);
			self:zoom(0.5);
			self:settext("Last Song NPS Stats:\nAverage NPS: " .. tostring(average_p1) .. "\nPeak NPS: " .. tostring(peak_p1) );
		end;
	}
};

-- Radar P1 Stuff Actor (ActorFrame 20)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameRadarStuffP1";
	InitCommand=function(self)
		self:SetUpdateFunction(RadarStuffP1Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (P1 Taps)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP1Taps";
		OnCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+386,SCREEN_LEFT+15,SCREEN_TOP+390;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P1 Jumps)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP1Jumps";
		OnCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+393,SCREEN_LEFT+15,SCREEN_TOP+397;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P1 Holds)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP1Holds";
		OnCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+400,SCREEN_LEFT+15,SCREEN_TOP+404;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P1 Mines)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP1Mines";
		OnCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+407,SCREEN_LEFT+15,SCREEN_TOP+411;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P1 Hands)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP1Hands";
		OnCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+414,SCREEN_LEFT+15,SCREEN_TOP+418;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P1 Rolls)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP1Rolls";
		OnCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+421,SCREEN_LEFT+15,SCREEN_TOP+425;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P1 Lifts)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP1Lifts";
		OnCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+428,SCREEN_LEFT+15,SCREEN_TOP+432;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P1 Fakes)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP1Fakes";
		OnCommand=cmd(stretchto,SCREEN_LEFT+15,SCREEN_TOP+434,SCREEN_LEFT+15,SCREEN_TOP+438;diffuse,color("1,0.25,0,1"));
	}
};

-- Radar P2 Stuff Actor (ActorFrame 21)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameRadarStuffP2";
	InitCommand=function(self)
		self:SetUpdateFunction(RadarStuffP2Update);
		self:SetUpdateRate(0.001);
	end;
	-- Actor (P2 Taps)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP2Taps";
		OnCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+386,SCREEN_LEFT+143,SCREEN_TOP+390;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P2 Jumps)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP2Jumps";
		OnCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+393,SCREEN_LEFT+143,SCREEN_TOP+397;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P2 Holds)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP2Holds";
		OnCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+400,SCREEN_LEFT+143,SCREEN_TOP+404;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P2 Mines)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP2Mines";
		OnCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+407,SCREEN_LEFT+143,SCREEN_TOP+411;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P2 Hands)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP2Hands";
		OnCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+414,SCREEN_LEFT+143,SCREEN_TOP+418;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P2 Rolls)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP2Rolls";
		OnCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+421,SCREEN_LEFT+143,SCREEN_TOP+425;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P2 Lifts)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP2Lifts";
		OnCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+428,SCREEN_LEFT+143,SCREEN_TOP+432;diffuse,color("1,0.25,0,1"));
	},
	-- Actor (P2 Fakes)
	Def.Quad{
		Name="ScreenSelectMusicUnderlayActorRadarStuffP2Fakes";
		OnCommand=cmd(stretchto,SCREEN_LEFT+143,SCREEN_TOP+434,SCREEN_LEFT+143,SCREEN_TOP+438;diffuse,color("1,0.25,0,1"));
	}
};

-- WIP (MOVE STUFF)

-- Skin Actor (ActorFrame X)

t[#t+1] = Def.ActorFrame{
	Name="ScreenSelectMusicUnderlayActorFrameSkin";
	-- Actor/Function (scripts)
	theme_skin("theme_skin"),
	-- Actor/Function (scripts)
	theme_skin("music_theme_skin")
};

return t;