#!/usr/bin/env bash

# Busqueda de archivos a procesar
fichero=($(ls ~/Documents/programacion_shell/galindo_k.pneumoniae_2026_nature/data/processed/secuencia*))

# Ejecución de comandos

for fichero in "${fichero[@]}"
do
	sec=$(awk 'NR==2' "$fichero")                   			# Extraer secuencias de cada archivo
	leng=$(awk 'NR==2 {print length($0)}' "$fichero")			# Cálculo de longitud de la secuencia
	first_nu=$(awk 'NR==2 {print substr($0,1,1)}' "$fichero")		# Busqueda de primer nucleótido
	last_nu=$(awk 'NR==2 {print substr($0,length($0),1)}' "$fichero")	# Busqueda de último nucleótido
	cant_GC=$(echo "$sec" | grep -o '[GC]' | wc -l)				# Cálculo de cantidad de GC por secuencia
	percent_GC=$(echo "scale=10; $cant_GC/$leng * 100" | bc)		# Cálculo de % GC
	percent_GC_R=$(printf "%.2f" "$percent_GC")				# Redondeo a 2 cifras
	gggg_count=$(echo "$sec" | grep -no "GGGG" | wc -l)			# Busqueda de patron GGGG y conteo de veces que aparece en la secuencia
	ttcc_count=$(echo "$sec" | grep -no "TTCC" | wc -l)			# Busqueda de patron TTCC y conteo de veces que aparece en la secuencia
	name_sec=$(awk 'NR==1' $fichero)					# Extracción de nombre de secuencia
	
	echo "
	
	INFORME $name_sec
	-----------------------------------------------------------------
	"
	
	# echo "Archivo Procesado: $fichero"					Comando de verificación
	echo "Longitud de Secuencia: $leng"
	echo "Primer Nucleótido: $first_nu"
	echo "Ultimo Nucleótido: $last_nu"
	# echo "secuencia: $sec"						Comando de verificación
	echo "Porcentaje GC (%GC): $percent_GC_R %"
	# echo "GGGG: $gggg_count"						Comando de verificación
	# echo "TTCC: $ttcc_count"						Comando de verificación
	# echo "nombre secuencia: $name_sec"					Comando de verificación
	
	echo "
	
	DETECCIÓN DE PATRÓN GGGG
	------------------------------------------------------------------
	"


	if (($gggg_count > 0))							# Verificación presencia de patrón GGGG en la secuencia
	then
		echo "Presencia de patron GGGG detectada"
		echo "Número de ocurrencias: $gggg_count"
		echo "Nombre de secuencia: $name_sec"
		mutation_g=$(echo "$sec" | sed 's/GGGG/"Mutation"/g')		# Reemplazo del patrón GGGG por "Mutation"
		echo "Secuencia modificada: $mutation_g"
	else
		echo "patron GGGG no detectado"
	fi
	
	echo "
	
	DETECCIÓN DE PATRÓN TTCC
	------------------------------------------------------------------
	"
	
	if (($ttcc_count > 0))							# Verificación presencia de patrón GGGG en la secuencia
        then
                echo "Presencia de patron TTCC detectada"
                echo "Número de ocurrencias: $ttcc_count"
                echo "Nombre de secuencia: $name_sec"
        else
                echo "patron TTCC no detectado"
        fi
done



