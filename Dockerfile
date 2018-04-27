FROM  ubuntu:16.04

MAINTAINER  sb43@sanger.ac.uk

LABEL uk.ac.sanger.cgp="Cancer Genome Project, Wellcome Trust Sanger Institute" \
      version="0.1.1" \
      description="Tool to perform crisprCas9 data cleaning and qc"

USER  root

ENV OPT /opt/wtsi-cgp
ENV PATH $OPT/bin:$PATH
ENV R_LIBS_USER=$OPT/R-lib 

RUN mkdir -p $OPT/bin

COPY build/apt-build.sh build/
RUN bash build/apt-build.sh

COPY build/opt-build.sh build/
RUN bash build/opt-build.sh $OPT

RUN addgroup -S cgp && adduser -G cgp -S cgp

USER cgp
WORKDIR /home/cgp

CMD ["/bin/bash"]
