function prompt_apptainer() {
  if [[ -n ${APPTAINER_NAME+x} ]]; then
    p10k segment -t "${APPTAINER_NAME}"
  elif [[ -n ${SINGULARITY_NAME+x} ]]; then
    p10k segment -t "${SINGULARITY_NAME}"
  fi
}
