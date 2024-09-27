# Utiliser une image Node.js officielle
FROM node:22

# Définir le répertoire de travail
WORKDIR /usr/src/app

# Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Configurer npm pour utiliser un miroir de registre
RUN npm config set registry https://registry.npmmirror.com/

# Supprimer le cache de npm
RUN npm cache clean --force

# Installer les dépendances
RUN npm install --no-optional

# Copier le reste des fichiers de l'application
COPY . .

# Construire l'application Vue.js
RUN npm run build

# Exposer le port 8080
EXPOSE 5173

# Démarrer l'application
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]