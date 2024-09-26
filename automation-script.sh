#!/bin/bash

users=("carlos" "maria" "joao" "debora" "sebastiana" "roberto" "josefina" "amanda" "rogerio")

groups_name=("ADM" "VEN" "SEC")

cont=0

echo "Creating Groups..."

for gp in "${groups_name[@]}"; do
	groupadd "GRP_"$gp
done

echo "Creating directories and setting permissions..."

mkdir /publico
chown root:root /publico
chmod 777 /publico

mkdir /adm
chown root:GRP_ADM /adm
chmod 770 /adm

mkdir /ven
chown root:GRP_VEN /ven
chmod 770 /ven

mkdir /sec
chown root:GRP_SEC /sec
chmod 770 /sec

echo "Creating users..."

i=0
for us in "${users[@]}"; do
	echo "Creating user "$us" at group "${groups_name[i]}"..."
	useradd "$us" -m -s /bin/bash -p $(openssl passwd Senha123) -G "GRP_"${groups_name[i]}
	passwd "$us" -e

	cont=$((cont+1))
	if [ $(($cont % 3)) -eq 0 ] && [ $cont -ne 0 ]; then
		i=$((i+1))
	fi
done

echo "Script finished!!!"
