# Guidelines for deploying a Alvis component based on docker
An Alvis instance exists as a docker image. The image is packaged with all required to run Alvis and its components.

{% blurb style='tip', title='Important notice' %}
This document assumes you have docker intalled in your machine and your machine have 4Go of free space. You will need manage XML files.
{% endblurb %}

The rest of the document will describe how to abstract component from Alvis plan and how the component will be deployed into OpenMinTeD.

Before going further, let's define the Alvis plans. A plan is a preconfigured receipt on Alvis elementary modules in order to define a specific module. The specific modules obtained can be seens as workflows but in the context of OpenMinTeD they will be OpenMinTeD compatible modules. g an alvis plan

## Preparing the component description


