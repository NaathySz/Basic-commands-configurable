#include <sourcemod>
#include <sdktools>
#include <multicolors>

#pragma semicolon 1
#pragma newdecls required

ConVar BC_WelcomeMessage;

#define PLUGIN_VERSION "1.0"

public Plugin myinfo = 
{
	name = "Basic Commands",
	author = "Nathy",
	description = "basic commands about server",
	version = PLUGIN_VERSION,
	url = "https://steamcommunity.com/id/nathyzinhaa"
};

public void OnPluginStart()
{
	BC_WelcomeMessage = CreateConVar("sm_basiccmds_welcome", "1", "Enable/Disable welcome message");
	
	RegConsoleCmd("sm_discord", Command_discord);
	RegConsoleCmd("sm_site", Command_site);
	RegConsoleCmd("sm_website", Command_site);
	RegConsoleCmd("sm_group", Command_group);
	RegConsoleCmd("sm_steam", Command_group);
	RegConsoleCmd("sm_steamgroup", Command_group);
	RegConsoleCmd("sm_owner", Command_owner);
	RegConsoleCmd("sm_ip", Command_ip);
	RegConsoleCmd("sm_serverip", Command_ip);
	
	AutoExecConfig(true, "Basic_commands");
	LoadTranslations("Basic_commands");
}

stock bool IsClientValid(int client = -1, bool bAlive = false) 
{
	return MaxClients >= client > 0 && IsClientConnected(client) && !IsFakeClient(client) && IsClientInGame(client) && (!bAlive || IsPlayerAlive(client)) ? true : false;
}

public void OnClientPutInServer(int client)
{
	if(GetConVarInt(BC_WelcomeMessage) == 1)
	{
		CreateTimer(7.0, msg, client);
	}
}

public Action msg(Handle timer, any client)
{
	if(IsClientValid(client))
		CPrintToChat(client, "%t", "Welcome Message");
	
	return Plugin_Handled;
}

public Action Command_discord(int client, int args){
	CPrintToChat(client, "%t", "Discord link");
}

public Action Command_site(int client, int args){
	CPrintToChat(client, "%t", "Website link");
}

public Action Command_group(int client, int args){
	CPrintToChat(client, "%t", "Steam Group link");
}

public Action Command_owner(int client, int args){
	CPrintToChat(client, "%t", "Owner Profile link");
}

public Action Command_ip(int client, int args){
	CPrintToChat(client, "%t", "Server ip");
}