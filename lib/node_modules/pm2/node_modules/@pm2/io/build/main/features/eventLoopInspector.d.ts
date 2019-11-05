import { Feature } from '../featureManager';
declare class EventLoopInspectorConfig {
    enabled: boolean;
}
export declare class EventLoopInspectorFeature implements Feature {
    private actionService;
    private logger;
    private eventLoopInspector;
    init(config?: EventLoopInspectorConfig | boolean): any;
    destroy(): void;
}
export {};
