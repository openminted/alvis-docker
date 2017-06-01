


# HOWTO: Build an OpenMinTeD runnable component based on AlvisNLP/ML docker image

This document describes how to setup an OpenMinTeD runnable component from the AlvisNLP/ML modules.

We use the [AlvisNLP/ML framework](https://github.com/Bibliome/alvisnlp) packaged as a [docker image](https://hub.docker.com/r/mandiayba/alvisengine/) (available into docker hub) that includes all AlvisNLP/ML modules and ressources. The guidelines specifically describe how AlvisNLP/ML "plans" are used to adapt modules as runnable components and how the components are described to fit OpenMinTeD requirements.

## Requirements

* `docker` version XXX
* 4Gb available in RAM/filesystem? XXX
* Basic XML and Java knowledge for in-depth configuration. <!-- @J: rather a required skill ;) -->

## AlvisNLP/ML Basics

[AlvisNLP/ML framework](https://github.com/Bibliome/alvisnlp) is a corpus processing engine that features a library of processing modules. These library includes modules for tokenization, sentence splitting, POS-tagging, parsing, NER, relation extraction, etc.

Users run AlvisNLP/ML <!-- @J: ?-->

AlvisNLP
Before going further, let's define the notion of plan into Alvis. A plan is a preconfigured receipt using the Alvis elementary components in order to define a specific runable module. These runnable modules are workflows but in this OpenMinTeD context they are seen as OpenMinTeD compatible modules. <!-- @J: introduire composants, modules et workflows et les approches OMTD et Galaxy dans une phrase est dur à suivre. Une liste avec le vocabulaire ferait probablement l'affaire--> Thus, rather than composing several modules, a plan here lets us just adapt an Alvis component to an OpenMinTeD module by preparing the interface for its inputs, outputs and parameters.  <!-- @J: aussi un petit peu dur-->

## Define a runnable module with an Alvis plan
A plan for a runnable module is a XML file (with extension `.plan`) that contains 3 parts: a read part that configures the inputs, a write part that configures the outputs, and a process part that configures the task of the Alvis component being adapted as an OpenMinTeD runnable module.

The following plan adapts the Alvis component named `WoSMig` to an runnable module. `WoSMig` does tokenization of text documents. The plan is composed of the Alvis component `TextFileReader` to read text files, the component `TabularExport` to export the results as tabular forms, and the process module `WoSMig` doing the tokenization task. The runnable modules will be set in this way, it is just the `read` and `write` parts who will change according to the needs. The process components to use are available into Alvis. Alvis also has several typical components for the read and write parts (new components can be implemented, for example to convert new formats).
```xml
<alvisnlp-plan id="OMTD_WoSMig">
	<read class="TextFileReader"/>
	<annotation class="WoSMig"/>
	<write class="TabularExport"/>
</alvisnlp-plan>
```

You can feed values of parameters (that don't require to be used as input parameter of the module) into the plan. That has the double advantage of recording the optimal parameters and values and reducing for the end user the number of input parameters to consider. In the following modified plan parameters `ponctuations` and `balancedPuntuations` of component `WoSMig` are fed.
```xml
<alvisnlp-plan id="OMTD_WoSMig">
	<read class="TextFileReader"/>
	<annotation class="WoSMig">
  		<punctuations>?.!;,:-</punctuations>
  		<balancedPunctuations>()[]{}""</balancedPunctuations>
	</annotation>
	<write class="TabularExport"/>
</alvisnlp-plan>
```

{% blurb style='tip', title='Important notice' %}
Note that, what interests us here is using the Alvis plans to make the Alvis modules compatible with OpenMinTeD. Plans are used in a general way to define complexe modules and workflows. A more complete presentation on how to write plans is available [here](https://github.com/Bibliome/alvisnlp/wiki/Writing-plans). 
{% endblurb %}

The previous plan defines an autonomous and runnable module that can be executed with the following command. The `-v` option is used to mount the directory where the input and output data will be accessible to the docker image. `mandiayba/alvisengine:1.0.0` is used to identify the concerned docker image and `alvisnlp` is used to run the alvisengine on parameters. The above defined plan is one of the parameter to feed to the alvis engine.
```bash
docker run -i --rm -a stderr -v $PWD/workdir:/opt/alvisnlp/data mandiayba/alvisengine:1.0.0 
           alvisnlp
           -param read sourcePath /opt/alvisnlp/data[/path/to/text/files]  # `sourcePath` to locate input by component `TextFileReader`
           -param write outDir /opt/alvisnlp/data[/path/to/the/outdirectory/] # `outDir` to locate output by component `TabularExport` 
	   -param WoSMiG ... # params can be added to component `WoSMig` if needed
           /path/to/the/plan.plan
```

Defining a plan requires you to know Alvis and its components. However, most of the time you will be re-using existing plans that are created by the Alvis developers. To know which components to use, you can ckeck in command line with a docker container using the following commands.
```bash
docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedModules # Alvis general help

docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedModules # list modules, including some typical readers and writers

docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedConversions # list more complex converters

docker run run mandiayba/alvisengine:1.0.0 alvisnlp -moduleDoc WoSMig # a user-document of component named `WoSMig` 
```

## Describe the runnable module for OpenMinTeD
With the autonomous and runnable module, OpenMinTeD requires you to provide a description based on the [OpenMinTeD Metadata Schema](https://guidelines.openminted.eu/the_omtd-share_metadata_schema.html) for the module. We thus use that schema to describe the OpenMinTeD runnable modules. At least, description instances of the [mandatory elements of the OpenMinTeD Schema](https://guidelines.openminted.eu/guidelines_for_providers_of_sw_resources/recommended_schema_for_sw_resources.html) are required. Alvis  automatically generates some element instances of the schema (module name and presentation, input and output parameter description, etc.), some others currently need to be defined by hand (i.e., external resources, citation, etc.). Regardless of the method, what is important is to provide a valid XML description (against the schema) of the runnable modules.

For Alvis, a particular attention must be paid to the metadata related to the module execution. They are those used by the module during execution including command, input and output parameters. The command metadata (see [`command` element](https://guidelines.openminted.eu/components_command.html)) is similar to the command presented in the previous section, with the values of the parameters contained in variables referencing parameter names of the module. The plan is seen as an ancillary resource identified and localized with metadata element [`relatedResource`](https://guidelines.openminted.eu/compoments_relatedResource.md). 

The following command is a value for metadata element `command`. It assumes the existence of two parameters of the modules having values `incorpus` and `outdir` as instances of `parameterName` elements. It also assumes that the plan of the module is described as a ancillary resource (see [here](https://guidelines.openminted.eu/guidelines_for_providers_of_ancillary_resources/)  for how to fully describe an ancillary resource). 
```bash
docker run -i --rm -a stderr -v /path/to/OMTD_Workdir:/opt/alvisnlp/data mandiayba/alvisengine:1.0.0 
           alvisnlp
           -param read sourcePath ${incorpus}  # additional params can exist according to the component `read` 
           -param write outDir ${outdir} # additional params can exist according to the component  `write` 
	   -param WoSMiG ... # params can be added to the component `tomap` if required by the usage
           /path/to/the/relatedResource.plan # the plan defined for the module is provided as a related resource
```
{% blurb style='tip', title='Important notice' %}
We assume in the above command that OpenMinTeD will do the matching between the path to the mounted `OMTD_Workdir` and the paths to the input (and output) data.
{% endblurb %}

Each module parameter must be described in the metadata, at least with a name, a description, and a type (or format). That description, generated by Alvis, is required to feed the parameter values from OpenMinTeD forms.

## Package for OpenMinTeD
The minimal resources of the package are XML files containing the description and the plan of the module. You can add ancillary resources according to the description of the module.

{% blurb style='tip', title='Important notice' %}
We assume that the OpenMinTeD platform manages docker images and containers. The deployment of Alvis and its component will be transparent, even if it will be done with command `docker pull mandiayba/alvisengine:1.0.0`.
{% endblurb %}

