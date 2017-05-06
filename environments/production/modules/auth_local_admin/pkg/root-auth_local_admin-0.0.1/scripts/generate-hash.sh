#!/bin/bash
python -c 'import crypt; crypt.crypt("$1", crypt.mksalt(crypt.METHOD_SHA512))'
