"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const Debug = require("debug");
const eventemitter2_1 = require("eventemitter2");
const cluster = require("cluster");
const EventLoopInspector = require("event-loop-inspector");
class IPCTransport extends eventemitter2_1.EventEmitter2 {
    constructor() {
        super(...arguments);
        this.initiated = false;
        this.logger = Debug('axm:transport:ipc');
        this.eventLoopInspector = EventLoopInspector(false);
    }
    init(config) {
        this.logger('Init new transport service');
        if (this.initiated === true) {
            console.error(`Trying to re-init the transport, please avoid`);
            return this;
        }
        this.initiated = true;
        this.logger('Agent launched');
        this.onMessage = (data) => {
            this.logger(`Received reverse message from IPC`);
            this.emit('data', data);
        };
        process.on('message', this.onMessage);
        if (cluster.isWorker === false) {
            this.autoExitHook();
        }
        return this;
    }
    autoExitHook() {
        this.autoExitHandle = setInterval(() => {
            const dump = this.eventLoopInspector.dump();
            const requests = Object.keys(dump.requests);
            const handles = Object.keys(dump.handles);
            const sockets = dump.handles.Socket;
            const pipes = dump.handles.Pipe;
            const hasStdOut = sockets && sockets.find(sock => sock.fd === 1) !== undefined;
            const hasStdErr = sockets && sockets.find(sock => sock.fd === 2) !== undefined;
            const isSocketStds = sockets && sockets.length === 2 && hasStdErr && hasStdOut;
            const isOnlySocketStds = handles.length === 1 && isSocketStds;
            const isStdsWithIPC = isSocketStds && pipes && pipes.length === 1 && handles.length === 2;
            const shouldStillExit = isStdsWithIPC || isOnlySocketStds;
            if ((handles.length > 0 || requests.length > 0) && shouldStillExit === false) {
                return this.logger('no need to exit, there are handles/requests in uv', JSON.stringify(dump));
            }
            this.logger(`Nothing found in uv, removing the IPC listener`);
            process.removeListener('message', this.onMessage);
            let tmp = setTimeout(_ => {
                this.logger(`Still alive, listen back to IPC`);
                process.on('message', this.onMessage);
            }, 200);
            tmp.unref();
        }, 5000);
        this.autoExitHandle.unref();
    }
    setMetrics(metrics) {
        const serializedMetric = metrics.reduce((object, metric) => {
            if (typeof metric.name !== 'string')
                return object;
            object[metric.name] = {
                historic: metric.historic,
                unit: metric.unit,
                type: metric.id,
                value: metric.value
            };
            return object;
        }, {});
        this.send('axm:monitor', serializedMetric);
    }
    addAction(action) {
        this.logger(`Add action: ${action.name}:${action.type}`);
        this.send('axm:action', {
            action_name: action.name,
            action_type: action.type,
            arity: action.arity,
            opts: action.opts
        });
    }
    setOptions(options) {
        this.logger(`Set options: [${Object.keys(options).join(',')}]`);
        return this.send('axm:option:configuration', options);
    }
    send(channel, payload) {
        if (typeof process.send !== 'function')
            return -1;
        try {
            process.send({ type: channel, data: payload });
        }
        catch (err) {
            this.logger('Process disconnected from parent !');
            this.logger(err);
            return process.exit(1);
        }
    }
    destroy() {
        if (this.onMessage !== undefined) {
            process.removeListener('message', this.onMessage);
        }
        if (this.autoExitHandle !== undefined) {
            clearInterval(this.autoExitHandle);
        }
        this.logger('destroy');
    }
}
exports.IPCTransport = IPCTransport;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiSVBDVHJhbnNwb3J0LmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vc3JjL3RyYW5zcG9ydHMvSVBDVHJhbnNwb3J0LnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7O0FBQ0EsK0JBQThCO0FBRzlCLGlEQUE2QztBQUM3QyxtQ0FBa0M7QUFDbEMsMkRBQTBEO0FBRTFELE1BQWEsWUFBYSxTQUFRLDZCQUFhO0lBQS9DOztRQUVVLGNBQVMsR0FBWSxLQUFLLENBQUE7UUFDMUIsV0FBTSxHQUFhLEtBQUssQ0FBQyxtQkFBbUIsQ0FBQyxDQUFBO1FBRTdDLHVCQUFrQixHQUFHLGtCQUFrQixDQUFDLEtBQUssQ0FBQyxDQUFBO0lBNEd4RCxDQUFDO0lBekdDLElBQUksQ0FBRSxNQUF3QjtRQUM1QixJQUFJLENBQUMsTUFBTSxDQUFDLDRCQUE0QixDQUFDLENBQUE7UUFDekMsSUFBSSxJQUFJLENBQUMsU0FBUyxLQUFLLElBQUksRUFBRTtZQUMzQixPQUFPLENBQUMsS0FBSyxDQUFDLCtDQUErQyxDQUFDLENBQUE7WUFDOUQsT0FBTyxJQUFJLENBQUE7U0FDWjtRQUNELElBQUksQ0FBQyxTQUFTLEdBQUcsSUFBSSxDQUFBO1FBQ3JCLElBQUksQ0FBQyxNQUFNLENBQUMsZ0JBQWdCLENBQUMsQ0FBQTtRQUM3QixJQUFJLENBQUMsU0FBUyxHQUFHLENBQUMsSUFBYSxFQUFFLEVBQUU7WUFDakMsSUFBSSxDQUFDLE1BQU0sQ0FBQyxtQ0FBbUMsQ0FBQyxDQUFBO1lBQ2hELElBQUksQ0FBQyxJQUFJLENBQUMsTUFBTSxFQUFFLElBQUksQ0FBQyxDQUFBO1FBQ3pCLENBQUMsQ0FBQTtRQUNELE9BQU8sQ0FBQyxFQUFFLENBQUMsU0FBUyxFQUFFLElBQUksQ0FBQyxTQUFTLENBQUMsQ0FBQTtRQUlyQyxJQUFJLE9BQU8sQ0FBQyxRQUFRLEtBQUssS0FBSyxFQUFFO1lBQzlCLElBQUksQ0FBQyxZQUFZLEVBQUUsQ0FBQTtTQUNwQjtRQUNELE9BQU8s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