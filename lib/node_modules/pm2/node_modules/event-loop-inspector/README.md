<div align="center">
<b>Event loop inspector</b><br/>
<br/><br/>

<a href="https://badge.fury.io/js/event-loop-inspector">
   <img src="https://badge.fury.io/js/event-loop-inspector.svg" alt="npm version" height="18">
</a>
</div>


# Purpose

Dump event loop data.
Useful to known which processes are running and potentially block your application.
Can be used for real time monitoring also.

It basically call core NodeJs functions _getActiveHandles and _getActiveRequests to inspect event loop's state.

No dependency.

# Compatibility

Supported and tested : >= 4.x
Not supported but should work : 0.12.x

| Version       | Supported     | Tested         |
| ------------- |:-------------:|:--------------:|
| 9.x           | yes           | yes            |
| 8.x           | yes           | yes            |
| 7.x           | yes           | yes            |
| 6.x           | yes           | yes            |
| 4.x           | yes           | yes            |
| 0.12.x        | no            | yes( manually) |
| > 0.12.x      | no            | no             |

# Installation

```console
$ npm install event-loop-inspector --save
```

# Usage

## Basic usage
```javascript
const inspector = require('event-loop-inspector')();
const dump = inspector.dump();

console.log(dump);
```

## Output
```javascript
{
  handles:
      {
        setTimeout:
            [{
              type: 'setTimeout',
              startAfter: 311,
              name: 'anonymous',
              msecs: 2000
            }],
        Server:
            [{
              type: 'Server',
              address: '::',
              port: 8000,
              listeners: [{name: 'connectionListener'}]
            }],
        Socket:
            [{
              type: 'Socket',
              localAddress: '127.0.0.1',
              localPort: 45014,
              remoteAddress: '127.0.0.1',
              remotePort: 8000,
              remoteFamily: 'IPv4',
              method: 'GET',
              path: '/toto',
              headers: {host: '127.0.0.1:8000'},
              listeners: []
            }]
      },
  requests:
      {
        TCPConnectWrap:
            [{
              type: 'TCPConnectWrap',
              address: 'xxx.xxx.xxx.xxx',
              port: xxxx,
              localAddress: 'xxx.xxx.xxx.xxx',
              localPort: xxxx
            }]
      },
  setImmediates:
      [
        {type: 'setImmediate', name: 'setImmediateTest2'},
        {type: 'setImmediate', name: 'anonymous'}
      ],
  nextTicks:
      [
        {type: 'nextTick', name: 'afterWrite'},
        {type: 'nextTick', name: 'anonymous'}
      ]
}
```

## Inspect more functions

By default setImmediates and process.nextTick can't be retrieved with functions _getActiveHandles/_getActiveRequests.
If you want to allow event-loop-inspector to wrap some core functions, instantiate inspector with first argument set as true.

```javascript
const inspector = require('event-loop-inspector')(true);
const dump = inspector.dump();

console.log(dump);
```

Functions that can be wrapped :
* process.nextTick
* setImmediate


**/!\ Enabling this option may lower performance of the functions involved.**

# Test

```console
$ npm test
```

To generate coverage :

```console
$ npm run test-coverage
```

Coverage report can be found in coverage/.
