# How to : create an interface for docker-based components (DRAFT)

This document explains how to prepare an interface for a component to setup into the Galaxy OMTD instance.

## Common recommandation
A docker image for a component must be self-sufficient and be able to provide an execution of the component task into a container and provide the final outputs. If resources that change from one execution to another are used by the component, we recommand to make them available as values of parameters of the component. Otherwise, you must ensure that the right and required resources are avalaible to each component containers. The docker image of the component must be available into a docker repository accessible to OMTD (e.g., [docker hub](https://hub.docker.com/)).

## Requirements for an integration to the OMTD Galaxy instance
The docker-based components are wrapped as any tool into Galaxy. You must use [Galaxy Tool XML File](https://docs.galaxyproject.org/en/latest/dev/schema.html) to define a wrapper for the component. The component wrapper must (1) identify the docker image of the component and (2) set the command to execute the component task into a docker container.

 1. To identify the docker image the [`requirements`](https://docs.galaxyproject.org/en/latest/dev/schema.html#tool-requirements) element of Galaxy Tool XML File is used. `requirements` will contain the `container` element that describes the tag identifying the component docker image as value and the type of container that the component may be executed in (e.g., docker) using the `type` attribute, as follow. 
  
```xml
    <requirements>
        <container type="docker">
              bibliome/alvisnlp:1.0.0
        </container>
    </requirements>
 ```

 2. The component command is a value of the [`command`](https://docs.galaxyproject.org/en/latest/dev/schema.html#tool-command) element to execute inside a docker container. Nothing new, this part is similar to what you do when you describe script-based components.  

```bash
     <command>
         simpleprojector2.py 
	-verbose ${verbose}  
  	-noColors ${noColors} 
	-dictFile ${input}
	-trieSink ${output}
	-targetLayerName ${tln} 
	-valueFeatures ${vf}
	-keyIndex ${ki} 
     </command>
```
A complete example of XML wrapper (of a component that will run into a docker container) is provided [here](simpleprojector.xml). Note that, in the near future, the `requirements` and `command` elements will be provided into the OpenMinTeD Component description that includes XML wrapper of Component for Galaxy.

{% blurb style='tip', title='Important notice' %}
It is the Galaxy instance that manage the life-cycle of the docker containers (e.g., pull images, run images, mount the folders, kill containers, etc...). We assume that required configuration for Galaxy are done on the Galaxy side.
{% endblurb %}

