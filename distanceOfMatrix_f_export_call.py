# 
# python3 -m pip install wasmtime
# time wasmtime distanceOfMatrix_f_export.wasm 400 401
# time python3 distanceOfMatrix_f_export_call.py

import wasmtime.loader
import distanceOfMatrix_f_export
distanceOfMatrix_f_export.process(400) # somehow no print
