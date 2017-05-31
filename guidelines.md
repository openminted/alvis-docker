# Guidelines for deploying a Alvis component with a dockerized Alvis engine (DRAFT)
In this document we will describe how to adapt the Alvis component as OpenMinTeD modules. The Alvis framework we use here is packaged as a docker image with the Alvis components and the required ressources. The guidelines does not concern docker, docker is just used to run Alvis. See [here](https://github.com/openminted/alvis-docker) for more about Alvis docker. The guidelines describe how the Alvis plans are used to adapt component as OMTD modules and how the modules are described to fit the OpenMinTeD requirements.

{% blurb style='tip', title='Important notice' %}
This document assumes your machine to have docker intalled and 4Go of free space. You will also need Java and XML skills for some indeipt configurations.
{% endblurb %}

Before going further, let's define the notion of plan into Alvis. A plan is a preconfigured receipt using Alvis elementary components in order to define a specific runable module. The modules are seen as workflows but in this OpenMinTeD context they are compatible OpenMinTeD modules. A plan here lets us adapt a Alvis component as a OpenMinTeD module by preparing the interface for its inputs, outputs and parameters.

## Configuring an Alvis Plan to define a runnable module
An alvis plan to define a module is a xml file with extension `.plan` that contains 3 parts : a reader part that configures the inputs, a writer part that configures the outputs, and the main part that specify the Alvis component to adapt as a OpenMinTeD module.

The following plan adapt the Alvis component `WoSMig` as a OpenMinteD module. `WoSMig` do tokenization of text documents. The plan is composed of the elementary Alvis component `TextFileReader` to read text files, the elementary component `TabularExport` to export the results as tabular forms, and the module `WoSMig` doing the main tokenization task. The schema of the plan remains the same from a module to another, the things that change are the components. All components must be present into Alvis. Alvis has several typical reader and writer components, new ones can be implemented if required (for example to convert new formats). 

```
<alvisnlp-plan id="OMTD_WoSMig">

<read class="TextFileReader">
</read>

<tokenization class="WoSMig">
</tokenization>

<write class="TabularExport">
</write>

</alvisnlp>
```

Into the plan you can feed values of the parameters that don't require to be used as input parameter of the module. That has the double advantage of saving optimal parameters and reducing for the end user the number of parameters to consider. In the following plan parameter `ponctuations` and `balancedPuntuations` of component `WoSMig` are feed.


```
<alvisnlp-plan id="OMTD_WoSMig">

<read class="TextFileReader">
</read>

<annotation class="WoSMig">
  <ponctuations>?.!;,:-</pontuations>
  <balancedPunctuations>()[]{}""</balancedPunctuations>
</annotation>

<write class="TabularExport">
</write>
```

{% blurb style='tip', title='Important notice' %}
Note that, what interests us here is using Alvis plans to make the Alvis modules compatible with OpenMinTeD. Plans are used in a general way to define complexe modules and workflows. A more complete presentation on how to write a plan is available [here](https://github.com/Bibliome/alvisnlp/wiki/Writing-plans). 
{% endblurb %}


Defining a plan requires you to know Alvis and its components. However, most of the time you will be re-using existing plans that are created by the Alvis developers. To know what components to use, you can ckeck it in command line with a docker container.

```
docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedModules # Alvis general help

docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedModules # list of the module, including some typical readers and writers

docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedConversions # list of more complex conversions

docker run run mandiayba/alvisengine:1.0.0 alvisnlp -moduleDoc WoSMig # a user document of component WoSMig 

```


## Describing the module for OpenMinTeD

After the previous step, you have defined a runnable module. It can be executed with the following command. 

```
docker run -i --rm -v $PWD/workdir:/opt/alvisnlp/data -a stderr mandiayba/alvisengine:1.0.0 
           alvisnlp
           -param read sourcePath /path/to/the/text/files  # other params can be add to the component *read* 
           -param write outDir /path/to/the/directory/where/to/write/output # other params can be add to the component *read* 
	   -param WoSMiG ... # params can be added to the component *tomap* if required by the usage
           /path/to/the/plan.plan
```

The previous command can be executed into a shell. But before defining the command, we need to know what are the functionalies and the parameters of the modules. That meets the requirement into OpenMinTeD to provide descriptions for all the modules, including functionalies and parameters. Thus, we use the [openMinTeD Schema](https://guidelines.openminted.eu/the_omtd-share_metadata_schema.html) to describe the modules. We have to describe, at least, the [mandatory elements of the OpenMinTeD Schema](https://guidelines.openminted.eu/guidelines_for_providers_of_sw_resources/recommended_schema_for_sw_resources.html). Some element (module name and presentation, input and output parameter description, etc.) are automatically generated from Alvis, others (i.e., external resources, citation, etc.) currently need to be defined by hand. 

When describing a module, a particular attention must be paid to the metadata related to the module execution. They are those used by the module during execution including command, type system, inputs/outputs, etc. The command metadata (see [`command` element](https://guidelines.openminted.eu/components_command.html)) is a rewritten of the command presented above, where the values of the parameters are contained in variables referencing parameter names of the module.  

```
docker run -i --rm -v $PWD/workdir:/opt/alvisnlp/data -a stderr mandiayba/alvisengine:1.0.0 
           alvisnlp
           -param read sourcePath ${incorpus}  # other params can be add to the component *read* 
           -param write outDir ${outdir} # other params can be add to the component *read* 
	   -param WoSMiG ... # params can be added to the component *tomap* if required by the usage
           /path/to/the/plan.plan
```

The command is a value for metadata element `command`. It supposes the existence of two parameters of the modules having the values `incorpus` and `outdir` for their `parameterName` elements. 
