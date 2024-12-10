# Projet Systèmes Numériques

## Compilation

Afin de compiler le projet on utilisera :
```
make
```
et pour compiler uniquement le scheduler on pourra utiliser :

```
make schedule
```


## Utilisation

Afin de simuler la netlist sur le fichier `/test/*.net` on va utiliser la commande : 

```sh
./netlist_simulator.byte test/*.net

```



Pour pouvoir utiliser des roms préinitialisée, on va pour chaque rom `ident` déclarée dans la netlist, on va fournir dans le dossier test (l'emplacement des roms peut être changé dans le `netlist_simulator.ml`) un fichier `ident.rom` selon la norme suivante :

- Chaque ligne correspond à un *VBitArray*, ou 0 correspond à `false` et 1 à `true`, Autrement dit pour encoder la *ROM** r : 

| Colonne 0 | Colonne 1|
|-----|---|
| true | false |
| false | false |
|false | true|
|false |true |
|true | true |
| false | false |
| false | false |
| false | false |

on fournit le fichier `r.rom` :

```
10
00
01
01
11
00
00
00
```

De plus si aucun fichier n'est fourni, la ROM est initialisée entièrement remplie de false. De même si toutes les lignes ne sont pas spécifiées dans le fichier elles sont également initialisées à false. Ainsi pour initialiser la ROM précédente on peut également fournir le fichier `r.rom` :

```
10
00
01
01
11
```

De même pour rentrer dans un input un *VBitArray* `[|false;true;false;false|]` on rentrera `Valeur de a (array de taille 4): 0100`

## Spécifications 

### Scheduler 

Le Scheduler commence par construire un graphe de dépendance entre toutes les variables. Puis ordonne les opérations selon un ordre topologique (s'il y en a un, sinon il renvoit une erreur `Combinatorial_Cycle`).

Il y a cependant 2 choses notables à remarquer lors du passage du scheduler :

- On ne considère par l'opération `REG` comme une opération de dépendance, puisque `y = REG x` donne  à y la valeur de x à l'étape précédente (et donc n'est pas impactée par l'ordre de réassignation de x)
- Lors d'un appel `y = RAM _ _ ra we wa data`, seule `ra` est considérée comme une dépendance, puisque comme l'on va faire tout les write de *RAM* à la fin de chaque étape, toutes dépendance relative à l'écriture n'impacte pas l'ordre de simulation de l'opération.

### Simulateur 

#### Explication globale 

Le simulateur commence par créer un environnement d'assignation des variables présentes afin d'initialiser toutes les variables à faux, il effectue ensuite un pré-passage dans les opérations afin d'initialiser deux Env : `roms` (resp `rams`) stockant les valeurs présentes dans les *ROMs* (resp *RAMs*) (initialisés, dans le cas des roms, par un fichier s'il existe sinon à tout faux, et dans le cas des ram à tout faux).

Ensuite pour chaque étape, le simulateur collecte les inputs, et fold sur les opérations en se baladant comme accumulateur l'environnement d'assignation des variables. Chaque opération, sauf les opérations `write` des *RAMs* est effectuée et répercutée sur l'environnement d'assignation lorsque l'opération est rencontrée.

Toutes les écritures de *RAMs* sont effectuées à la fin de la passe, en se basant sur le nouvel environnement d'assignation.

Le programme finit l'étape en printant les outputs.

#### Specifications particulières 

_REG_ :
- L'assignation d'un registre utilise l'environnement final de la passe précédente (du pre-process s'il s'agit de la première passe). Ainsi la lecture de `y = REG x` à la passe *n* assignera à *y* la valeur de *x* à la fin de la passe *n-1*. 

_NOT_ :
- L'application de *NOT* sur un array est effectuée bit à bit.

_BINOP_ :
- Une binop entre deux *VBit _* est faite de façon normale
- Une binop entre un *VBit b* et un *VBitArray a*  est faite bit à bit sur les éléments de *a* et *b*
- Une binop entre deux *VBitArray a1,a2* renvoie un tableau de la taille minimum entre les deux arrays rempli des opérations bit à bit. 

_CONCAT_ :
- Une concat entre deux *VBitArray* agit de façon intuitive
- Le reste des opérations possibles considèrent les *VBit* commes des *VBitArray* de taille 1

_SELECT_ :
- Une select sur un *VBit* n'est légale seulement si on sélectionne l'élément 0, dans ce cas elle renvoie le *VBit*
- Une select sur des *VBitArray* agit de façon intuitive

_SLICE_ :
- Un slice n'est légal que sur un *VBitArray _*

_MUX_ :
- On va considérer que l'argument de choix pointe vers le premier élément dans deux cas :
  - C'est un *VBit true*
  - C'est un *VBitArray _* entièrement remplit de true
- Dans tout les autres cas on renverra le deuxième élement

_ROM_ :
- Une addresse est forcément un *VBitArray _* de taille inférieure ou égale à `address_size`

_RAM_ :
- Pareil que pour `ROM`
