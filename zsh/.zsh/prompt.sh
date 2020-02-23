function prompt_singularity() {
  if [[ -z ${SINGULARITY_NAME+x} ]]; then
    return
  fi

  p10k segment -t "${SINGULARITY_NAME}"
}
