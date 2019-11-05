var Utils = {
  extractServer: function (result, server) {
    try {
      var a = server.address();
    } catch (e) {
      return;
    }

    if (a) {
      result.address = a.address;
      result.port = a.port;
    }

    result.listeners = Utils.extractListeners(server, 'connection');
  },

  extractSocket: function (result, socket) {
    if (socket.localAddress) {
      result.localAddress = socket.localAddress;
      result.localPort = socket.localPort;
      result.remoteAddress = socket.remoteAddress;
      result.remotePort = socket.remotePort;
      result.remoteFamily = socket.remoteFamily;
    } else if (socket._handle && socket._handle.fd !== null) {
      result.fd = socket._handle.fd;
    } else {
      result.info = 'unknown socket';
    }

    if (socket._httpMessage) {
      result.method = socket._httpMessage.method;
      result.path = socket._httpMessage.path;
      result.headers = socket._httpMessage._headers;
    }

    result.listeners = Utils.extractListeners(socket, 'connect');
  },

  extractListeners: function (obj, listenerName) {
    var listerners = [];

    if (!obj.listeners || typeof obj.listeners !== 'function') {
      return listerners;
    }

    var connectListeners = obj.listeners(listenerName);
    if (connectListeners && connectListeners.length) {
      connectListeners.forEach(function (fn) {
        listerners.push({
          name: fn.name || '(anonymous)'
        });
      });
    }

    return listerners;
  },

  extractTimer: function (result, timer) {
    var type = 'setTimeout';
    var entryPoint = null;

    // node >= 6
    if (timer._list && timer._list._idleNext) {
      entryPoint = timer._list._idleNext;
    } else if (timer._idleNext) { // backward compatibilty with node 4
      entryPoint = timer._idleNext;
    }

    if (!entryPoint) {
      return;
    }

    if (entryPoint._repeat !== null) {
      type = 'setInterval';
    }

    result.startAfter = entryPoint._idleStart;

    result.name = entryPoint._onTimeout &&
    entryPoint._onTimeout.name !== '' ? entryPoint._onTimeout.name : 'anonymous';
    result.type = type;
    result.msecs = timer._list ? timer._list.msecs : timer.msecs;
  },

  extractChildProcess: function (result, child) {
    result.args = child.spawnargs;
    result.spawnfile = child.spawnfile;
    result.pid = child.pid;
    result.connected = child.connected;
    result.killed = child.killed;
  },

  extractMessagePort: function (result, messagePort) {
    result.listeners = Object.keys(messagePort._events);
  },

  extractTCPWrap: function (result, tcp) {
    result.address = tcp.address;
    result.port = tcp.port;
    result.localAddress = tcp.localAddress;
    result.localPort = tcp.localPort;
  }
};

module.exports = Utils;
