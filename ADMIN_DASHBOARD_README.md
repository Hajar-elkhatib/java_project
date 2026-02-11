# Dashboard Admin - Documentation

## 🎯 Fonctionnalités implémentées

### 1. Authentification Admin
- **Login**: email=admin@admin, motDePasse=admin
- **Session sécurisée**: Attribut `role=ADMIN` stocké en session
- **Protection des routes**: Intercepteur qui redirige vers `/admin/login` si non authentifié
- **Logout**: Invalidation de session

### 2. Dashboard Admin
- **Statistiques en temps réel**:
  - Total utilisateurs
  - Total contenus
  - Total films
  - Total séries
- **Navigation par tabs**: Dashboard, Utilisateurs, Contenus
- **Design moderne**: Gradient cards, animations, responsive

### 3. Gestion des Contenus (CRUD complet)
- **Liste des contenus** avec affichage de:
  - Poster miniature
  - Titre
  - Type (Film/Série) avec badge coloré
  - Note moyenne
  - Durée
- **Recherche par titre**: Barre de recherche en temps réel
- **Filtrage par type**: Dropdown Films/Séries/Tous
- **Ajout de contenu**: Formulaire complet avec tous les champs
- **Modification**: Formulaire pré-rempli avec les données existantes
- **Suppression**: Avec confirmation JavaScript

### 4. Gestion des Utilisateurs
- **Liste complète** avec:
  - ID, Nom, Email, Rôle, Statut
  - Badges colorés pour le statut
- **Suppression d'utilisateur**: Avec confirmation

## 📁 Fichiers créés/modifiés

### Contrôleurs
- ✅ `AdminAuthController.java` - Gestion login/logout
- ✅ `AdminController.java` - Dashboard et CRUD (modifié)

### Configuration
- ✅ `AdminInterceptor.java` - Protection des routes admin
- ✅ `WebConfig.java` - Enregistrement de l'intercepteur (modifié)

### Vues JSP
- ✅ `admin-login.jsp` - Page de connexion admin
- ✅ `admin-dashboard.jsp` - Dashboard principal avec tabs
- ✅ `admin-content-form.jsp` - Formulaire ajout/édition contenu

## 🚀 Routes disponibles

### Public
- `GET /admin/login` - Page de connexion
- `POST /admin/login` - Authentification

### Protégées (nécessite session ADMIN)
- `GET /admin` → Redirige vers `/admin/dashboard`
- `GET /admin/dashboard` - Dashboard principal
- `GET /admin/dashboard?search=xxx` - Recherche par titre
- `GET /admin/dashboard?type=FILM|SERIE` - Filtrage par type
- `GET /admin/contents/add` - Formulaire ajout contenu
- `GET /admin/contents/edit/{id}` - Formulaire édition contenu
- `POST /admin/contents/save` - Sauvegarde contenu (create/update)
- `POST /admin/contents/delete/{id}` - Suppression contenu
- `POST /admin/users/delete/{id}` - Suppression utilisateur
- `POST /admin/users/status/{id}?status=xxx` - Changement statut utilisateur
- `GET /admin/logout` - Déconnexion

## 🎨 Design & UX

### Technologies utilisées
- **Tailwind CSS** - Framework CSS utilitaire
- **Google Fonts Outfit** - Typographie moderne
- **Bootstrap Icons** - Icônes
- **Animations CSS** - Transitions et effets

### Points forts
- ✨ Design moderne avec gradients
- 📊 Cartes statistiques colorées
- 🔍 Recherche et filtres intuitifs
- 📱 Design responsive
- ⚡ Animations fluides
- 🎯 UX optimisée (confirmations, feedback visuel)

## ⚙️ Configuration requise

### Spring Boot
```yaml
# application.yml
spring:
  mvc:
    view:
      prefix: /WEB-INF/
      suffix: .jsp
```

### Dependencies (pom.xml)
```xml
<!-- JSP Support -->
<dependency>
    <groupId>org.apache.tomcat.embed</groupId>
    <artifactId>tomcat-embed-jasper</artifactId>
</dependency>

<!-- JSTL -->
<dependency>
    <groupId>org.glassfish.web</groupId>
    <artifactId>jakarta.servlet.jsp.jstl</artifactId>
</dependency>
```

## 🧪 Tests recommandés

1. **Authentification**:
   - ✅ Login avec credentials corrects → Accès au dashboard
   - ✅ Login avec credentials incorrects → Message d'erreur
   - ✅ Accès direct à `/admin/dashboard` sans login → Redirect vers login
   - ✅ Logout → Session invalidée, redirect vers login

2. **Gestion contenus**:
   - ✅ Ajout d'un nouveau film
   - ✅ Ajout d'une nouvelle série
   - ✅ Modification d'un contenu existant
   - ✅ Suppression d'un contenu
   - ✅ Recherche par titre
   - ✅ Filtrage par type

3. **Gestion utilisateurs**:
   - ✅ Affichage de la liste
   - ✅ Suppression d'un utilisateur

## 🔐 Sécurité

- ✅ Session-based authentication
- ✅ Intercepteur sur toutes les routes `/admin/**`
- ✅ Exclusion login/logout de l'interception
- ✅ Confirmations JavaScript pour actions destructives
- ⚠️ **Note**: En production, il faudrait:
  - Stocker les credentials admin en base de données
  - Hasher les mots de passe (BCrypt)
  - Implémenter CSRF protection
  - Ajouter rate limiting

## 📝 Notes d'utilisation

### Identifiants admin par défaut
```
Email: admin@admin
Mot de passe: admin
```

### Format des données

**Contenu**:
- `titre` (String, requis)
- `typeContenu` (FILM ou SERIE, requis)
- `dureeMinutes` (int, requis)
- `description` (String, optionnel)
- `langue` (String, optionnel)
- `pays` (String, optionnel)
- `dateSortie` (Date, optionnel)
- `noteMoyenne` (double, 0-10)
- `nbVotes` (int)
- `posterUrl` (String URL)
- `trailerUrl` (String URL YouTube)

### URLs d'exemple pour poster
- TMDB: `https://image.tmdb.org/t/p/w500/xxx.jpg`
- IMDb: Images via API

### URLs YouTube
- Standard: `https://www.youtube.com/watch?v=xxx`
- Court: `https://youtu.be/xxx`
- Embed: `https://www.youtube.com/embed/xxx`

## 🎯 Prochaines améliorations possibles

1. **Upload d'images**: Permettre l'upload de posters plutôt que saisir URL
2. **Gestion des genres**: Association multi-genres pour chaque contenu
3. **Statistiques avancées**: Graphiques, tendances, analytics
4. **Gestion des épisodes**: Pour les séries
5. **Modération commentaires**: Depuis le dashboard
6. **Logs d'activité**: Historique des actions admin
7. **Multi-admin**: Gestion de plusieurs comptes admin
8. **Export de données**: CSV, Excel
9. **Pagination**: Pour les grandes listes
10. **Édition en masse**: Actions sur plusieurs éléments à la fois
