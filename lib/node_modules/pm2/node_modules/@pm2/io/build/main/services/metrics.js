'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const meter_1 = require("../utils/metrics/meter");
const counter_1 = require("../utils/metrics/counter");
const histogram_1 = require("../utils/metrics/histogram");
const serviceManager_1 = require("../serviceManager");
const constants_1 = require("../constants");
const Debug = require("debug");
const gauge_1 = require("../utils/metrics/gauge");
var MetricType;
(function (MetricType) {
    MetricType["meter"] = "meter";
    MetricType["histogram"] = "histogram";
    MetricType["counter"] = "counter";
    MetricType["gauge"] = "gauge";
    MetricType["metric"] = "metric";
})(MetricType = exports.MetricType || (exports.MetricType = {}));
var MetricMeasurements;
(function (MetricMeasurements) {
    MetricMeasurements["min"] = "min";
    MetricMeasurements["max"] = "max";
    MetricMeasurements["sum"] = "sum";
    MetricMeasurements["count"] = "count";
    MetricMeasurements["variance"] = "variance";
    MetricMeasurements["mean"] = "mean";
    MetricMeasurements["stddev"] = "stddev";
    MetricMeasurements["median"] = "median";
    MetricMeasurements["p75"] = "p75";
    MetricMeasurements["p95"] = "p95";
    MetricMeasurements["p99"] = "p99";
    MetricMeasurements["p999"] = "p999";
})(MetricMeasurements = exports.MetricMeasurements || (exports.MetricMeasurements = {}));
class Metric {
}
exports.Metric = Metric;
class MetricBulk extends Metric {
}
exports.MetricBulk = MetricBulk;
class HistogramOptions extends Metric {
}
exports.HistogramOptions = HistogramOptions;
class MetricService {
    constructor() {
        this.metrics = new Map();
        this.timer = null;
        this.transport = null;
        this.logger = Debug('axm:services:metrics');
    }
    init() {
        this.transport = serviceManager_1.ServiceManager.get('transport');
        if (this.transport === null)
            return this.logger('Failed to init metrics service cause no transporter');
        this.logger('init');
        this.timer = setInterval(() => {
            if (this.transport === null)
                return this.logger('Abort metrics update since transport is not available');
            this.logger('refreshing metrics value');
            for (let metric of this.metrics.values()) {
                metric.value = metric.handler();
            }
            this.logger('sending update metrics value to transporter');
            const metricsToSend = Array.from(this.metrics.values())
                .filter(metric => {
                if (metric === null || metric === undefined)
                    return false;
                if (metric.value === undefined || metric.value === null)
                    return false;
                const isNumber = typeof metric.value === 'number';
                const isString = typeof metric.value === 'string';
                const isValidNumber = !isNaN(metric.value);
                return isString || (isNumber && isValidNumber);
            });
            this.transport.setMetrics(metricsToSend);
        }, constants_1.default.METRIC_INTERVAL);
        this.timer.unref();
    }
    registerMetric(metric) {
        if (typeof metric.name !== 'string') {
            console.error(`Invalid metric name declared: ${metric.name}`);
            return console.trace();
        }
        else if (typeof metric.type !== 'string') {
            console.error(`Invalid metric type declared: ${metric.type}`);
            return console.trace();
        }
        else if (typeof metric.handler !== 'function') {
            console.error(`Invalid metric handler declared: ${metric.handler}`);
            return console.trace();
        }
        if (typeof metric.historic !== 'boolean') {
            metric.historic = true;
        }
        this.logger(`Registering new metric: ${metric.name}`);
        this.metrics.set(metric.name, metric);
    }
    meter(opts) {
        const metric = {
            name: opts.name,
            type: MetricType.meter,
            id: opts.id,
            historic: opts.historic,
            implementation: new meter_1.default(opts),
            unit: opts.unit,
            handler: function () {
                return this.implementation.isUsed() ? this.implementation.val() : NaN;
            }
        };
        this.registerMetric(metric);
        return metric.implementation;
    }
    counter(opts) {
        const metric = {
            name: opts.name,
            type: MetricType.counter,
            id: opts.id,
            historic: opts.historic,
            implementation: new counter_1.default(opts),
            unit: opts.unit,
            handler: function () {
                return this.implementation.isUsed() ? this.implementation.val() : NaN;
            }
        };
        this.registerMetric(metric);
        return metric.implementation;
    }
    histogram(opts) {
        if (opts.measurement === undefined || opts.measurement === null) {
            opts.measurement = MetricMeasurements.mean;
        }
        const metric = {
            name: opts.name,
            type: MetricType.histogram,
            id: opts.id,
            historic: opts.historic,
            implementation: new histogram_1.default(opts),
            unit: opts.unit,
            handler: function () {
                return this.implementation.isUsed() ?
                    (Math.round(this.implementation.val() * 100) / 100) : NaN;
            }
        };
        this.registerMetric(metric);
        return metric.implementation;
    }
    metric(opts) {
        let metric;
        if (typeof opts.value === 'function') {
            metric = {
                name: opts.name,
                type: MetricType.gauge,
                id: opts.id,
                implementation: undefined,
                historic: opts.historic,
                unit: opts.unit,
                handler: opts.value
            };
        }
        else {
            metric = {
                name: opts.name,
                type: MetricType.gauge,
                id: opts.id,
                historic: opts.historic,
                implementation: new gauge_1.default(),
                unit: opts.unit,
                handler: function () {
                    return this.implementation.isUsed() ? this.implementation.val() : NaN;
                }
            };
        }
        this.registerMetric(metric);
        return metric.implementation;
    }
    deleteMetric(name) {
        return this.metrics.delete(name);
    }
    destroy() {
        if (this.timer !== null) {
            clearInterval(this.timer);
        }
        this.metrics.clear();
    }
}
exports.MetricService = MetricService;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibWV0cmljcy5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uL3NyYy9zZXJ2aWNlcy9tZXRyaWNzLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBLFlBQVksQ0FBQTs7QUFFWixrREFBMEM7QUFDMUMsc0RBQThDO0FBQzlDLDBEQUFrRDtBQUNsRCxzREFBMkQ7QUFDM0QsNENBQW9DO0FBRXBDLCtCQUE4QjtBQUM5QixrREFBMEM7QUFFMUMsSUFBWSxVQU1YO0FBTkQsV0FBWSxVQUFVO0lBQ3BCLDZCQUFpQixDQUFBO0lBQ2pCLHFDQUF5QixDQUFBO0lBQ3pCLGlDQUFxQixDQUFBO0lBQ3JCLDZCQUFpQixDQUFBO0lBQ2pCLCtCQUFtQixDQUFBO0FBQ3JCLENBQUMsRUFOVyxVQUFVLEdBQVYsa0JBQVUsS0FBVixrQkFBVSxRQU1yQjtBQUVELElBQVksa0JBYVg7QUFiRCxXQUFZLGtCQUFrQjtJQUM1QixpQ0FBYSxDQUFBO0lBQ2IsaUNBQWEsQ0FBQTtJQUNiLGlDQUFhLENBQUE7SUFDYixxQ0FBaUIsQ0FBQTtJQUNqQiwyQ0FBdUIsQ0FBQTtJQUN2QixtQ0FBZSxDQUFBO0lBQ2YsdUNBQW1CLENBQUE7SUFDbkIsdUNBQW1CLENBQUE7SUFDbkIsaUNBQWEsQ0FBQTtJQUNiLGlDQUFhLENBQUE7SUFDYixpQ0FBYSxDQUFBO0lBQ2IsbUNBQWUsQ0FBQTtBQUNqQixDQUFDLEVBYlcsa0JBQWtCLEdBQWxCLDBCQUFrQixLQUFsQiwwQkFBa0IsUUFhN0I7QUF1Q0QsTUFBYSxNQUFNO0NBMEJsQjtBQTFCRCx3QkEwQkM7QUFFRCxNQUFhLFVBQVcsU0FBUSxNQUFNO0NBRXJDO0FBRkQsZ0NBRUM7QUFFRCxNQUFhLGdCQUFpQixTQUFRLE1BQU07Q0FFM0M7QUFGRCw0Q0FFQztBQUVELE1BQWEsYUFBYTtJQUExQjtRQUVVLFlBQU8sR0FBZ0MsSUFBSSxHQUFHLEVBQUUsQ0FBQTtRQUNoRCxVQUFLLEdBQXdCLElBQUksQ0FBQTtRQUNqQyxjQUFT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