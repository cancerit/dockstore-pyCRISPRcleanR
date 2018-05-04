FROM  ubuntu:16.04
MAINTAINER  sb43@sanger.ac.uk

LABEL uk.ac.sanger.cgp="Cancer Genome Project, Wellcome Trust Sanger Institute" \
      version="0.1.1" \
      description="Tool to perform crisprCas9 data cleaning and qc"


USER root

ENV OPT /opt/wtsi-cgp
ENV PATH $OPT/bin:$PATH
ENV LD_LIBRARY_PATH $OPT/lib
ENV R_LIBS $OPT/R-lib
ENV R_LIBS_USER $R_LIBS


ENV PY_CRISPR $OPT/pycrispr

RUN adduser --disabled-password --gecos '' ubuntu && chsh -s /bin/bash && mkdir -p /home/ubuntu

COPY build/apt-build.sh build/
RUN bash build/apt-build.sh $PY_CRISPR

COPY build/rlib-build.R build/
RUN mkdir -p $R_LIBS_USER && Rscript build/rlib-build.R $R_LIBS_USER

# install requirements 
COPY requirements.txt build/
RUN pip3 install -r build/requirements.txt

#COPY pyCRISPRcleanR-1.1.1-py3-none-any.whl build/

#RUN pip3 install build/pyCRISPRcleanR-1.1.1-py3-none-any.whl
RUN pip3 install https://github.com/cancerit/pyCRISPRcleanR/releases/download/1.1.0/pyCRISPRcleanR-1.1.1-py3-none-any.whl

### security upgrades and cleanup
RUN apt-get -yq update && \
    apt-get -yq install unattended-upgrades && \
    unattended-upgrades

USER ubuntu

WORKDIR /home/ubuntu

CMD ["/bin/bash"]
