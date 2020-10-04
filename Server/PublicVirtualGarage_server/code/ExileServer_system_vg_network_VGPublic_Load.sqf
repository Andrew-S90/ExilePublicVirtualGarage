private["_sessionID","_parameters", "_playerObject", "_VehicleID", "_data", "_extDBMessage"];

_sessionID = _this select 0;
_parameters = _this select 1;
_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;

_VehicleID = format["loadVehicleFromVGPublicFirst:%1", (getPlayerUID _playerObject)] call ExileServer_system_database_query_selectSingle;
if(_VehicleID isEqualType []) exitWith 
{
	(_VehicleID select 0) call ExileServer_object_vehicle_database_load;

	_data = [(_VehicleID select 0)];

	_extDBMessage = ["loadVehicleFromVGPublic", _data] call ExileServer_util_extDB2_createMessage;
	_extDBMessage call ExileServer_system_database_query_fireAndForget;
	[_sessionID, "toastRequest", ["SuccessTitleAndText", ["Public Garage", "Vehicle Loaded!"]]] call ExileServer_system_network_send_to;
	true
};
[_sessionID, "toastRequest", ["ErrorTitleAndText", ["Public Garage", "No vehicle found!"]]] call ExileServer_system_network_send_to;
true