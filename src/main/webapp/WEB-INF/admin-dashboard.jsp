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
                    width: 250px;
                    box-shadow: 2px 0 10px rgba(229, 9, 20, 0.3);
                    border-right: 2px solid #E50914;
                }

                .sidebar-link {
                    display: flex;
                    align-items: center;
                    padding: 12px 20px;
                    color: #ffffff;
                    text-decoration: none;
                    transition: all 0.3s;
                }

                .sidebar-link:hover,
                .sidebar-link.active {
                    background: #181818;
                    color: #E50914;
                    border-left: 4px solid #E50914;
                }

                .main-content {
                    margin-left: 250px;
                    padding: 30px;
                }

                .tab-button {
                    padding: 12px 24px;
                    background: white;
                    border: 2px solid #e5e7eb;
                    color: #6b7280;
                    transition: all 0.3s;
                    cursor: pointer;
                }

                .tab-button.active {
                    background: #667eea;
                    color: white;
                    border-color: #667eea;
                }

                .search-box {
                    position: relative;
                }

                .search-box input {
                    padding-left: 40px;
                }

                .search-box i {
                    position: absolute;
                    left: 14px;
                    top: 50%;
                    transform: translateY(-50%);
                    color: #9ca3af;
                }

                .btn-primary {
                    background: #E50914;
                    color: white;
                    padding: 10px 20px;
                    border-radius: 8px;
                    border: none;
                    font-weight: 500;
                    cursor: pointer;
                    transition: transform 0.2s, box-shadow 0.2s;
                }

                .btn-primary:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 12px rgba(229, 9, 20, 0.6);
                    background: #b20710;
                }

                .btn-danger {
                    background: #ef4444;
                    color: white;
                    padding: 6px 12px;
                    border-radius: 6px;
                    border: none;
                    font-size: 14px;
                    cursor: pointer;
                    transition: background 0.3s;
                }

                .btn-danger:hover {
                    background: #dc2626;
                }

                .btn-edit {
                    background: #3b82f6;
                    color: white;
                    padding: 6px 12px;
                    border-radius: 6px;
                    border: none;
                    font-size: 14px;
                    cursor: pointer;
                    transition: background 0.3s;
                    text-decoration: none;
                    display: inline-block;
                }

                .btn-edit:hover {
                    background: #2563eb;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                }

                th {
                    background: #000000;
                    padding: 12px;
                    text-align: left;
                    font-weight: 600;
                    color: #E50914;
                    border-bottom: 2px solid #E50914;
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
                    </div>

                    <!-- Quick Actions -->
                    <div class="card p-6">
                        <h2 class="text-xl font-bold mb-4">Actions rapides</h2>
                        <div class="flex gap-4">
                            <a href="${pageContext.request.contextPath}/admin/contents/add" class="btn-primary">
                                <i class="bi bi-plus-circle"></i> Ajouter un contenu
                            </a>
                            <button onclick="showTab('users')" class="btn-primary">
                                <i class="bi bi-people"></i> Gérer les utilisateurs
                            </button>
                            <button onclick="showTab('contents')" class="btn-primary">
                                <i class="bi bi-film"></i> Gérer les contenus
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
            </div>

            <script>
                function showTab(tabName) {
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

                    // Add active to clicked link
                    event.target.closest('.sidebar-link').classList.add('active');
                }
            </script>
        </body>

        </html>