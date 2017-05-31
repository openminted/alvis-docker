


# Guidelines for deploying a Alvis component with a dockerized Alvis engine (DRAFT)
In this document we describe how make the Alvis components as OpenMinTeD runnable modules. The [Alvis framework](https://github.com/Bibliome/alvisnlp) we use here is packaged with the Alvis components and required ressources as a docker image into docker hub. The guidelines do not concern docker, docker is just used to deploy and run Alvis. See [here](https://github.com/openminted/alvis-docker) for the Alvis docker project. The guidelines describe how Alvis plans are used to adapt component as OMTD modules and how the modules are described to fit OpenMinTeD requirements.

{% blurb style='tip', title='Important notice' %}
This procedure requires docker to be intalled and 4Go of free space. You will also need Java and XML skills for in-depth configurations.
{% endblurb %}

Before going further, let's define the notion of plan into Alvis. A plan is a preconfigured receipt using the Alvis elementary components in order to define a specific runable module. These runnable modules are workflows but in this OpenMinTeD context they are seen as OpenMinTeD compatible modules. Thus, rather than composing several modules, a plan here lets us just adapt a Alvis component as a OpenMinTeD module by preparing an interface for its inputs, outputs and parameters.

## Define a runnable module with an Alvis plan
An plan to define a module is a xml file with extension `.plan` that contains 3 parts : a reader part that configures the inputs, a writer part that configures the outputs, and the main part that specify the Alvis component to adapt as a OpenMinTeD runnable module.

The following plan adapts the Alvis component named `WoSMig` as a OpenMinteD runnable module. `WoSMig` do tokenization of text documents. The plan is composed of the elementary Alvis component `TextFileReader` to read text files, the elementary component `TabularExport` to export the results as tabular forms, and the main module `WoSMig` doing the tokenization task. The schema of the plan remains the same from a module to another, the things that change are just the components. The main components to use are available into Alvis, whom also has several typical reader and writer components (new ones can be implemented (for example to convert new formats)). 

```
<alvisnlp-plan id="OMTD_WoSMig">

	<read class="TextFileReader"/>

	<annotation class="WoSMig"/>

	<write class="TabularExport"/>

</alvisnlp>
```

You can feed values of the parameters that don't require to be used as input parameter of the module into the plan. That has the double advantage of saving the optimal parameters and values and reducing for the end user the number of parameters to consider. In the following plan parameter `ponctuations` and `balancedPuntuations` of component `WoSMig` are fed.


```
<alvisnlp-plan id="OMTD_WoSMig">

	<read class="TextFileReader"/>

	<annotation class="WoSMig">
  		<ponctuations>?.!;,:-</pontuations>
  		<balancedPunctuations>()[]{}""</balancedPunctuations>
	</annotation>

	<write class="TabularExport"/>

</alvisnlp>
```

{% blurb style='tip', title='Important notice' %}
Note that, what interests us here is using the Alvis plans to make the Alvis modules compatible with OpenMinTeD. Plans are used in a general way to define complexe modules and workflows. A more complete presentation on how to write a plan is available [here](https://github.com/Bibliome/alvisnlp/wiki/Writing-plans). 
{% endblurb %}


The previous plan defines an autonomeous and runnable module that can be executed with the following command. The `-v` option is used to mount the directory where the input and output data are accessible to the docker image.   

```
docker run -i --rm -v $PWD/workdir:/opt/alvisnlp/data -a stderr mandiayba/alvisengine:1.0.0 
           alvisnlp
           -param read sourcePath /opt/alvisnlp/data[/path/to/text/files]  # other params can be add to the component *read* 
           -param write outDir /opt/alvisnlp/data[/path/to/the/outdirectory/] # other params can be add to the component *read* 
	   -param WoSMiG ... # params can be added to the component *tomap* if required by the usage
           /path/to/the/plan.plan
```


Defining a plan requires you to know Alvis and its components. However, most of the time you will be re-using existing plans that are created by the Alvis developers. To know what components to use, you can ckeck it in command line with a docker container with the following commands.

```
docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedModules # Alvis general help

docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedModules # list of the module, including some typical readers and writers

docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedConversions # list of more complex conversions

docker run run mandiayba/alvisengine:1.0.0 alvisnlp -moduleDoc WoSMig # a user document of component WoSMig 

```


## Describe the runnable module for OpenMinTeD

To ascompagn the runnable module, OpenMinTeD requires you to provide a description based on the [OpenMinTeD Schema](https://guidelines.openminted.eu/the_omtd-share_metadata_schema.html) for the module. We thus use the schema to describe the OpenMinTeD runnable modules. At least, description instances of the [mandatory elements of the OpenMinTeD Schema](https://guidelines.openminted.eu/guidelines_for_providers_of_sw_resources/recommended_schema_for_sw_resources.html) are required. Alvis  automatically generates some element instances of the schema (module name and presentation, input and output parameter description, etc.), some others currently need to be defined by hand (i.e., external resources, citation, etc.). regardless the method, what is important is to provide a valid description (against the schema) of the runnable modules.

A particular attention must be paid to the metadata related to the module execution. They are those used by the module during execution including command, input and output parameters. The command metadata (see [`command` element](https://guidelines.openminted.eu/components_command.html)) is similar to the command presented in the previous section, where the values of the parameters will be contained in variables referencing parameter names of the module. The plan is seen as an ancillary resource identified and localized with metadata element [`relatedResource`](https://guidelines.openminted.eu/compoments_relatedResource.md). 

The following command is a value for metadata element `command`. It assumes the existence of two parameters of the modules having values `incorpus` and `outdir` as instances of `parameterName` elements. It also assumes that the plan of the module is described as a ancillary resource (see [here](https://guidelines.openminted.eu/guidelines_for_providers_of_ancillary_resources/)  for how to fully describe an ancillary resource). 
```
docker run -i --rm -v /path/to/OMTD_Workdir:/opt/alvisnlp/data -a stderr mandiayba/alvisengine:1.0.0 
           alvisnlp
           -param read sourcePath ${incorpus}  # other params can be add to the component *read* 
           -param write outDir ${outdir} # other params can be add to the component *read* 
	   -param WoSMiG ... # params can be added to the component *tomap* if required by the usage
           /path/to/the/relatedResource.plan # the plan to use for the module must be available as a related resource
```
{% blurb style='tip', title='Important notice' %}
We assume in the command that OpenMinTeD will resolve the correspondance between the path to the mounted `OMTD_Workdir` and the input (and output) data.
{% endblurb %}

All parameters of the module must be described in the metadata at least with a name, a description, a type (or format). That description is generated by Alvis.

## Package for OpenMinTeD

The minimal resources into the package is a XML file of the module description and the plan file. Other resources can be added according to the description of the module.

{% blurb style='tip', title='Important notice' %}
We assume that the OpenMinTeD platform has all required to manage docker images and containers. The deployment of Alvis and its component will be transparent, it also be done with `docker pull mandiayba/alvisengine:1.0.0`.
{% endblurb %}

