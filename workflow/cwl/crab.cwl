#!/usr/bin/env cwl-runner

arguments:
- -c
- id; export HOME_OVERRRIDE=/tmp; mkdir -pv $HOME_OVERRRIDE; source /init.sh; source
  /etc/bashrc; nbrun /repo/crab.ipynb $@
baseCommand: bash
class: CommandLineTool
cwlVersion: v1.0
id: crab
inputs:
- id: t1
  inputBinding:
    prefix: --inp-t1=
    separate: false
  type: string
- id: t2
  inputBinding:
    prefix: --inp-t2=
    separate: false
  type: string
- id: nscw
  inputBinding:
    prefix: --inp-nscw=
    separate: false
  type: int
- id: chi2_limit
  inputBinding:
    prefix: --inp-chi2_limit=
    separate: false
  type: float
- id: systematic_fraction
  inputBinding:
    prefix: --inp-systematic_fraction=
    separate: false
  type: float
outputs:
- doc: summary of the verification, contains status
  id: summary
  type: string
- doc: all results of model fitting
  id: fit_results
  type: string
- doc: fit results grouped by software version
  id: crab_by_osa
  type: string
- doc: acceptable fit folded model
  id: good_fit_png
  type: string
- doc: acceptable fit folded model png b64
  id: good_fit_png_content
  type: string
- doc: the best tested unacceptable fit folded model
  id: next_good_fit_png
  type: string
- doc: the best tested unacceptable fit folded model png b64
  id: next_good_fit_png_content
  type: string
requirements:
  DockerRequirement:
    dockerPull: docker.io/reanahub/reana-demo-cdci-crab-pulsar-integral-verification
