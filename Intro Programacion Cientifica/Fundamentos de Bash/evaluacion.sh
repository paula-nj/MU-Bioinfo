# Especificamos que se trata de un script ejecutable que debe ser interpretado con bash
#!/bin/bash

if [ "$1" -lt 5 ]; then
echo "Nota definitiva: Suspenso ($1)"; # Output en el caso de que la nota sea menor que 5
elif [[ "$1" -ge 5 && "$1" -lt 7 ]]; then
echo "Nota definitiva: Aprobado ($1)"; # Output en el caso de que la nota sea mayor o igual a 5 y menor que 7
elif [[ "$1" -ge 7 && "$1" -lt 9 ]]; then
echo "Nota definitiva: Notable ($1)"; # Output en el caso de que la nota sea mayor o igual a 7 y menor que 9
elif [[ "$1" -ge 9 && "$1" -le 10 ]]; then
echo "Nota definitiva: Sobresaliente ($1)"; # Output en el caso de que la nota sea mayor o igual a 9 y menor o igual a 10
else
echo "Introducir valor numérico válido (0-10)" # Output en el caso de que se introduzca algún valor fuera de los rangos marcados
fi

# Se indica que finaliza la ejecución del script
exit
