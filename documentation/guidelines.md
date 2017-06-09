


# HOWTO: Build an OpenMinTeD runnable component based on AlvisNLP/ML docker image

This document describes how to setup an OpenMinTeD runnable component from the AlvisNLP/ML workflow definitions.

We use the [AlvisNLP/ML framework](https://github.com/Bibliome/alvisnlp) packaged as a docker image (available on DockerHub) which includes all modules shipped with AlvisNLP/ML. The guidelines specifically describe how AlvisNLP/ML "plans" can be packaged and distributed as OpenMinTeD components.

## Requirements

* [docker](https://www.docker.com/) version 1.13.1
* a [AlvisNLP/ML docker image](https://github.com/openminted/alvis-docker)
* a filesystem with at least 4Gb available
* Basic XML and Java knowledge
* A functionning AlvisNLP/ML plan file as well as all the necessary resource files.

## AlvisNLP/ML Basics

[AlvisNLP/ML](https://github.com/Bibliome/alvisnlp) is a corpus processing engine that features a library of elementary modules, including a tokenizer, a sentence splitter, several POS-taggers and parsers, NER, relation extraction, machine learning modules, etc.

In AlvisNLP/ML terminology, the workflow definition is called a *plan*.
The plan file is an XML file that the user writes in order to specify the sequence of modules to run on the corpus and, for each module, the options, location of resources, and parameter values.
For details on how workflows are composed by writing plans, refer to the [AlvisNLP/ML: Writing plans guide](https://github.com/Bibliome/alvisnlp/wiki/Writing-plans).


<!-- Users run AlvisNLP/ML -->

<!--AlvisNLP
Before going further, let's define the notion of plan into Alvis. --> <!--A plan is a preconfigured receipt using the Alvis elementary components in order to define a specific runable module. These runnable modules are workflows but in this OpenMinTeD context they are seen as OpenMinTeD compatible modules. Thus, rather than composing several modules, a plan here lets us just adapt an Alvis module to an OpenMinTeD component by preparing the interface for its inputs, outputs and parameters.-->

<!--
## Define a runnable component with an Alvis plan
A plan for a runnable component is a XML file (with extension `.plan`) that contains 3 parts : a read part that configures the inputs, a write part that configures the outputs, and a process part that configures the task of the Alvis module being adapted as an OpenMinTeD runnable component.

The following plan adapts the Alvis module named `WoSMig` to an runnable component. `WoSMig` do tokenization of text documents. The plan is composed of the Alvis module `TextFileReader` to read text files, the module `TabularExport` to export the results as tabular forms, and the process module `WoSMig` doing the tokenization task. All runnable components are set in this way, it is just the `read` and `write` parts who changes according to the needs. The process modules to use are available into Alvis. Alvis also has several typical modules for the read and write parts (new modules can also be implemented, for example to convert new formats).
```xml
<alvisnlp-plan id="OMTD_WoSMig">
	<read class="TextFileReader"/>
	<annotation class="WoSMig"/>
	<write class="TabularExport"/>
</alvisnlp-plan>
```

You can feed values of parameters (that don't require to be used as input parameter of the component) into the plan. That has the double advantage of recording the optimal parameters and values and reducing for the end user the number of input parameters to consider. In the following modified plan parameters `ponctuations` and `balancedPuntuations` of module `WoSMig` are fed.
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
Note that, what interests us here is using the Alvis plans to make the Alvis modules compatible with OpenMinTeD. Plans are used in a general way to define complexe workflows. A more complete presentation of how to write plans is available [here](https://github.com/Bibliome/alvisnlp/wiki/Writing-plans). 
{% endblurb %}
-->

## Setting up the plan to run on a docker

In order to run properly inside a dock, we recommend to make the following amendments to the plan and resource files:

1. Gather all resources in a single-root directory structure, in the following we will call this root directory DATA. That means that all resource files, including the corpus, should be included in a subdirectory of DATA.

2. Change resource paths in the plan to paths relative to DATA.

That's it. Anyway those are recommended guidelines for all plans in any execution context.

## Running through docker

In this section we assume that an AlvisNLP/ML docker image has been set up.

```bash
docker run -i --rm -a stderr -v DATA:/opt/alvisnlp/data IMAGE:1.0.0 \ 
           alvisnlp \
	   -inputPath /opt/alvisnlp/data \
	   -param ... \
	   PLAN
```

* `-v` mounts your data directory (`DATA`) containing all resource in the dock. The `/opt/alvisnlp/data` directory inside the image is set by default in the AlvisNLP/ML image.
* `IMAGE` is an AlvisNLP/ML docker image.
* `alvisnlp` is the AlvisNLP/ML executable.
* `-inputPath` is a `alvisnlp` option that specifies where to look for relative paths.
* `PLAN` is the plan file.
* additional parameters can be specified with `-param` options.

<!--
Defining a plan requires you to know Alvis and its modules. However, most of the time you will be re-using existing plans that are created by the Alvis developers. To know which modules to use, you can ckeck in command line with a docker container using the following commands.
```bash
docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedModules # Alvis general help

docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedModules # list modules, including some typical readers and writers

docker run mandiayba/alvisengine:1.0.0 alvisnlp -supportedConversions # list more complex converters

docker run run mandiayba/alvisengine:1.0.0 alvisnlp -moduleDoc WoSMig # a user-document of component named `WoSMig` 
```
-->

## Describe the runnable component for OpenMinTeD

OpenMinTeD requires to provide a description based on the [OpenMinTeD Metadata Schema](https://guidelines.openminted.eu/the_omtd-share_metadata_schema.html) for each component.
At least, the [mandatory subset](https://guidelines.openminted.eu/guidelines_for_providers_of_sw_resources/recommended_schema_for_sw_resources.html) are required.

<!--
Alvis  automatically generates some element instances of the schema (module name and presentation, input and output parameter description, etc.), some others currently need to be defined by hand (i.e., external resources, citation, etc.). Regardless the method, what is important is to provide a valid XML description (against the schema) of the component.
-->

A particular attention is required for the metadata directly related to the component execution. They are those used to execute a component including command, input and output parameters. The command metadata (see [`command` element](https://guidelines.openminted.eu/components_command.html)) is similar to the command presented in the previous section, with the values of the parameters contained in variables referencing parameter names of the component. The plan is seen as an ancillary resource identified and localized with metadata element [`relatedResource`](https://guidelines.openminted.eu/compoments_relatedResource.md). 

The following command is a value of metadata element `command`. It assumes the existence of two parameters of the component having values `incorpus` and `outdir` as instances of `parameterName` elements. It also assumes that the plan of the component is described as a ancillary resource (see [here](https://guidelines.openminted.eu/guidelines_for_providers_of_ancillary_resources/)  for how to fully describe an ancillary resource). 
```bash
docker run -i --rm -a stderr -v DATA:/opt/alvisnlp/data IMAGE:1.0.0 \
           alvisnlp \\
           /path/to/the/relatedResource.plan # the plan defined for the module is provided as a related resource
```
{% blurb style='tip', title='Important notice' %}
We assume in the above command that OpenMinTeD will do the matching between the path to the mounted `OMTD_Workdir` and the paths to the input (and output) data.
{% endblurb %}

Each component parameter must be described in the metadata, at least with a name, a description, and a type (or format). That description, generated by the Alvis engine, is required to feed the parameter values from OpenMinTeD forms.

## The package for OpenMinTeD
The package will contain the two XML files representing the description and the plan of the component. Ancillary resources can be added according to the component.

{% blurb style='tip', title='Important notice' %}
We assume that the OpenMinTeD platform manages the docker images and containers. The deployment of the Alvis engine and its modules for the execution of the components will thus be implicit.
{% endblurb %}

