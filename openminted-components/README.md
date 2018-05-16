# Recap of the deployment of the Alvis components 

> [this issue is opened to track the tests](https://github.com/openminted/alvis-docker/issues/10)   /!\



| Component capsule on github | Local validation | public link on OMTD Registry | Tests on OMTD Registry | Remarks |
| ------------- | ------------- | --------------------- |-------------|----------------|
| [Alvis Segmenter](segmenter/) | success  | [Alvis Segmenter 2](https://test.openminted.eu/landingPage/component/62bd4ee3-5476-4343-b27b-ac65d8dba385) | [successed one time but was not possible to remake it](https://github.com/openminted/alvis-docker/issues/10#issuecomment-386676078) |  |
| [ToMap](tomap/) | success | [Alvis ToMap](https://test.openminted.eu/landingPage/application/6fb92855-4afe-4846-85a4-8d391e2999af) | [worked but display failed](https://github.com/openminted/alvis-docker/issues/10#issuecomment-388838168) | |
| [GeniaTagger](geniatagger/)  | success | [Alvis GeniaTagger](https://test.openminted.eu/landingPage/component/2cb79581-8629-412e-ba7c-51a4b6c5bb19) | failed, there was a problem of AAI communication  | similar to ToMap |
| [RDFProjector](rdfprojector/) | success | [Alvis RDFProjector](https://test.openminted.eu/landingPage/component/1e382d21-8669-45ef-8415-3f9e1ecff3bf) | failed | similar to ToMap |
| [RegExp](regexp/)  | success | [Alvis RegExp](https://test.openminted.eu/landingPage/component/ed724697-a907-4140-ac83-9aa485375ce4) | failed | similar to ToMap |
| [Wheat Phenotypic Information Extractor](uc-tdm-as-d/) | success | [Wheat Phenotypic Information Extractor](https://test.openminted.eu/landingPage/application/ba29d568-b9e3-4ff5-b875-65ddbf4d5ecb) |  failed |  |
| [Habitat-Phenotype Relation Extractor for Microbes](uc-tdm-as-c/) | success | private component on OMTD | failed | similar to Wheat Phenotypic Information Extractor |
| [Arabidopsis Gene Regulation Extractor](uc-tdm-as-e/) | success | private component on OMTD | failed | similar to Wheat Phenotypic Information Extractor |

