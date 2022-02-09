#!/bin/bash
base_dir=$(cd "$(dirname "$0")";pwd)
sed -i 's/,]/]/g'  ${base_dir}/cpumem_result.json
sed -i 's/,]/]/g'  ${base_dir}/other_result.json
