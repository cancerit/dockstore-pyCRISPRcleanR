#!/usr/bin/env cwl-runner

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/
  s: http://schema.org/

$schemas:
- http://schema.org/docs/schema_org_rdfa.html
- http://dublincore.org/2012/06/14/dcterms.rdf
- http://xmlns.com/foaf/spec/20140114.rdf

class: CommandLineTool

id: "pyCRISPcleanR"

label: "Dockerised pyCRISPcleanR for CrisprCas9 data analysis"

cwlVersion: v1.0

doc: |
    ![build_status](https://quay.io/repository/wtsicgp/dockstore-pycrisprcleanr/status)
    A Docker container for pyCRISPRCleanR command. See the [pyCRISPRcleanR](https://github.com/cancerit/pyCRISPRcleanR) website for more information.

dct:creator:
  "@id": "https://orcid.org/0000-0002-7638-2899" 
  foaf:name: Shriram Bhosle
  foaf:mbox: "mailto: sb43@sanger.ac.uk"

requirements:
  - class: DockerRequirement
    dockerPull: "quay.io/wtsicgp/dockstore-pycrisprcleanr:2.0.12"

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
  
  numiter:
    type: int
    default: 1
    doc: "Number of bootstrap iterations for BAGEL (default 1000)"
    inputBinding:
      prefix: -N
      position: 5
      separate: true

  crispr_cleanr:
    type: boolean
    doc: "flag to run CRISPRcleanR"
    inputBinding:
      prefix: -cc
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
   type: string 
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

outputs:
  
  output_results:  
    type: File
    outputBinding:
      glob: $(inputs.outdir)/results.tar.bz2

  output_log:
    type: File
    outputBinding:
      glob: "*.log"

baseCommand: ["pyCRISPRcleanR"]

s:codeRepository: https://github.com/cancerit/dockstore-pyCRISPRcleanR 
s:license: https://spdx.org/licenses/AGPL-3.0-only
s:citation: doi-10.1186/s12859-016-1015-8
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-7638-2899 
    s:email: mailto:cgphelp@sanger.ac.uk
    s:name: Shriram Bhosle
