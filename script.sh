#!/bin/bash

rep='a'
data='a'
path='a'
install_virtualbox="virtualbox-5.1"
install_vagrant="vagrant"


echo "====================="
echo "      WELCOME        "
echo "====================="
echo""

echo "Etape 1 : installation de virtualBox"
echo ""

#permet de vérifier que la version 5.1 de virtualBox est installé
 if [ "`dpkg -l $install_virtualbox 2>/dev/null | grep '^ii' `" != "" ]
   then
       echo "$install_virtualbox est installé"
       echo""
   else
       echo "$install_virtualbox n'est pas installé"
       echo "Voulez vous installer virtualBox ? : (O/n)"
       choix=""
       if [[ $choix="o" || $choix="O" ]];
        then
        #installation de virtualbox 5.1
         sudo apt-get install virtualbox-5.1
       fi
 fi

echo "Etape 2 : installation de Vagrant"
echo ""

 #permet de vérifier que vagrant est installé
 if [ "`dpkg -l $install_vagrant 2>/dev/null | grep '^ii' `" != "" ]
   then
       echo "$install_vagrant est installé"
       echo""
   else
       echo "$install_vagrant n'est pas installé"
       echo "Voulez vous installer vagrant ? : (O/n)"
       choix=""
       if [[ $choix="o" || $choix="O" ]];
        then
        #installation de vagrant
         sudo apt-get install vagrant
       fi
 fi

#affichage du chemin courant
echo "vous êtes dans : "; pwd
echo ""
echo "Voulez-vous créer la vagrant ici ? (o/n)"
read rep
echo "Voulez-vous générez automatiquement le ficher de configuration ou manuellement ? (a/m) :"
read auto_manuel

#if [ $rep = ^[oO]*$ ] || [ $rep = "O" ] && [ auto_manuel = "a" ] || [ auto_manuel = "A" ]
#if [ $rep = [^oO]$ ] && [ auto_manuel = [^aA]$ ]
if [ $rep="o" ] && [ $auto_manuel="a" ]
  then
  clear
  mkdir vagrant_test
  cd vagrant_test
  #créer le fichier VagrantFile
  vagrant init

  data="data"
  mkdir $data

  path="/var/www/html"
  
  #modification des lignes de configuration dans le fichier VagrantFile
  sed -i-e  's/  config.vm.box \= \"base\"/   config.vm.box \= \"xenial.box\"/g' Vagrantfile
  sed -i-e  's/  \# config.vm.network \"private_network\"\, ip: \"192.168.33.10\"/config.vm.network \"private_network\"\, ip: \"192.168.33.10\"/g' Vagrantfile
  sed -i-e  's/  \# config.vm.synced_folder \"..\/data\"\, \"\/vagrant_data\"/config.vm.synced_folder \"$data\"\, \"$path\"/g' Vagrantfile

  echo "Fichier configuré"
  echo ""
  echo "Placer la box dans le dossier vagrant_test"
  echo "appuyer sur enter quand vous avez placé la box"
  read
  
  vagrant up
  vagrant ssh

elif [ $rep="o" ] && [ $auto_manuel="m" ]
 then
  clear
  mkdir vagrant_test
  cd vagrant_test
  #créer le fichier VagrantFile
  vagrant init

  echo "nom du fichier de sync : "
  read data
  mkdir $data

  echo "chemin du fichier : "
  read path
  
  #modification des lignes de configuration dans le fichier VagrantFile
  sed -i-e  's/  config.vm.box \= \"base\"/   config.vm.box \= \"xenial.box\"/g' Vagrantfile
  sed -i-e  's/  \# config.vm.network \"private_network\"\, ip: \"192.168.33.10\"/config.vm.network \"private_network\"\, ip: \"192.168.33.10\"/g' Vagrantfile
  sed -i-e  's/  \# config.vm.synced_folder \"..\/data\"\, \"\/vagrant_data\"/config.vm.synced_folder \"$data\"\, \"$path\"/g' Vagrantfile

  echo "Fichier configuré"
  echo ""
  echo "Placer la box dans le dossier vagrant_test"
  echo "appuyer sur enter quand vous avez placé la box"
  read
  
  vagrant up
  vagrant ssh

fi
read
