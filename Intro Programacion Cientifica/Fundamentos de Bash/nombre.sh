# Especificamos que se trata de un script ejecutable que debe ser interpretado con bash
#!/bin/bash

# Se crea una condicional para informar sobre valor a introducir
if [ -z "$1" ]; then
echo "Es necesario introducir argumento"; # Output si no se escribe nada
else
echo "Soy $1, y me gusta el máster de bioinformática"; # Output si se escriben caracteres como argumento
fi

# Se indica que finaliza la ejecución del script
exit

