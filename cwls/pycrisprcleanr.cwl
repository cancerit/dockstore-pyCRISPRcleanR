#!/usr/bin/env cwl-runner

class: CommandLineTool

id: "pyCRISPcleanR"

label: "Dockerised pyCRISPcleanR for CrisprCas9 data analysis"

cwlVersion: v1.0
doc: |
    ![build_status](https://quay.io/repository/wtsicgp/dockstore-pycrisprcleanr)
    A Docker container for pyCRISPRCleanR command. See the [pyCRISPRcleanR](https://github.com/cancerit/pyCRISPRcleanR) website for more information.

dct:creator:
  "@id": " https://orcid.org/0000-0002-7638-2899"
  foaf:name: Shriram Bhosle
  foaf:mbox: "mailto:sb43@sanger.ac.uk"

requirements:
  - class: DockerRequirement
    dockerPull: "quay.io/wtsicgp/dockstore-pycrisprcleanr:1.0.0"

hints:
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 2048 #"the process requires at least 2G of RAM
    outdirMin: 2048

inputs:
  countfile:
    type: File
    doc: "sgRNA raw count file"
    inputBinding:
      prefix: -f
      position: 1
      separate: true
      shellQuote: true

  libfile:
    type: File
    doc: "sgRNA library file"
    inputBinding:
      prefix: -l
      position: 2
      separate: true
 
  run_mageck:
    type: boolean
    doc: "flag to run MAGeCK"
    inputBinding:
      prefix: -mk
      position: 3
      separate: true
  
  run_bagel:
    type: boolean
    doc: "flag to run BAGEL"
    inputBinding:
      prefix: -bl
      position: 4
      separate: true

  crispr_cleanr:
    type: boolean
    doc: "flag to run CRISPRcleanR"
    inputBinding:
      prefix: -cc
      position: 5
      separate: true

  plot_data:
    type: boolean
    doc: "Generate pdf and interactive plotly images"
    inputBinding:
      prefix: -pl
      position: 6
      separate: true

  num_processors:
    type: int
    default: 1
    doc: "Number of processors to use for parallel jobs"
    inputBinding:
      prefix: -np
      position: 7
      separate: true

  minreads:
    type: int
    default: 30
    doc: "minimum read count in control sample to be used for filtering"
    inputBinding:
      prefix: -mr
      position: 8
      separate: true

  mingenes:
    type: int
    default: 3
    doc: "minimum number of genes in a CNV segment to consider for normalization"
    inputBinding:
      prefix: -mg
      position: 9
      separate: true

  ncontrols:
    type: int
    default: 1
    doc: "Number of control samples in raw count file"
    inputBinding:
      prefix: -nc
      position: 10
      separate: true

  ignored_genes:
    type: string[]
    doc: "space separated list of ignored genes"
    inputBinding:
      prefix: -ig
      separate: true
      shellQuote: true
      position: 11

  outdir:
   type: Directory
   doc: "path to output folder"
   inputBinding:
      prefix: -o
      separate: true
      position: 12
  
  gene_signatures:
    type: Directory
    doc: "Directory path containing .txt files for signature genes"
    inputBinding:
      prefix: -gs
      separate: true
      position: 13

  numiter:
    type: int
    default: 1
    doc: "Number of bootstrap iterations for BAGEL (default 1000)"
    inputBinding:
      prefix: -N
      position: 14
      separate: true

outputs:
  output_data:
    type: Directory
    outputBinding:
      glob: $(inputs.outdir)

  output_log:
    type: File
    outputBinding:
      glob: "*.log"

baseCommand: ["pyCRISPRcleanR"]
