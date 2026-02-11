# CineStream - Système de Recommandation de Films

Frontend moderne et premium pour le système de recommandation, construit avec Jakarta EE (JSP/Servlet via Spring Boot) et TailwindCSS.

## Stack Technique

- **Backend/Container**: Spring Boot (supporte JSP/Servlet standards)
- **Frontend**: JSP, JSTL, JavaScript Vanilla, TailwindCSS
- **Base de données**: MongoDB (configuré dans le projet existant)

## Structure des Dossiers Livrés

```
src/main/webapp/
├── index.jsp           # Page d'accueil
├── movies.jsp          # Catalogue avec filtres
├── movie-details.jsp   # Détails + Notation
├── recommendations.jsp # Page de recommandations
├── login.jsp           # Authentification
├── register.jsp        # Inscription
├── profile.jsp         # Profil utilisateur
├── admin.jsp           # Dashboard administrateur
├── includes/           # Header et Footer communs
└── assets/
    ├── css/
    │   └── styles.css  # Styles personnalisés + Glassmorphism
    └── js/
        ├── api.js      # Client API REST générique
        ├── ui.js       # Composants UI (Toast, Skeleton, Cards)
        └── pages/      # Logique spécifique par page
```

## Configuration & Exécution

### Option 1: Développement Local (Recommandé)

Le projet est configuré pour supporter JSP avec Spring Boot.

1. Assurez-vous d'avoir Maven installé.
2. Lancez l'application :
   ```bash
   ./mvnw spring-boot:run
   ```
3. Accédez à l'application sur : `http://localhost:8080/`

**Note**: Les endpoints API sont supposés être servis par ce même backend sur `/api/*`. Si le backend est séparé, modifiez `API_BASE_URL` dans `src/main/webapp/assets/js/api.js`.

### Option 2: Déploiement sur Tomcat Externe

Le projet a été configuré pour générer un fichier WAR.

1. Construire le WAR :
   ```bash
   ./mvnw clean package
   ```
2. Récupérez le fichier `.war` dans le dossier `target/`.
3. Renommez-le en `ROOT.war` (pour être à la racine) ou gardez le nom pour un sous-contexte.
4. Copiez le fichier dans le dossier `webapps/` de votre installation Tomcat.
5. Démarrez Tomcat.
6. Accédez via `http://localhost:8080/` (ou `http://localhost:8080/JavaProjet` si pas renommé).

## Fonctionnalités UI Implémentées

- **Design Premium**: Effets Glassmorphism, animations fluides, mode sombre par défaut.
- **Réactivité**: Layouts s'adaptant au mobile et desktop.
- **Interactivité**:
  - Filtres par genre et tri dynamique.
  - Squelettes de chargement (Skeleton loading).
  - Toast notifications pour les succès/erreurs.
  - Modal animé pour la notation des films.
- **API Client**: `api.js` centralise tous les appels fetch avec gestion des erreurs et tokens.

## Personnalisation

- Les styles Tailwind sont chargés via CDN pour simplicité. Pour production, une build CSS est recommandée.
- Les couleurs et polices peuvent être ajustées dans `includes/header.jsp` (config Tailwind) et `styles.css`.