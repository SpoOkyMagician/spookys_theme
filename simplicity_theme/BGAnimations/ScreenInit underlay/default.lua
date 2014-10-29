-- ScreenInit underlay

local t = Def.ActorFrame{
	-- grab the preference set in theme color picker
	LoadFont("SpoOky")..{
		Text="";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:queuecommand('ColorPicked');
		end;
		ColorPickedCommand=function(self)
			local pref = GetThemePref("ColorPref");
			if pref == 1 then
				-- Original Gold - Primary Theme Color
				theme_color="1,0.9,0,1";
				theme_dark_color="0.5,0.4,0,1";
				theme_background="0,0,0,1";
			elseif pref == 2 then
				-- Red (Common)
				theme_color="1,0,0,1";
				theme_dark_color="0.5,0,0,1";
				theme_background="0,0,0,1";
			elseif pref == 3 then
				-- Green (Common)
				theme_color="0,1,0,1";
				theme_dark_color="0,0.5,0,1";
				theme_background="0,0,0,1";
			elseif pref == 4 then
				-- Blue (Common)
				theme_color="0,0,1,1";
				theme_dark_color="0,0,0.5,1";
				theme_background="0,0,0,1";
			elseif pref == 5 then
				-- Yellow (MIX)
				theme_color="1,1,0,1";
				theme_dark_color="0.5,0.5,0,1";
				theme_background="0,0,0,1";
			elseif pref == 6 then
				-- Teal (MIX)
				theme_color="0,1,1,1";
				theme_dark_color="0,0.5,0.5,1";
				theme_background="0,0,0,1";
			elseif pref == 7 then
				-- Purple (MIX)
				theme_color="1,0,1,1";
				theme_dark_color="0.5,0,0.5,1";
				theme_background="0,0,0,1";
			else
				-- Original Gold - Primary Theme Color
				theme_color="1,0.9,0,1";
				theme_dark_color="0.5,0.4,0,1";
				theme_background="0,0,0,1";
			end
		end;
	},
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
	-- GLOBAL screen text
	common_text("Initiating Screen"),
	-- new theme skin i am experimenting with...
	LoadActor(THEME:GetPathG("","theme_skin"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	}
};

return t;