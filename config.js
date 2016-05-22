exports.listenIP = null; //Defaults to *
exports.listenPort = '8081'; //the SSL port things run on
exports.httpListenPort = '8080'; //this will all be redirected to SSL
exports.cacheApps = true;
exports.httpVisiblePort = '8080'; //forwarded http port the user sees
exports.httpsVisiblePort = '8081'; //forwarded https port the user sees


//SSL Info
exports.country = "US";
exports.state = "New York";
exports.locale = "New York";
exports.commonName = "coder.local";
exports.subjectAltName = "DNS:192.168.0.1";

