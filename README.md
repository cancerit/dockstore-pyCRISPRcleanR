Dockersised [pyCRISPRcleanR] for Dockstore

[![Docker Repository on Quay]("Quay")]

# dockstore-pyCRISPRcleanR
| Master                                              | Develop                                               |
| --------------------------------------------------- | ----------------------------------------------------- |
| [![Master Badge][travis-master-badge]][travis-repo] | [![Develop Badge][travis-develop-badge]][travis-repo] |


This project wraps pyCRISPRcleanR into a Dockstore tool.

<!-- TOC depthFrom:2 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->
 - [Required inputs are](#required-inputs-are)
 - [Release process](#release-process)
 - [LICENSE](#LICENSE)

Required inputs are:

1. ```gRNA Counts``` file: tab separated file containing following fields
   sgRNA  gene  <control_count 1...N> <sample_count 1..N>
2. ```sgRNA library``` file format with following mandatory columns
   sgRNA  gene  chr  start  end 

For additional optional inputs please refer pyCRISPRcleanR --help 

## Release process

This project is maintained using HubFlow.

1. Make appropriate changes
2. Bump version in `Dockerfile` and `Dockstore.cwl`
3. Push changes
4. Check state on Travis
5. Generate the release (add notes to GitHub)
6. Confirm that image has been built on [quay.io]
7. Update the [dockstore] entry, see [dockstore-docs]

## LICENCE

Copyright (c) 2018 Genome Research Ltd.

Author: Cancer Genome Project <cgpit@sanger.ac.uk>

This file is part of dockstore-cgp-irap.

dockstore-cgp-irap is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation; either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

1. The usage of a range of years within a copyright statement contained within this distribution should be interpreted as being equivalent to a list of years including the first and last year specified and all consecutive years between them. For example, a copyright statement that reads ‘Copyright (c) 2018-2019’ should be interpreted as being identical to a statement that reads ‘Copyright (c) 2018, 2019’."

<!--refs-->
 [pyCRISPRcleanR]: https://github.com/cancerit/pyCRISPRcleanR
 [travis-master-badge]: https://travis-ci.org/cancerit/dockstore-pyCRISPRcleanR.svg?branch=master
 [travis-develop-badge]: https://travis-ci.org/cancerit/dockstore-pyCRISPRcleanR.svg?branch=develop
 [travis-repo]: https://travis-ci.org/cancerit/dockstore-pyCRISPRcleanR
 [pyCRISPRcleanR-releases]: https://github.com/cancerit/dockstore-pyCRISPRcleanR/releases
 [Quay]: https://quay.io/repository/wtsicgp/dockstore-pycrisprcleanr/status
 [quay.io]: https://quay.io/repository/wtsicgp/dockstore-pycrisprcleanr?tab=builds
 [Quay]: https://quay.io/repository/wtsicgp/dockstore-pycrisprcleanr/status
 [dockstore]: https://dockstore.org/containers/quay.io/wtsicgp/dockstore-pycrisprcleanr
 [dockstore-docs]: https://dockstore.org/docs/getting-started-with-dockstore

