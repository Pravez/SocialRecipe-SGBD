#SocialRecipe

--------------

##Notice d'utilisation


###Dépendances et lancement

Ceci est un serveur NodeJS utilisant le moteur de templates EJS.
Vous devez donc au préalable avoir installé NodeJS.

Pour installer l'intégralité des paquets nécessaires à NodeJS pour fonctionner, lancer :
`npm install`

Une fois ceci fait il faut utiliser `bower` pour résoudre les dépendances côté rendu client (jquery, bootstrap ...).
Soit vous êtes un fan inconditionnel de bower et vous l'avez installé de manière globale avec `npm install -g bower`
(en admin) : vous pourrez l'appeller avec simplement depuis l'invite de commande `bower`. Sinon vous l'aurez d'installé
avec tous les autres packages npm. Il faudra donc aller chercher dans `./node_modules/.bin/bower` (ou `bower.cmd` si vous êtes sous windows).

Lancez donc la commande `bower install` à partir de la commande que vous souhaitez, dans le répertoire du serveur NodeJS.

Après ceci, toutes les dépendances sont installées.


Maintenant si vous souhaitez lancer le serveur, lancez `npm start` (ou `node bin/www`)


###Configuration particulière

Si vous souhaitez modifier la base de données à laquelle vous accédez, rendez vous dans le fichier `app.js` situé à 
la racine, lignes 32 à 40. Si vous ne souhaitez pas réaliser un tunnel ssh vers notre base de données stockée sur une
raspberry, commentez la ligne 32. Si vous souhaitez modifier le serveur PostGres auquel vous accédez, il vous faudra
modifier les lignes 34 à 39.

Si vous souhaitez modifier le port sur lequel se lance le serveur NodeJS, modifiez le fichier `bin/www` ligne 15 (le port
par défaut est 3000 dans notre cas).