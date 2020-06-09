params ["_victim", "_instigator"];

private _realVictimSide = _victim call BIS_fnc_objectSide;
if ([side _instigator, _realVictimSide] call BIS_fnc_sideIsEnemy) exitWith {};

private _instigatorName = name _instigator;
private _victimName = name _victim;

if (isNil "YERAY_playerTeamKills") then { YERAY_playerTeamKills = 0; };
YERAY_playerTeamKills = YERAY_playerTeamKills + 1;
if (YERAY_playerTeamKills == 4) then { YERAY_playerTeamKills = 1};

switch (YERAY_playerTeamKills) do
{
    default:
    {
        hint "Has matado a un aliado. \nEste es tu primer aviso.";
        format ["[FUEGO AMIGO] %1 ha matado a %2, este es su primer aviso.", _instigatorName, _victimName] remoteExec ["systemChat"];
    };
    case 2:
    {
        _instigator setDamage 1;
        hint "Has matado a un aliado. \nEste es tu segundo y último aviso.";
        format ["[FUEGO AMIGO] %1 ha matado a %2, este es su segundo aviso.", _instigatorName, _victimName] remoteExec ["systemChat"];
    };
    case 3:
    {
        [format ["#kick %1", getPlayerUID _instigator]] remoteExecCall ["serverCommand", 2];
        parseText format ["%1 ha matado a 3 aliados y ha sido kickeado. <br/><img size='15' image='textures\ghana.paa' />", _instigatorName] remoteExec ["hint"];
        "Astronomia" remoteExec ["playMusic"];
    };
};