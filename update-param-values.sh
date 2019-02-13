    #!/bin/bash
## This script set the default default-param-values file
## it use an hand-made existing file, if it exists
## else create a new file

d_f=default-param-values.xml
FILE=$1
PREFIX=fr.inra.maiage.bibliome.alvisnlp.bibliomefactory.modules

    if [ -e "$d_f" ]; then
    	echo "File exists";
	cat $d_f > $FILE
    else 
    	echo "File does not exist, create one"
	## params values setting
	cat $FILE | \
	## xmi import
	xmlstarlet ed -d "//module[@class='$PREFIX.uima.XMIImport']/source" | \
	## xmi export
	xmlstarlet ed -u "//module[@class='$PREFIX.uima.XMIExport']/outDir" -v . | \
	xmlstarlet ed -u "//module[@class='$PREFIX.uima.XMIExport']/typeSystemFile" -v typesystem.xml | \
	## biolg ?not istalled
	xmlstarlet ed -d "//module[@class='$PREFIX.biolg.BioLG']/parserPath" | \
	xmlstarlet ed -d "//module[@class='$PREFIX.biolg.BioLG']/lp2lpExecutable" | \
	xmlstarlet ed -d "//module[@class='$PREFIX.biolg.BioLG']/lp2lpConf" | \
	## enju parser 
	xmlstarlet ed -d "//module[@class='$PREFIX.enju.EnjuParser']/enjuExecutable" | \
	## enju parser 2
	xmlstarlet ed -d "//module[@class='$PREFIX.enju.EnjuParser2']/enjuExecutable" | \
	## ccg parser params values setting
	xmlstarlet ed -u "//module[@class='$PREFIX.ccg.CCGParser']/executable" -v /alvisnlp/psoft/candc-1.00/bin/parser | \
	xmlstarlet ed -d "//module[@class='$PREFIX.ccg.CCGParser']/parserModel" | \
	xmlstarlet ed -d "//module[@class='$PREFIX.ccg.CCGParser']/superModel" | \
	## ccg postagger params values setting
	xmlstarlet ed -u "//module[@class='$PREFIX.ccg.CCGPosTagger']/executable" -v /alvisnlp/psoft/candc-1.00/bin/pos | \
	xmlstarlet ed -d "//module[@class='$PREFIX.ccg.CCGPosTagger']/model" | \
	## geniatagger params values setting
	xmlstarlet ed -u "//module[@class='$PREFIX.geniatagger.GeniaTagger']/geniaDir" -v /alvisnlp/psoft/geniatagger-3.0.2  | \
	## species tagger param setting
	xmlstarlet ed -u "//module[@class='$PREFIX.Species']/speciesDir" -v /alvisnlp/psoft/species_tagger/ | \
	## Ab3P param settings ?not istalled
	xmlstarlet ed -d "//module[@class='$PREFIX.ab3p.Ab3P']/installDir" | \
	## ChemSpotA param settings ?not istalled
	xmlstarlet ed -d "//module[@class='$PREFIX.chemspot.ChemSpotA']/cRFModel" | \
	xmlstarlet ed -d "//module[@class='$PREFIX.chemspot.ChemSpotA']/dictionary" | \
	## stanford param values setting
	## xmlstarlet ed -d "//module[@class='$PREFIX.stanford.StanfordNER']/classifierFile" | \
	## tees classify params values setting
	xmlstarlet ed -u "//module[@class='$PREFIX.tees.TEESClassify']/teesHome" -v /alvisnlp/psoft/tees/ | \
	## tees train params values setting
	xmlstarlet ed -u "//module[@class='$PREFIX.tees.TEESTrain']/teesHome" -v /alvisnlp/psoft/tees/ | \
	## wapiti label params values setting
	xmlstarlet ed -u "//module[@class='$PREFIX.wapiti.WapitiLabel']/wapitiExecutable" -v /usr/local/bin/wapiti | \
	## wapiti train params values setting
	xmlstarlet ed -u "//module[@class='$PREFIX.wapiti.WapitiTrain']/wapitiExecutable" -v /usr/local/bin/wapiti | \
	## treetagger
	xmlstarlet ed -u "//module[@class='$PREFIX.treetagger.TreeTagger']/treeTaggerExecutable" -v /alvisnlp/psoft/treetagger/bin/tree-tagger  | \
	xmlstarlet ed -d "//module[@class='$PREFIX.treetagger.TreeTagger']/parFile" | \
	## yatea params values setting
	xmlstarlet ed -u "//module[@class='$PREFIX.yatea.YateaExtractor']/yateaExecutable" -v /usr/local/bin/yatea  | \
	xmlstarlet ed -u "//module[@class='$PREFIX.yatea.YateaExtractor']/rcFile" -v res://yatea.rc | \
	#xmlstarlet ed -d //module[@class='$PREFIX.yatea.YateaExtractor']/rcFile" | \
	xmlstarlet ed -d "//module[@class='$PREFIX.yatea.YateaExtractor']/configDir" | \
	xmlstarlet ed -d "//module[@class='$PREFIX.yatea.YateaExtractor']/localeDir" | \
	## tomap params 
	xmlstarlet ed -u "//module[@class='$PREFIX.tomap.TomapTrain']/yateaExecutable" -v /usr/local/bin/yatea | \
	xmlstarlet ed -u "//module[@class='$PREFIX.tomap.TomapTrain']/rcFile" -v res://yatea.rc | \
	xmlstarlet ed -d "//module[@class='$PREFIX.tomap.TomapTrain']/configDir" | \
	xmlstarlet ed -d "//module[@class='$PREFIX.tomap.TomapTrain']/localeDir" | \
	## chemspot ?not istalled
	xmlstarlet ed -d "//module[@class='$PREFIX.chemspot.Chemspot']/chemspotDir" | \
	## Word2Vec ?not istalled
	xmlstarlet ed -u "//module[@class='$PREFIX.contes.Word2Vec']/contesDir" -v /alvisnlp/psoft/CONTES | \
	xmlstarlet ed --subnode "//module[@class='$PREFIX.contes.Word2Vec']" --type elem -n python3Executable | \
	xmlstarlet ed -u "//module[@class='$PREFIX.contes.Word2Vec']/python3Executable" -v /root/miniconda3/envs/contesenv/bin/python3.6 | \
	xmlstarlet ed -d "//module[@class='$PREFIX.contes.Word2Vec']/workers" | \
	## ContesTrain ?not istalled
	xmlstarlet ed -u "//module[@class='$PREFIX.contes.ContesTrain']/contesDir" -v /alvisnlp/psoft/CONTES | \
	xmlstarlet ed --subnode "//module[@class='$PREFIX.contes.Word2Vec']" --type elem -n python3Executable | \
	xmlstarlet ed -u "//module[@class='$PREFIX.contes.ContesTrain']/python3Executable" -v /root/miniconda3/envs/contesenv/bin/python3.6 | \
	## ContesPredict ?not istalled
	xmlstarlet ed -u "//module[@class='$PREFIX.contes.ContesPredict']/contesDir" -v /alvisnlp/psoft/CONTES | \
	xmlstarlet ed --subnode "//module[@class='$PREFIX.contes.Word2Vec']" --type elem -n python3Executable | \
	xmlstarlet ed -u "//module[@class='$PREFIX.contes.ContesPredict']/python3Executable" -v /root/miniconda3/envs/contesenv/bin/python3.6 | \
	tee $FILE
    fi
