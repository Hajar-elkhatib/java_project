<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Dashboard Admin | CineStream</title>

            <!-- Google Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">

            <!-- Bootstrap Icons -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

            <!-- Tailwind CSS -->
            <script src="https://cdn.tailwindcss.com"></script>

            <script>
                tailwind.config = {
                    darkMode: 'class',
                    theme: {
                        extend: {
                            fontFamily: {
                                sans: ['Outfit', 'sans-serif'],
                            },
                        }
                    }
                }
            </script>

            <style>
                body {
                    font-family: 'Outfit', sans-serif;
                    background: #141414;
                    min-height: 100vh;
                }

                .card {
                    background: #181818;
                    border: 1px solid #2F2F2F;
                    color: white;
                    border-radius: 12px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
                    transition: transform 0.2s, box-shadow 0.2s;
                }

                .card:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 12px rgba(229, 9, 20, 0.3);
                    border-color: #E50914;
                }

                .stat-card {
                    background: linear-gradient(135deg, #E50914 0%, #b20710 100%);
                    color: white;
                    padding: 24px;
                    border-radius: 12px;
                    box-shadow: 0 4px 6px rgba(229, 9, 20, 0.4);
                }

                .stat-card.green {
                    background: linear-gradient(135deg, #831010 0%, #5a0a0a 100%);
                }

                .stat-card.orange {
                    background: linear-gradient(135deg, #a81212 0%, #7a0d0d 100%);
                }

                .stat-card.red {
                    background: linear-gradient(135deg, #c71f1f 0%, #8f1616 100%);
                }

                .sidebar {
                    background: #000000;
                    height: 100vh;
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 250px;
                    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.5);
                    border-right: 1px solid #2F2F2F;
                    z-index: 50;
                    overflow-y: auto; /* Scrollable if content is too tall */
                }

                /* Custom Scrollbar for Sidebar */
                .sidebar::-webkit-scrollbar {
                    width: 6px;
                }
                .sidebar::-webkit-scrollbar-thumb {
                    background: #2F2F2F;
                    border-radius: 3px;
                }
                .sidebar::-webkit-scrollbar-track {
                    background: #000000;
                }

                .sidebar-link {
                    display: flex;
                    align-items: center;
                    padding: 14px 24px; /* More breathing room */
                    color: #9ca3af;
                    text-decoration: none;
                    transition: all 0.2s ease-in-out;
                    border-left: 3px solid transparent;
                    font-weight: 500;
                }

                .sidebar-link:hover,
                .sidebar-link.active {
                    background: #121212; /* Slightly lighter than black */
                    color: white;
                    border-left-color: #E50914;
                }

                .sidebar-link i {
                    font-size: 1.1rem;
                }

                .main-content {
                    margin-left: 250px;
                    padding: 40px;
                    width: calc(100% - 250px);
                    min-height: 100vh;
                    background-color: #141414; /* Match body bg to avoid white gaps */
                }
                /* ... existing styles ... */

                th {
                    background: #181818;
                    padding: 12px;
                    text-align: left;
                    font-weight: 600;
                    color: #9ca3af;
                    text-transform: uppercase;
                    font-size: 0.75rem;
                    letter-spacing: 0.05em;
                    border-bottom: 1px solid #2F2F2F;
                }

                td {
                    padding: 12px;
                    border-bottom: 1px solid #2F2F2F;
                    color: white;
                }

                tr:hover {
                    background: #2F2F2F;
                }

                .badge {
                    display: inline-block;
                    padding: 4px 12px;
                    border-radius: 12px;
                    font-size: 12px;
                    font-weight: 500;
                }

                .badge-film {
                    background: #E50914;
                    color: #ffffff;
                }

                .badge-serie {
                    background: #831010;
                    color: #ffffff;
                }

                .tab-content {
                    display: none;
                }

                .tab-content.active {
                    display: block;
                }
            </style>
        </head>

        <body>
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="p-6 border-b border-zinc-800">
                    <h2 class="text-2xl font-bold text-red-600">
                        <i class="bi bi-netflix text-red-600"></i> Admin
                    </h2>
                    <p class="text-xs text-zinc-500 mt-1 uppercase tracking-widest">CineStream Studio</p>
                </div>

            <nav class="py-4">
                <a href="#" class="sidebar-link active" onclick="showTab('dashboard')">
                    <i class="bi bi-speedometer2 mr-3"></i> Dashboard
                </a>
                <a href="#" class="sidebar-link" onclick="showTab('users')">
                    <i class="bi bi-people mr-3"></i> Utilisateurs
                </a>
                <a href="#" class="sidebar-link" onclick="showTab('contents')">
                    <i class="bi bi-film mr-3"></i> Contenus
                </a>
                <a href="#" class="sidebar-link" onclick="showTab('genres')">
                    <i class="bi bi-tags mr-3"></i> Genres
                </a>
            </nav>

                <div class="absolute bottom-0 w-full p-4 border-t">
                    <a href="${pageContext.request.contextPath}/admin/logout"
                        class="sidebar-link text-red-600 hover:bg-red-50">
                        <i class="bi bi-box-arrow-right mr-3"></i> Déconnexion
                    </a>
                </div>
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <!-- Dashboard Tab -->
                <div id="dashboard" class="tab-content active">
                    <h1 class="text-3xl font-bold text-white mb-6">
                        <i class="bi bi-speedometer2"></i> Tableau de bord
                    </h1>

                    <!-- Stats Cards -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                        <div class="stat-card">
                            <div class="flex justify-between items-start">
                                <div>
                                    <p class="text-sm opacity-80">Total Utilisateurs</p>
                                    <h3 class="text-4xl font-bold mt-2">${totalUsers}</h3>
                                </div>
                                <i class="bi bi-people text-4xl opacity-50"></i>
                            </div>
                        </div>

                        <div class="stat-card green">
                            <div class="flex justify-between items-start">
                                <div>
                                    <p class="text-sm opacity-80">Total Contenus</p>
                                    <h3 class="text-4xl font-bold mt-2">${totalContents}</h3>
                                </div>
                                <i class="bi bi-collection text-4xl opacity-50"></i>
                            </div>
                        </div>

                        <div class="stat-card orange">
                            <div class="flex justify-between items-start">
                                <div>
                                    <p class="text-sm opacity-80">Films</p>
                                    <h3 class="text-4xl font-bold mt-2">${totalMovies}</h3>
                                </div>
                                <i class="bi bi-camera-reels text-4xl opacity-50"></i>
                            </div>
                        </div>

                <div class="stat-card red">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="text-sm opacity-80">Séries</p>
                            <h3 class="text-4xl font-bold mt-2">${totalSeries}</h3>
                        </div>
                        <i class="bi bi-tv text-4xl opacity-50"></i>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="text-sm opacity-80">Genres</p>
                            <h3 class="text-4xl font-bold mt-2">${totalGenres}</h3>
                        </div>
                        <i class="bi bi-tags text-4xl opacity-50"></i>
                    </div>
                </div>
            </div>

                    <!-- Quick Actions -->
                    <div class="card p-6">
                        <h2 class="text-xl font-bold mb-4">Actions rapides</h2>
                <div class="flex gap-4 flex-wrap">
                    <a href="${pageContext.request.contextPath}/admin/contents/add" class="btn-primary">
                        <i class="bi bi-plus-circle"></i> Ajouter un contenu
                    </a>
                    <button onclick="showTab('users')" class="btn-primary">
                        <i class="bi bi-people"></i> Gérer les utilisateurs
                    </button>
                    <button onclick="showTab('contents')" class="btn-primary">
                        <i class="bi bi-film"></i> Gérer les contenus
                    </button>
                    <button onclick="showTab('genres')" class="btn-primary">
                        <i class="bi bi-tags"></i> Gérer les genres
                    </button>
                </div>
                    </div>
                </div>

                <!-- Users Tab -->
                <div id="users" class="tab-content">
                    <h1 class="text-3xl font-bold text-white mb-6">
                        <i class="bi bi-people"></i> Gestion des utilisateurs
                    </h1>

                    <div class="card p-6">
                        <div class="flex justify-between items-center mb-6">
                            <h2 class="text-xl font-bold">Liste des utilisateurs (${totalUsers})</h2>
                        </div>

                        <div class="overflow-x-auto">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nom</th>
                                        <th>Email</th>
                                        <th>Rôle</th>
                                        <th>Statut</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${users}" var="u">
                                        <tr>
                                            <td><span class="font-mono text-sm">${u.utilisateurId}</span></td>
                                            <td>${u.nom} ${u.prenom}</td>
                                            <td>${u.email}</td>
                                            <td><span class="badge badge-film">${u.role}</span></td>
                                            <td><span
                                                    class="badge ${u.statu == 'ACTIF' ? 'badge-film' : 'badge-serie'}">${u.statu}</span>
                                            </td>
                                            <td>
                                                <form
                                                    action="${pageContext.request.contextPath}/admin/users/delete/${u.utilisateurId}"
                                                    method="post" style="display:inline;">
                                                    <button type="submit" class="btn-danger"
                                                        onclick="return confirm('Supprimer cet utilisateur ?')">
                                                        <i class="bi bi-trash"></i> Supprimer
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Contents Tab -->
                <div id="contents" class="tab-content">
                    <h1 class="text-3xl font-bold text-white mb-6">
                        <i class="bi bi-film"></i> Gestion des contenus
                    </h1>

                    <div class="card p-6">
                        <div class="flex justify-between items-center mb-6">
                            <h2 class="text-xl font-bold">Liste des contenus</h2>
                            <a href="${pageContext.request.contextPath}/admin/contents/add" class="btn-primary">
                                <i class="bi bi-plus-circle"></i> Ajouter un contenu
                            </a>
                        </div>

                        <!-- Search & Filters -->
                        <div class="flex gap-4 mb-6">
                            <form action="${pageContext.request.contextPath}/admin/dashboard" method="get"
                                class="flex-1">
                                <div class="search-box">
                                    <i class="bi bi-search"></i>
                                    <input type="text" name="search" value="${currentSearch}"
                                        placeholder="Rechercher par titre..."
                                        class="w-full px-4 py-3 border border-zinc-800 bg-zinc-900 text-white rounded-lg focus:outline-none focus:ring-2 focus:ring-red-600">
                                </div>
                            </form>

                            <form action="${pageContext.request.contextPath}/admin/dashboard" method="get">
                                <select name="type" onchange="this.form.submit()"
                                    class="px-4 py-3 border border-zinc-800 bg-zinc-900 text-white rounded-lg focus:outline-none focus:ring-2 focus:ring-red-600">
                                    <option value="">Tous les types</option>
                                    <option value="FILM" ${currentType=='FILM' ? 'selected' : '' }>Films</option>
                                    <option value="SERIE" ${currentType=='SERIE' ? 'selected' : '' }>Séries</option>
                                </select>
                            </form>

                            <c:if test="${not empty currentSearch or not empty currentType}">
                                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-primary">
                                    <i class="bi bi-x-circle"></i> Réinitialiser
                                </a>
                            </c:if>
                        </div>

                        <div class="overflow-x-auto">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Poster</th>
                                        <th>Titre</th>
                                        <th>Type</th>
                                        <th>Note</th>
                                        <th>Durée</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${contents}" var="c">
                                        <tr>
                                            <td>
                                                <img src="${c.posterUrl}" alt="${c.titre}"
                                                    class="w-12 h-16 object-cover rounded">
                                            </td>
                                            <td class="font-semibold">${c.titre}</td>
                                            <td>
                                                <span
                                                    class="badge ${c.typeContenu == 'FILM' ? 'badge-film' : 'badge-serie'}">
                                                    ${c.typeContenu}
                                                </span>
                                            </td>
                                            <td>
                                                <i class="bi bi-star-fill text-yellow-500"></i> ${c.noteMoyenne}
                                            </td>
                                            <td>${c.dureeMinutes} min</td>
                                            <td>
                                                <div class="flex gap-2">
                                                    <a href="${pageContext.request.contextPath}/admin/contents/edit/${c.id}"
                                                        class="btn-edit">
                                                        <i class="bi bi-pencil"></i> Modifier
                                                    </a>
                                                    <form
                                                        action="${pageContext.request.contextPath}/admin/contents/delete/${c.id}"
                                                        method="post" style="display:inline;">
                                                        <button type="submit" class="btn-danger"
                                                            onclick="return confirm('Supprimer ce contenu ?')">
                                                            <i class="bi bi-trash"></i> Supprimer
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


        <!-- Genres Tab -->
        <div id="genres" class="tab-content">
            <h1 class="text-3xl font-bold text-white mb-6">
                <i class="bi bi-tags"></i> Gestion des genres
            </h1>

            <div class="card p-6 mb-6">
                <h2 class="text-xl font-bold mb-4">Ajouter / Modifier un genre</h2>
                <form action="${pageContext.request.contextPath}/admin/genres/save" method="post"
                    class="flex gap-4 items-end" autocomplete="off">
                    <input type="hidden" name="id" id="genreIdInput" value="">
                    <div class="flex-1">
                        <label class="block text-sm text-gray-400 mb-1">Nom du genre</label>
                        <input type="text" name="nom" id="genreNameInput" required
                            class="w-full px-4 py-2 border border-zinc-800 bg-zinc-900 text-white rounded-lg focus:outline-none focus:ring-2 focus:ring-red-600"
                            placeholder="Ex: Action, Comédie...">
                    </div>
                    <button type="submit" class="btn-primary" id="saveGenreBtn">
                        <i class="bi bi-plus-lg"></i> Ajouter
                    </button>
                    <button type="button" onclick="resetGenreForm()" id="cancelGenreBtn" style="display:none;"
                        class="btn-primary bg-gray-600 hover:bg-gray-700">
                        <i class="bi bi-x-lg"></i> Annuler
                    </button>
                </form>
            </div>

            <div class="card p-6">
                <h2 class="text-xl font-bold mb-6">Liste des genres</h2>
                <div class="overflow-x-auto">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nom</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${genres}" var="g">
                                <tr>
                                    <td><span class="font-mono text-sm text-gray-500">${g.id}</span></td>
                                    <td class="font-bold text-lg">${g.nom}</td>
                                    <td>
                                        <div class="flex gap-2">
                                            <button onclick="editGenre('${g.id}', '${g.nom}')" class="btn-edit">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <form action="${pageContext.request.contextPath}/admin/genres/delete/${g.id}"
                                                method="post" style="display:inline;">
                                                <button type="submit" class="btn-danger"
                                                    onclick="return confirm('Supprimer ce genre ?')">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

        <script>
            // Check hash on load and reset form
            window.addEventListener('load', function() {
                resetGenreForm(); // Force clear on load
                if(window.location.hash) {
                    const tabName = window.location.hash.substring(1);
                    if(document.getElementById(tabName)) {
                        showTab(tabName);
                    }
                }
            });

            function showTab(tabName) {
                // ... existing showTab ...
                // Update URL hash without scrolling
                history.replaceState(null, null, '#' + tabName);

                // Hide all tabs
                document.querySelectorAll('.tab-content').forEach(tab => {
                    tab.classList.remove('active');
                });

                // Remove active from all sidebar links
                document.querySelectorAll('.sidebar-link').forEach(link => {
                    link.classList.remove('active');
                });

                // Show selected tab
                document.getElementById(tabName).classList.add('active');

                // Add active to matching links
                const sidebarLinks = document.querySelectorAll('.sidebar-link');
                sidebarLinks.forEach(link => {
                     if(link.getAttribute('onclick') && link.getAttribute('onclick').includes(tabName)) {
                         link.classList.add('active');
                     }
                });
            }

            function editGenre(id, name) {
                document.getElementById('genreIdInput').value = id;
                document.getElementById('genreNameInput').value = name;
                
                // Update UI for Edit Mode
                document.getElementById('saveGenreBtn').innerHTML = '<i class="bi bi-check-lg"></i> Modifier';
                document.getElementById('cancelGenreBtn').style.display = 'inline-block';
                
                // Scroll to form
                document.getElementById('genreNameInput').scrollIntoView({ behavior: 'smooth', block: 'center' });
                document.getElementById('genreNameInput').focus();
            }

            function resetGenreForm() {
                document.getElementById('genreIdInput').value = '';
                document.getElementById('genreNameInput').value = '';
                
                // Reset UI to Add Mode
                document.getElementById('saveGenreBtn').innerHTML = '<i class="bi bi-plus-lg"></i> Ajouter';
                document.getElementById('cancelGenreBtn').style.display = 'none';
            }
        </script>
        </body>

        </html>