import { DefaultNodeModel } from "@projectstorm/react-diagrams";
import { AppArray } from './Model';

export class ComponentNodeModel extends DefaultNodeModel {
    readonly component: AppArray.Model.Component;

    constructor(component: AppArray.Model.Component) {
        super({
            name: component.id,
            // TODO: this will change to define color based on e.g. group
            color: 'rgb(0,192,255)'
        });

        this.component = component;
    }
}