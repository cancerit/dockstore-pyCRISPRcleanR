FROM  ubuntu:16.04
MAINTAINER  cgphelp@sanger.ac.uk

LABEL uk.ac.sanger.cgp="Cancer Genome Project, Wellcome Sanger Institute" \
      version="2.0.14" \
      description="Tool to perform crisprcleaner analysis"



USER root

ENV CRISPR_VER 2.1.0
ENV OPT /opt/wtsi-cgp
ENV PATH $OPT/bin:$PATH
ENV LD_LIBRARY_PATH $OPT/lib
ENV R_LIBS $OPT/R-lib
ENV R_LIBS_USER $R_LIBS

RUN mkdir -p $R_LIBS_USER
# install system tools
RUN apt-get update && \
  apt-get install -yq --no-install-recommends lsb-release && \
  echo "deb http://cran.rstudio.com/bin/linux/ubuntu $(lsb_release -cs)/" \
  >> /etc/apt/sources.list && \
  gpg --keyserver keyserver.ubuntu.com --recv-key E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
  gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | apt-key add - && \
  apt-get update && \
  apt-get install -qy --no-install-recommends \
    apt-transport-https \
    locales \
    libcairo2-dev \
    r-base \
    r-base-dev \
    python3  \
    python3-dev \
    python3-setuptools \
    python3-pip \
    python3-wheel \
    unattended-upgrades && \
    unattended-upgrade -d -v && \
    apt-get remove -yq unattended-upgrades && \
    apt-get autoremove -yq

RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

RUN R -e 'source("http://bioconductor.org/biocLite.R"); biocLite(c("DNAcopy","pROC","PRROC","graphics"), ask=FALSE, lib="'"${R_LIBS_USER}"'")'

COPY requirements.txt $OPT/requirements.txt
RUN pip3 --no-cache-dir install -r $OPT/requirements.txt
# need to build seprately for mageck without --no-cache-dir option
RUN pip3 install https://sourceforge.net/projects/mageck/files/0.5/mageck-0.5.7.tar.gz

# install crisprcleanr
RUN pip3 --no-cache-dir install https://github.com/cancerit/pyCRISPRcleanR/releases/download/${CRISPR_VER}/pyCRISPRcleanR-${CRISPR_VER}-py3-none-any.whl

### security upgrades and cleanup
RUN apt-get -yq update && \
    apt-get -yq install unattended-upgrades && \
    unattended-upgrades

RUN adduser --disabled-password --gecos '' ubuntu && chsh -s /bin/bash && mkdir -p /home/ubuntu

USER ubuntu

WORKDIR /home/ubuntu

CMD ["/bin/bash"]
