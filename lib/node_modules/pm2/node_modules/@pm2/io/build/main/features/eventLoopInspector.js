"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const serviceManager_1 = require("../serviceManager");
const EventLoopInspector = require("event-loop-inspector");
const Debug = require("debug");
class EventLoopInspectorConfig {
}
class EventLoopInspectorFeature {
    constructor() {
        this.logger = Debug('axm:features:actions:eventloop');
    }
    init(config) {
        if (config === false)
            return;
        if (config === undefined)
            return;
        if (config === true) {
            config = { enabled: true };
        }
        if (config.enabled === false)
            return;
        this.actionService = serviceManager_1.ServiceManager.get('actions');
        if (this.actionService === undefined) {
            return this.logger('cannot expose actions as action service isnt available');
        }
        this.eventLoopInspector = EventLoopInspector(false);
        this.actionService.registerAction('km:event-loop-dump', (cb) => {
            return cb({
                success: true,
                dump: this.eventLoopInspector.dump()
            });
        });
    }
    destroy() {
        this.logger('destroy');
    }
}
exports.EventLoopInspectorFeature = EventLoopInspectorFeature;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZXZlbnRMb29wSW5zcGVjdG9yLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vc3JjL2ZlYXR1cmVzL2V2ZW50TG9vcEluc3BlY3Rvci50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOztBQUNBLHNEQUFrRDtBQUVsRCwyREFBMEQ7QUFDMUQsK0JBQThCO0FBRTlCLE1BQU0sd0JBQXdCO0NBRTdCO0FBRUQsTUFBYSx5QkFBeUI7SUFBdEM7UUFHVSxXQUFNLEdBQWEsS0FBSyxDQUFDLGdDQUFnQyxDQUFDLENBQUE7SUE2QnBFLENBQUM7SUExQkMsSUFBSSxDQUFFLE1BQTJDO1FBQy9DLElBQUksTUFBTSxLQUFLLEtBQUs7WUFBRSxPQUFNO1FBQzVCLElBQUksTUFBTSxLQUFLLFNBQVM7WUFBRSxPQUFNO1FBQ2hDLElBQUksTUFBTSxLQUFLLElBQUksRUFBRTtZQUNuQixNQUFNLEdBQUcsRUFBRSxPQUFPLEVBQUUsSUFBSSxFQUFFLENBQUE7U0FDM0I7UUFDRCxJQUFJLE1BQU0sQ0FBQyxPQUFPLEtBQUssS0FBSztZQUFFLE9BQU07UUFFcEMsSUFBSSxDQUFDLGFBQWEsR0FBRywrQkFBYyxDQUFDLEdBQUcsQ0FBQyxTQUFTLENBQUMsQ0FBQTtRQUNsRCxJQUFJLElBQUksQ0FBQyxhQUFhLEtBQUssU0FBUyxFQUFFO1lBQ3BDLE9BQU8sSUFBSSxDQUFDLE1BQU0sQ0FBQyx3REFBd0QsQ0FBQyxDQUFBO1NBQzdFO1FBRUQsSUFBSSxDQUFDLGtCQUFrQixHQUFHLGtCQUFrQixDQUFDLEtBQUssQ0FBQyxDQUFBO1FBRW5ELElBQUksQ0FBQyxhQUFhLENBQUMsY0FBYyxDQUFDLG9CQUFvQixFQUFFLENBQUMsRUFBRSxFQUFFLEVBQUU7WUFDN0QsT0FBTyxFQUFFLENBQUM7Z0JBQ1IsT0FBTyxFQUFFLElBQUk7Z0JBQ2IsSUFBSSxFQUFFLElBQUksQ0FBQyxrQkFBa0IsQ0FBQyxJQUFJLEVBQUU7YUFDckMsQ0FBQyxDQUFBO1FBQ0osQ0FBQyxDQUFDLENBQUE7SUFDSixDQUFDO0lBRUQsT0FBTztRQUNMLElBQUksQ0FBQyxNQUFNLENBQUMsU0FBUyxDQUFDLENBQUE7SUFDeEIsQ0FBQztDQUNGO0FBaENELDhEQWdDQyJ9