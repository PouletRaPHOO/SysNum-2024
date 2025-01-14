# SysNum-2024
Simple processor, featuring a netlist simulator and Basic X86 instruction set

ATTENTION : sans assignhook, le projet ne semble pas fonctionner !

## Compilation de l'horloge

Pour compiler l'horloge, il faut se placer dans le dossier principal et executer un `make run` si l'on veut avoir un fonctionnement en temps normal, c'est à  dire une seconde toutes les secondes. Si l'on veut avoir un fonctionnement rapide, il suffit d'executer un `make runfast`.

Ces deux commandes font les actions suivantes :
 - compilation de la netlist
 - compilation du code assembleur de l'horloge
 - crÃ©ation du fichier `main.net` avec carotte
 - appel du simulateur de netlist sur `main.net`

## Structure de l'assembleur

Le dossier netlist contient le simulateur de netlist, le dossier assembly contient la définition de l'assembleur, le dossier roms contient la rom obtenue par execution de l'assembleur sur clock.lv (resp. clockfast.lv) pour une utilisation normale (resp. rapide).

Dans Utils, on trouvera les codes de l'ALU et de quelques fonctions utilitaires pour notre fichier principal `main.py` dont la netlist associÃ©e (après compilation par carotte) est `main.net`

## Options de netlist_simulator

Les options sont les suivantes:
- -help : affiche les options
- -n : nombre de tours
- -ten : affiche les nombres en base 10
- -clock : affiche sous forme compatible avec une horloge
- -sec : affiche seulement lorsque la variable `sec` est actualisée
