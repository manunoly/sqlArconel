from array import array

__author__ = 'manuel'

import os

# Open a file
path = "/home/manuel/Documents/BALTRA/"
dirs = os.listdir( path )

# This would print all the files and directories
datosPrev = ""
for file in dirs:
    if file.endswith('.rep'):
        current_file = os.path.join(path, file)
        data = open(current_file,'r')
        text = data.read()
        separadores = text.split(";")
#        print separadores

        for claveValor in  separadores:
            datos = claveValor.split(":")
            datosPrev = datosPrev + datos[1] + ";"

        datosPrev = datosPrev + " " + file + "\n"
datosPrev = str.replace(datosPrev,")","")
print datosPrev

