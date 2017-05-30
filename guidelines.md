# Guidelines for deploying a Alvis component based on docker
An Alvis instance exists as a docker image. The image is packaged with all required to run Alvis and its components.

{% blurb style='tip', title='Important notice' %}
This document assumes you have docker intalled in your machine and your machine have 4Go of free space. You will need manage XML files.
{% endblurb %}

The rest of the document will describe how to abstract component as OpenMinTeD modules from Alvis plan and how the OpenMinTeD modules are deployed.

Before going further, let's define the Alvis plans. A plan is a preconfigured receipt on Alvis elementary components in order to define a specific modules. The obtained modules can be seen as workflows but in the context of OpenMinTeD they will be compatible OpenMinTeD modules. The plans thus lets us adapt the Alvis modules to OpenMinTeD modules by, for example, configuring the formats of the inputs/outputs and adapting parameters to requirements.

## Preparing an Alvis Plan
An alvis plan is a xml file with extension `.plan` that contains 3 parts : a reader part that configures the inputs, a writer part that configures the outputs, and the main part that specify the module specific task.

The following plan adapt the Alvis component `WoSMig` to a OpenMinteD module. `WoSMig` do tokenization of text documents. The plan is composed of the elementary Alvis component `TextFileReader` that reads text files, the elementary component `TabularExport` exporting results to a tabular form, and the module `WoSMig` doing the tokenization task.

```
<alvisnlp-plan id="OMTD_WoSMig">

<read class="TextFileReader">
</read>

<annotation class="WoSMig">
</annotation>

<write class="TabularExport">
</write>

</alvisnlp>
```

The parameter values that don't need to be passed to conserned components as input values can be directly set into the plan as follow for component `WoSMig`. That has the double advantage of saving optimal parameters and reducing for the end user the number of parameters to consider.


```
...

<annotation class="WoSMig">
  <ponctuations>?.!;,:-</pontuations>
  <balancedPunctuations>()[]{}""</balancedPunctuations>
</annotation>

...
```

{% blurb style='tip', title='Important notice' %}
Note that, what interests us here is using Alvis plans to make the Alvis modules compatible with OpenMinTeD. Plans are used in a general way to define complexe modules and workflows. A more complete presentation on how to write a plan is available [here](https://github.com/Bibliome/alvisnlp/wiki/Writing-plans). 
{% endblurb %}

Defining a plan requires you to know Alvis and its components. However, most of the time you will be re-using existing plans that are created by the Alvis developers.


## Preparing the component description

After the previous step, you have defined a runnable module. It can be executed with the following command. 

```
docker run -i --rm -v $PWD/workdir:/opt/alvisnlp/data -a stderr mandiayba/alvisengine:1.0.0 
           alvisnlp
           -param read sourcePath /path/to/the/text/files  # other params can be add to the component *read* 
           -param write outDir /path/to/the/directory/where/to/write/output # other params can be add to the component *read* 
	   -param WoSMiG ... # params can be added to the component *tomap* if required by the usage
           /path/to/the/plan.plan
```

The previous command can be executed directly into a shell. But before defining the command, we need at least to know what are the functionalies and the parameters of the modules. It is why it is required into OpenMinTeD for each module to provide its description including functionalies and parameters. Thus, we use [OMTD Schema](https://guidelines.openminted.eu/the_omtd-share_metadata_schema.html) to describe the modules. We describe each all [mandatory elements of the OMTD Schema](https://guidelines.openminted.eu/guidelines_for_providers_of_sw_resources/recommended_schema_for_sw_resources.html). Some element values (module name and presentation, input and output parameter description, etc.) already existing into Alvis, hence they are automatically generated from Alvis. Some other values need currently to be provided by hand (i.e., external resources, citation, etc.).

When describing a module, a particular attention must be paid to the metadata related to the module execution. They are those used by the module during execution including command, type system, inputs/outputs, etc. The command metadata (see [`command` element](https://guidelines.openminted.eu/components_command.html)) is a rewritten of the command presented above, where the values of the parameters are contained in variables referencing the parameters of the module.  

```
docker run -i --rm -v $PWD/workdir:/opt/alvisnlp/data -a stderr mandiayba/alvisengine:1.0.0 
           alvisnlp
           -param read sourcePath ${incorpus}  # other params can be add to the component *read* 
           -param write outDir ${outdir} # other params can be add to the component *read* 
	   -param WoSMiG ... # params can be added to the component *tomap* if required by the usage
           /path/to/the/plan.plan
```

The variable 
