/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 5;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;    /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char dmenufont[] = "Iosevka:size=10";
static const char *fonts[] = {"Iosevka:style:medium:size=10", "JetBrainsMono Nerd Font:style:medium:size=10", "Material Design Icons Desktop:size=9"};
static const char col_gray1[] = "#222222"; // backgroud colour normally seen
static const char col_gray2[] = "#E8B082"; // border for unfocused window
static const char col_gray3[] = "#fff";    // font color ;normal
static const char col_gray4[] = "#000000"; // font color when focused on a window
// static const char col_cyan[] = "#E8B082";  // border color when the window is focused
// static const char col_cyan[] = "#83bae8";  // border color when the window is focused
static const char col_active[] = "#83bae8";
static const char col_cyan[] = "#ABE9B3";  // border color when the window is focused
                                           //this is the default color #83bae8

static const char *colors[][3] = {
    /*               fg         bg         border   */
    [SchemeNorm] = {col_gray3, col_gray1,   col_gray2},
    [SchemeSel] =  {col_gray4, col_cyan,    col_active},
    [SchemeHid] =  {col_cyan,  col_gray1,   col_cyan},
};

/* tagging */
static const char *tags[] = {"", "", "" ,"", "5", "", " ", "8", "9"};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
   {"LibreWolf",    NULL,       NULL,       1 <<1 ,       0,           -1},
   {"Brave-browser",    NULL,       NULL,       1 <<1 ,       0,           -1},
   {"Signal",       NULL,       NULL,       1 <<3  ,      0,           -1 },
   {"discord",      NULL,       NULL,       1 <<5  ,      0,           -1 },
   {"thunderbird",  NULL,       NULL,       1 <<6  ,      0,           -1 },
   {"Nitrogen",        NULL,       NULL,       0,                1,        -1},
   {"Pavucontrol",        NULL,       NULL,       0,                1,        -1},
   {"Gscreenshot",     NULL,       NULL,       0,                1,        -1},
   {"TelegramDesktop", NULL,       NULL,       1 << 3,           0,        -1},
   {"Element", NULL,       NULL,       1 << 3,           0,        -1},

};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

#include "fibonacci.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
 	{ "[@]",      spiral },
 	{ "[\\]",      dwindle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define printsc 0xff61
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-fn", dmenufont, "-nb",
col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };

static const Key keys[] = {
  // custom keybindings start {start}
  {0, XF86XK_AudioRaiseVolume,  spawn, SHCMD("~/.scripts/volumenotifier up")},
  {0, XF86XK_AudioLowerVolume,  spawn, SHCMD("~/.scripts/volumenotifier down")},
  {0, XF86XK_AudioMute,         spawn, SHCMD("~/.scripts/volumenotifier mute")},
  {0, XF86XK_RFKill,            spawn, SHCMD("rfkill toggle all")},
  {0, XF86XK_AudioPlay,         spawn, SHCMD("mpc toggle")},
  {0, XF86XK_AudioPrev,         spawn, SHCMD("mpc prev")},
  {0, XF86XK_AudioNext,         spawn, SHCMD("mpc next")},
  {0, printsc,                  spawn, SHCMD("gscreenshot")}, //to take screenshot
  {MODKEY, printsc,                  spawn, SHCMD("flameshot gui")}, //to take screenshot
  {MODKEY | ShiftMask, XK_p, spawn, SHCMD("~/.scripts/power_menu")},
  {ALTKEY, 0xff52, spawn, SHCMD("~/.scripts/bright_notif up")},
  {ALTKEY, 0xff54, spawn, SHCMD("~/.scripts/bright_notif down")},
  {MODKEY, XK_n,   spawn, SHCMD("nemo")},
  {ALTKEY, XK_f,   spawn, SHCMD("librewolf")},
  {ALTKEY, XK_t,   spawn, SHCMD("telegram-desktop")},
  {ALTKEY, XK_b,   spawn, SHCMD("firefox")},
  {ALTKEY, XK_m,   spawn, SHCMD("st ncmpcpp")},
  {ALTKEY, XK_s,   spawn, SHCMD("st ranger ~/school")},
  {ALTKEY, XK_p,   spawn, SHCMD("librewolf --private-window --new-tab")},
  {ALTKEY, XK_n,   spawn, SHCMD("brave")}, // to Launch brave browser
  {MODKEY, XK_d, spawn, SHCMD("rofi -show drun")},
  {MODKEY, XK_c, spawn, SHCMD("rofi -show calc -modi calc -no-show-match -no-sort")},
  {MODKEY, XK_e, spawn, SHCMD("rofi -show emoji")},
  // custom keybindings start {end}

	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_k,      focusstackvis,  {.i = +1 } },
	{ MODKEY,                       XK_j,      focusstackvis,  {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_k,      focusstackhid,  {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_j,      focusstackhid,  {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY | ShiftMask,           XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY | ShiftMask,           XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_r,      setlayout,      {.v = &layouts[5]} },
	{ MODKEY|ShiftMask,             XK_r,      setlayout,      {.v = &layouts[6]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },
	{ MODKEY,                       XK_s,      show,           {0} },
	{ MODKEY|ShiftMask,             XK_s,      showall,        {0} },
	{ MODKEY|ShiftMask,             XK_h,      hide,           {0} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkWinTitle,          0,              Button1,        togglewin,           {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

