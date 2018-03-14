# Internal Guidelines for OMTD acceptable Components / use case execution

#### Objective
Objective: This document aims to provide  guidelines and best practices for exposing on OpenMinTed components based on AlvisNLP/ML.

Following points / items need to be taken care before executing an OpenminTeD platform acceptable componenets component / use cae in the OpenMinTeD platform.
 1. Plan specifications and resource management
 2. Test data preparation
 3. Dockerfile creation
 4. Metadata creation
 5. Registration on on OMTD

In below we emphasize on the few eminent parts of the process in a bit detail.
 
#### 1. Dockerization
The whole process of dockerizing a component or use case takes a list off steps one by one as described in below.
##### i.  Install docker
Docker is a container platform provider to address  almost every application across the hybrid cloud and very effective and efficieent.
Installation of docker based is needed and detailed installation guidelines are provided [here](https://docs.docker.com/install/). Before installation prequistes should be checked and installed accordingly.

##### ii. Create a dockerfile

Dockerfile contains the set of instructions needed for dockerization and create a docker image. 
The recommended practice is to create a dockerfile based on the basic AlvisNLP component (generic one) or create based on some component which in turn hierarchially based on the generic one.
###### A. Build upon the generic AlvisNLP docker
Following is the primitive most code for building a docker based on genreric most AlvisNLP component based docker


    // Some comments
    #FROM maven:3.2-jdk-7-onbuild
    FROM bibliome/alvisengine:2.1.0     
    MAINTAINER Mouhamadou Ba <mouhamadou.ba@inra.fr>
    
    WORKDIR /alvisnlp
    
    COPY test-data/plans/alvis.segmentation.plan /alvisnlp/
    
    CMD ["alvisnlp"]
    

###### B. Build upon existing existing AlvisNLP suite component based docker
This is the hierarchical building process where the basic one at the end of the hierarchy is the generic AlvisNLP component.
This type is advised to build for complex and advanced use cases which needs multiple AlvisNLP components and intricate parameters and resources in ensemble.


##### iii. Commands to insert internal resources
Two commands are used inserting internal resources : ADD and Copy.
https://github.com/openminted/alvis-docker/edit/master/documentation/InternalGuidelinev4.md
The ADD instruction copies new files, directories or remote file URLs from source and adds them to the filesystem of the image at the path provided as destination where as the COPY command copies new files or directories from source and adds them to the filesystem of the container at the path provided as destination.

Here is the [link](https://docs.docker.com/engine/reference/builder/#add) for ADD  command in detail, while here is the [link](https://docs.docker.com/engine/reference/builder/#copy) for the COPY.
##### iv. Generate the docker image
BUILD command is used for generating docker image and here is the [link](https://docs.docker.com/engine/reference/builder/#usage) to the documentation for the command.

##### v. Test the image
Testing of the generated docker image is done through test-data and regarding this is explained in the "test" section in bellow.
##### vi. Registeration on DockerHub
PUSH is the command for pushing and image or repository to the registry / dockerhub. Here is the [link](https://docs.docker.com/engine/reference/commandline/push/) for details on the command.
#### 2. Metadata
The metadata should either be provided in XML format or it could be entered through the OpenMinTeD form when registering the component / use case; but for good practice preparing the xml file is advised.
Here is the [link](https://guidelines.openminted.eu/the_omtd-share_metadata_schema.html) to the metadta schema and related documentaion. 

There are many properties which specifies the resources to be brought in. Three kinds of specifications on these properties are followed :
######
+ Manadatory
+ Recommended
+ Optional

 The details of these could be found in the link provided last.


A template for this is included in the Appendix I section of this document.

#### 3. Test data 
A ‘test-data’ folder should be created under the base / home directory of the dockerized project component / use case and all the test data should be placed inside that folder.

After dockerization of the component / use case the test could be run using the above mentioned 'test-data'.

To **run the test**, the following format of **docker command** is used : docker run -i --rm -v $TESTDATAMOUNT -a stderr $COMPONENTS --$PARAMETRES

+ In above $TESTDATAMOUNT means the format required for mounting the test data so that the docker can use viz. $PWD/test-data:/alvisnlp/data is an example of such.

+ In above $COMPONENETS signify the component or components is intende to run.

+ In above $PARAMETERS mean the list of parameters needed for the dockerized component to run.

For example here is an specific execution command for the test-data for the alvis-br-train component following the above format :

```command
docker run -i --rm -v $PWD/test-data:/alvisnlp/data -a stderr \
bibliome/alvis-br-train \
alvisnlp org.bibliome.alvisnlp.modules.tees.alvis-br-train \
--input /alvisnlp/data/corpus \
--output /alvisnlp/data/models \
--param:train=/alvisnlp/data/corpus/train \
--param:dev=/alvisnlp/data/corpus/dev \
--param:test=/alvisnlp/data/corpus/test \
--param:modelTargetDir=/alvisnlp/data/models
```

#### 4. Plans
Plans actually provide the whole plan fr executing the use cases; Use cases comprise of one component or sequential ensemble of multiple components. Practically one component should be coded as a plan for the basic one componenet plans. The plan contains the AlvisNlp component specifications, resources and parameters. Following are some guidelines for creating plans.

+ The plan should begin with an XMI reader at the beginning and XMI writer at the end. here is the [link](https://bibliome.github.io/alvisnlp/reference/module/fr.inra.maiage.bibliome.alvisnlp.bibliomefactory.modules.uima.XMIImport) to the XMIImport and here is the [link](https://bibliome.github.io/alvisnlp/reference/module/fr.inra.maiage.bibliome.alvisnlp.bibliomefactory.modules.uima.XMIExport) for the XMIExport.
+ The parameters can’t be embedded anywhere inside the plan ; they need to be isolated in a section.

+ The aliases from the parameters needs to be declared clearly. Component parameters are exposed as plan-level parameters.

+ Make sure each parameter follows the OMTD acceptable formats. TFollowing are the accpetable parameter types.
 **Primitves:**  Boolean, Character, Double, Integer, Long, String .
 **Files:** ExecutableFile, File, InputDirectory, InputFile, OutputDirectory, OutputFile, SourceStream, TargetStream, WorkingDirectory
**Misc: ** Pattern, any type that has a straight forwardd string conversion
**Ensemble:** Array and Mapping

+ While declaring / making external resources available, a folder under working home directory named as resources (as $home/resources/) needs to be created and all the resource files should be stored there. This relative path of $home/resources/ would be ported to OMTD platform.
These are resources indispensable for any use of the component.
Internal resources will never be exposed to the user in OMTD.

+ A thought should be provided on deciding which resources should be kept internal to the component and which ones thrown as parameters. Following are some gudelines / tactics for such.

**Evaluate the input/output:**
- There must be an alias named “input” for the “source” parameter of the XMIImport module. 
Reference Code:
```command 
<param name="input">
    <alias module="read" param="source"/>
  </param>

<read class="XMIImport" />
```

- Output files/dirs should not be exposed as parameters. But output files/directories should be relative.
**Parameters exposed as alias should:**

- have a significant impact on the component behavior (avoid parameter fine-tuning)

- make sense to a user, record the expertise level necessary to understand the parameter

- resource parameters should clearly record the file formats and size limit.





