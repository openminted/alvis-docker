# How to : create an interface for docker-based components (DRAFT)

## Common requirements

## Requirements for an integration to the OMTD registry

## Requirements for an integration to the OMTD Galaxy instance

the `requirement` element into the component wrapper
  
```
    <requirements>
        <container type="docker">
              the tag to identify the docker image
        </container>
    </requirements>
 ```

the `command` element into the component wrapper

```
     <command>
             the command to execute the component
     </command>
```


<!--
For example, if the following command to execute your docker-based component in command-line
```
docker run [options] my_docker_image_tag 
 component_exe -param1 value1 param2 value2
```
then, requirement element is defined as follow
```
my_docker_image_tag 
```
 and the requirement element is
 ```
  component_exe -param1 ${value1 param2 value2
  ```
-->
