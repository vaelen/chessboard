#!/bin/bash

do_test () {
  # Arguments
  local PROGRAM=${1}
  local PIECE=${2}
  local START=${3}
  local CORRECT=${4}

  echo "Test: ${PROGRAM} ${PIECE} ${START}"

  # Run Test
  local OUTPUT=`${PROGRAM} ${PIECE} ${START}`

  # Print Results
  if [ "${OUTPUT}" != "${CORRECT}" ]
  then
    echo "    Failure: ${PROGRAM} ${PIECE} ${START}"
    echo "        Expected: ${CORRECT}"
    echo "        Received: ${OUTPUT}"
  else
    echo "    Success"
  fi
  echo
}

test_program() {
  # Arguments
  local PROGRAM=${1}

  local START="d2"

  local PIECE="rook"
  local CORRECT="a2, b2, c2, d1, d3, d4, d5, d6, d7, d8, e2, f2, g2, h2"
  do_test "${PROGRAM}" "${PIECE}" "${START}" "${CORRECT}"

  local PIECE="queen"
  local CORRECT="a2, a5, b2, b4, c1, c2, c3, d1, d3, d4, d5, d6, d7, d8, e1, e2, e3, f2, f4, g2, g5, h2, h6"
  do_test "${PROGRAM}" "${PIECE}" "${START}" "${CORRECT}"

  local PIECE="knight"
  local CORRECT="a4, b5, f5, g4"
  do_test "${PROGRAM}" "${PIECE}" "${START}" "${CORRECT}"
}

test_program ruby/chessboard.rb
