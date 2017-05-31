# Guidelines for deploying a Alvis component with a dockerized Alvis engine (DRAFT)
In this document we will describe how to adapt the Alvis component as OpenMinTeD modules. The Alvis framework we use here is packaged as a docker image with the Alvis components and the required ressources. The guidelines does not concern docker, docker is just used to run Alvis. See [here](https://github.com/openminted/alvis-docker) for more about Alvis docker. The guidelines describe how the Alvis plans are used to adapt component as OMTD modules and how the modules are described to fit the OpenMinTeD requirements.

{% blurb style='tip', title='Important notice' %}
This document assumes your machine to have docker intalled and 4Go of free space. You will also need Java and XML skills for some indeipt configurations.
{% endblurb %}

Before going further, let's define the notion of plan into Alvis. A plan is a preconfigured receipt using Alvis elementary components in order to define a specific runable module. The modules are seen as workflows but in this OpenMinTeD context they are compatible OpenMinTeD modules. A plan here lets us adapt a Alvis component as a OpenMinTeD module by preparing the interface for its inputs, outputs and parameters.

## Define a runnable module with an Alvis plan
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


With the previous plan, you have defined a runnable module. It can be executed with the following command. 

```
docker run -i --rm -v $PWD/workdir:/opt/alvisnlp/data -a stderr mandiayba/alvisengine:1.0.0 
           alvisnlp
           -param read sourcePath /path/to/the/text/files  # other params can be add to the component *read* 
           -param write outDir /path/to/the/directory/where/to/write/output # other params can be add to the component *read* 
	   -param WoSMiG ... # params can be added to the component *tomap* if required by the usage
           /path/to/the/plan.plan
```


Defining a plan requires you to know Alvis and its components. However, most of the time you will be re-using existing plans that are created by the Alvis developers. To know what components to use, you can ckeck it in command line with a docker container.

```
docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedModules # Alvis general help

docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedModules # list of the module, including some typical readers and writers

docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedConversions # list of more complex conversions

docker run run mandiayba/alvisengine:1.0.0 alvisnlp -moduleDoc WoSMig # a user document of component WoSMig 

```


## Describe a runnable module for OpenMinTeD

OpenMinTeD requires to provide descriptions based on the [OpenMinTeD Schema](https://guidelines.openminted.eu/the_omtd-share_metadata_schema.html) for all the modules. We use the schema to describe into OpenMinTeD the runnable module. At least, description of the [mandatory elements of the OpenMinTeD Schema](https://guidelines.openminted.eu/guidelines_for_providers_of_sw_resources/recommended_schema_for_sw_resources.html) is required. In Alvis some element instances of the schema are automatically generated (module name and presentation, input and output parameter description, etc.), others currently need to be defined by hand (i.e., external resources, citation, etc.). regardless of the method, what is important is to provide a valid description (against the schema) of the Alvis runnable modules.

A particular attention must be paid to the metadata related to the module execution when describing a module. They are those used by the module during execution including command, input and output parameters. The command metadata (see [`command` element](https://guidelines.openminted.eu/components_command.html)) is similar to the command presented in the previous section, where the values of the parameters will be contained in variables referencing parameter names of the module. The plan is seen as a related resource identified and localized with metadata element [`relatedResource`](https://guidelines.openminted.eu/compoments_relatedResource.md). 


The following command is a value for metadata element `command`. It supposes the existence of two parameters of the modules having values `incorpus` and `outdir` for their `parameterName` elements. It also supposes the plan of the module is described as a related resource (see [here](https://guidelines.openminted.eu/guidelines_for_providers_of_ancillary_resources/)  for how to fully describe an ancillary_resource).
```
docker run -i --rm -v $PWD/workdir:/opt/alvisnlp/data -a stderr mandiayba/alvisengine:1.0.0 
           alvisnlp
           -param read sourcePath ${incorpus}  # other params can be add to the component *read* 
           -param write outDir ${outdir} # other params can be add to the component *read* 
	   -param WoSMiG ... # params can be added to the component *tomap* if required by the usage
           /path/to/the/relatedResource.plan # the plan to use for the module must be available as a related resource
```

All parameters of the module must be described in the metadata at least with a name, a description, a type (or format). That description is generated from Alvis.

## Package for OpenMinTeD

The minimal resources into the package is a XML file containing the module description and the plan file. Other resources can be added according to the description of the module.

{% blurb style='tip', title='Important notice' %}
We suppose the OpenMinTeD platform has all required to manage docker images and containers.
{% endblurb %}

