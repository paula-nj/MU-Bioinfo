## Ejercicio 1 - Nombre del usuario actual y nombre del sistema
whoami 
uname -a

## Ejercicio 2 - Versión de Bash utilizada
bash --version

## Ejercicio 3 - Directorio de trabajo actual, crear 3 subdirectorios
pwd
mkdir "curso2024" "curso2025" "UNIR"

## Ejercicio 4 - Crear en "UNIR" 10 ficheros "Fichero1.txt"... De dos formas posibles
# Opción 1
touch UNIR/Fichero{1..10}.txt
# Opción 2
for i in {1..10}; do touch UNIR/Fichero$i.txt; done

## Ejercicio 5 - Elimina directorios "UNIR" y "curso2025" con rmdir
rmdir "UNIR" "curso2025"
# Directorio UNIR no puede eliminarse porque contiene archivos
rm -r "UNIR"

## Ejercicio 6 - Descargar fichero en directorio "curso2024" a través del enlace, indica dos formas de acceder a la ayuda del comando
man wget
wget -h
wget -O curso2024/"plasmids.txt" https://ftp.ncbi.nlm.nih.gov/genomes/GENOME_REPORTS/plasmids.txt

## Ejercicio 7 - Listado del directorio actual, permisos del fichero plasmids.txt y tamaño en Mb
man ls
ls -lh curso2024/plasmids.txt #Permisos - usuario: leer y escribir (r-w) grupo y todos: leer (r); tamaño de archivos en formato legible (7.2Mb)

## Ejercicio 8 - Comprime y descomprime fichero en .tar y .gz sin modificar original
# Comprimir en formato .tar
mkdir "archivo_descomprimido" 
tar -cvf plasmids.tar plasmids.txt
tar -xvf plasmids.tar -C archivo_descomprimido
# Comprimir en formato .gz
gzip -c plasmids.txt > plasmids.txt.gz
gunzip -c plasmids.txt.gz > archivo_descomprimido/plasmids2.txt

## Ejercicio 9 - Nuevo archivo plasmids_final.txt con las últimas 8 líneas del original
cd curso2024
tail -n 8 plasmids.txt > plasmids_final.txt

## Ejercicio 10 - Muestra las 4 primeras filas del archivo plasmids_final.txt
head -n 4 plasmids_final.txt

## Ejercicio 11 - Combina los pasos 9 y 10 utilizando operadores lógicos
# && AND - ejecuta el segundo comando solo si el primero se ejecuta bien
# || OR - ejecuta el segundo comando solo si el primero se ejecuta mal
# ; secuencial - ejecuta el segundo comando independientemente del resultado en comandos previos
tail -n 8 plasmids.txt > plasmids_final.txt && head -n 4 plasmids_final.txt || echo "Error"

## Ejercicio 12 - Contar en archivo plasmids.txt: genomas de Klebsiella michiganensis, de Pantoea agglomerans, líneas y caracteres
wc -lc plasmids.txt #59388 7566137
grep -c "Klebsiella michiganensis" plasmids.txt #225
grep -c "Pantoea agglomerans" plasmids.txt #148

## Ejercicio 13 - Shell script de bash dormir.sh
nano dormir.sh
ls -l dormir.sh
chmod a+x dormir.sh
./dormir.sh

## Ejercicio 14 - Cambiar permisos de dormir.sh
# Quitar todos los permisos del archivo
chmod a-rwx dormir.sh
chmod 000 dormir.sh
# Permiso de lectura, escritura y ejecución a tu usuario
chmod u+rwx dormir.sh
chmod 700 dormir.sh
# Permiso de lectura y escritura a todos los usuarios
chmod a+rw dormir.sh
chmod 666 dormir.sh
# Solo permisos de ejecución al grupo de usuarios
chmod g+x,g-rw dormir.sh
chmod 616 dormir.sh
# Quita todos los permisos al grupo y a todos. Solo tu usuario es el que debe tener permisos
chmod u+rwx,g-x,o-rw dormir.sh
chmod 700 dormir.sh

## Ejercicio 15 - Ejecutar dormir.sh en segundo plano, comprobar y eliminar ejecución
./dormir.sh &
jobs -l
kill 2630

## Ejercicio 16 - Shell script de Bash que se llame con argumento (nombre.sh)
nano nombre.sh
ls -l nombre.sh
chmod a+x nombre.sh
./nombre.sh Paula

## Ejercicio 17 - Shell script notas (evaluacion.sh)
nano evaluacion.sh
ls -l evaluacion.sh
chmod a+x evaluacion.sh
./evaluacion.sh 8

## Ejercicio 18 - Shell script comprobación de fichero (fichero.sh)
realpath plasmids_final.txt
nano fichero.sh
ls -l fichero.sh
chmod a+x fichero.sh
./fichero.sh 