# Especificamos que se trata de un script ejecutable que debe ser interpretado con bash
#!/bin/bash

# Se guarda la ruta del archivo a evaluar en la variable FILE
FILE="/Users/norniella_jamart/curso2024/plasmids_final.txt"
# Se guarda únicamente el nombre del archivo en una variable nueva
nombre=$(basename "$FILE")

# Se elabora la condicional para comprobar la presencia o no del archivo
if [ -f "$FILE" ]; then
echo "El fichero $nombre existe"; # Output en pantalla si el archivo existe
else 
echo "El fichero $nombre no existe" # Output en pantalla si el archivo no existe
fi

# Se indica que finaliza la ejecución del script
exit