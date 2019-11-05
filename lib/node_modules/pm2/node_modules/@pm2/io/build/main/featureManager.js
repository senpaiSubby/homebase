"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const notify_1 = require("./features/notify");
const profiling_1 = require("./features/profiling");
const eventLoopInspector_1 = require("./features/eventLoopInspector");
const events_1 = require("./features/events");
const metrics_1 = require("./features/metrics");
const tracing_1 = require("./features/tracing");
const dependencies_1 = require("./features/dependencies");
const Debug = require("debug");
function getObjectAtPath(context, path) {
    if (path.indexOf('.') === -1 && path.indexOf('[') === -1) {
        return context[path];
    }
    let crumbs = path.split(/\.|\[|\]/g);
    let i = -1;
    let len = crumbs.length;
    let result;
    while (++i < len) {
        if (i === 0)
            result = context;
        if (!crumbs[i])
            continue;
        if (result === undefined)
            break;
        result = result[crumbs[i]];
    }
    return result;
}
exports.getObjectAtPath = getObjectAtPath;
class AvailableFeature {
}
const availablesFeatures = [
    {
        name: 'notify',
        optionsPath: '.',
        module: notify_1.NotifyFeature
    },
    {
        name: 'profiler',
        optionsPath: 'profiling',
        module: profiling_1.ProfilingFeature
    },
    {
        name: 'eventLoopInspector',
        optionsPath: 'actions.eventLoopDump',
        module: eventLoopInspector_1.EventLoopInspectorFeature
    },
    {
        name: 'events',
        module: events_1.EventsFeature
    },
    {
        name: 'metrics',
        optionsPath: 'metrics',
        module: metrics_1.MetricsFeature
    },
    {
        name: 'tracing',
        optionsPath: '.',
        module: tracing_1.TracingFeature
    },
    {
        name: 'dependencies',
        module: dependencies_1.DependenciesFeature
    }
];
class FeatureManager {
    constructor() {
        this.logger = Debug('axm:features');
    }
    init(options) {
        for (let availableFeature of availablesFeatures) {
            this.logger(`Creating feature ${availableFeature.name}`);
            const feature = new availableFeature.module();
            let config = undefined;
            if (typeof availableFeature.optionsPath !== 'string') {
                config = {};
            }
            else if (availableFeature.optionsPath === '.') {
                config = options;
            }
            else {
                config = getObjectAtPath(options, availableFeature.optionsPath);
            }
            this.logger(`Init feature ${availableFeature.name}`);
            feature.init(config);
            availableFeature.instance = feature;
        }
    }
    get(name) {
        const feature = availablesFeatures.find(feature => feature.name === name);
        if (feature === undefined || feature.instance === undefined) {
            throw new Error(`Tried to call feature ${name} which doesn't exist or wasn't initiated`);
        }
        return feature.instance;
    }
    destroy() {
        for (let availableFeature of availablesFeatures) {
            if (availableFeature.instance === undefined)
                continue;
            this.logger(`Destroy feature ${availableFeature.name}`);
            availableFeature.instance.destroy();
        }
    }
}
exports.FeatureManager = FeatureManager;
class FeatureConfig {
}
exports.FeatureConfig = FeatureConfig;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZmVhdHVyZU1hbmFnZXIuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi9zcmMvZmVhdHVyZU1hbmFnZXIudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6Ijs7QUFDQSw4Q0FBaUQ7QUFDakQsb0RBQXVEO0FBQ3ZELHNFQUF5RTtBQUN6RSw4Q0FBaUQ7QUFFakQsZ0RBQW1EO0FBQ25ELGdEQUFtRDtBQUNuRCwwREFBNkQ7QUFDN0QsK0JBQThCO0FBRTlCLFNBQWdCLGVBQWUsQ0FBRSxPQUFlLEVBQUUsSUFBWTtJQUM1RCxJQUFJLElBQUksQ0FBQyxPQUFPLENBQUMsR0FBRyxDQUFDLEtBQUssQ0FBQyxDQUFDLElBQUksSUFBSSxDQUFDLE9BQU8sQ0FBQyxHQUFHLENBQUMsS0FBSyxDQUFDLENBQUMsRUFBRTtRQUN4RCxPQUFPLE9BQU8sQ0FBQyxJQUFJLENBQUMsQ0FBQTtLQUNyQjtJQUVELElBQUksTUFBTSxHQUFHLElBQUksQ0FBQyxLQUFLLENBQUMsV0FBVyxDQUFDLENBQUE7SUFDcEMsSUFBSSxDQUFDLEdBQUcsQ0FBQyxDQUFDLENBQUE7SUFDVixJQUFJLEdBQUcsR0FBRyxNQUFNLENBQUMsTUFBTSxDQUFBO0lBQ3ZCLElBQUksTUFBTSxDQUFBO0lBRVYsT0FBTyxFQUFFLENBQUMsR0FBRyxHQUFHLEVBQUU7UUFDaEIsSUFBSSxDQUFDLEtBQUssQ0FBQztZQUFFLE1BQU0sR0FBRyxPQUFPLENBQUE7UUFDN0IsSUFBSSxDQUFDLE1BQU0sQ0FBQyxDQUFDLENBQUM7WUFBRSxTQUFRO1FBQ3hCLElBQUksTUFBTSxLQUFLLFNBQVM7WUFBRSxNQUFLO1FBQy9CLE1BQU0sR0FBRyxNQUFNLENBQUMsTUFBTSxDQUFDLENBQUMsQ0FBQyxDQUFDLENBQUE7S0FDM0I7SUFFRCxPQUFPLE1BQU0sQ0FBQTtBQUNmLENBQUM7QUFsQkQsMENBa0JDO0FBRUQsTUFBTSxnQkFBZ0I7Q0FxQnJCO0FBRUQsTUFBTSxrQkFBa0IsR0FBdUI7SUFDN0M7UUFDRSxJ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