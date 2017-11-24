# Pull AlvisNLP image
FROM bibliome/alvisengine:2.0.0

# Set the working directory to /as-d
WORKDIR /as-d

# Copy AS-D workflows
COPY plans /as-d/plans/

# Get resources from Agroportal
WORKDIR /as-d/resources
RUN wget http://data.agroportal.lirmm.fr/ontologies/WHEATPHENOTYPE/submissions/4/download?apikey=1de0a270-29c5-4dda-b043-7c3580628cd5 -O WheatPhenotypeOntology.obo
    
# Get resources from the OMTD uc-tdm-AS-D repository
WORKDIR /as-d    
RUN wget https://github.com/openminted/uc-tdm-AS-D/archive/master.zip && \
    unzip master.zip && \
    cp uc-tdm-AS-D-master/resources/* /as-d/resources && \
    cp uc-tdm-AS-D-master/yatea.dtd /as-d/ && \
    unzip /as-d/resources/taxa+id_full.zip -d /as-d/resources/ && \
    rm -r uc-tdm-AS-D-master 

# Preprocess resources
RUN alvisnlp -verbose -entity ontofile WheatPhenotypeOntology.obo -entity outfile WheatPhenotypeOntology.tomap plans/ontology_analyzer.plan







