# How to : create an interface for docker-based components (DRAFT)

This document explains how to prepare an interface for a component to be setup into the Galaxy OMTD instance.

## Common recommandation
A container for your component must be self-sufficient, be able to execute the component task, and provide final outputs. If resources that may change from one execution to another are used by the component, we recommand to make them available as values of parameters of the component. Otherwise, you must ensure that the right resources are avalaible to each component containers. The docker image of the component must be available into a docker repository accessible to OMTD (e.g., [docker hub](https://hub.docker.com/)).

## Requirements for an integration to the OMTD Galaxy instance
The docker-based components are wrapped as any tool into Galaxy by using [Galaxy Tool XML File](https://docs.galaxyproject.org/en/latest/dev/schema.html). Into the tool  definition, you must (1) identify the docker image of the component and (2) set the command used to execute the component task into the docker container. 

 1. To identify the docker image the [`requirements`](https://docs.galaxyproject.org/en/latest/dev/schema.html#tool-requirements) of Galaxy Tool XML File is used. `requirements` will contain the `container` element that describes the type of container that the component may be executed in (e.g., docker) with the `type` attribute and the tag identifying the component docker image as value. Here is an example. 
  
```
    <requirements>
        <container type="docker">
              bibliome/alvisnlp:1.0.0
        </container>
    </requirements>
 ```

 2. The command to provide as a value of the `command` element is the one used inside the docker container. This part is similar to what you know when describing script-based components.  

```
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
A complete example of XML wrapper of a component that will run into a docker container is provided [here]. Note that, in the near future, the `requirements` and `command` elements will be provided into the OpeMinTeD Component description and the XML wrapper of the component will be included into the OpeMinTeD Component description.
