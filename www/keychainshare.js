export function keyAdd(uname, password, successCallback, errorCallback) {
	cordova.exec(successCallback, errorCallback, "KeychainShare", "keyAdd", [uname, password]);
}
export function keyFind(uname, successCallback, errorCallback) {
	cordova.exec(successCallback, errorCallback, "KeychainShare", "keyFind", [uname]);
}
