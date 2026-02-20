<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${isEdit ? 'Modifier' : 'Ajouter'} un contenu | Admin</title>

            <!-- Google Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">

            <!-- Bootstrap Icons -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Outfit', sans-serif;
                    background: #141414;
                    min-height: 100vh;
                    padding: 40px 20px;
                    color: white;
                }

                .container {
                    max-width: 800px;
                    margin: 0 auto;
                }

                .form-card {
                    background: #181818;
                    border-radius: 20px;
                    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
                    border: 1px solid #2F2F2F;
                    overflow: hidden;
                    animation: slideIn 0.5s ease-out;
                }

                @keyframes slideIn {
                    from {
                        opacity: 0;
                        transform: translateY(-30px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .form-header {
                    background: #E50914;
                    color: white;
                    padding: 30px;
                    text-align: center;
                }

                .form-header h1 {
                    font-size: 28px;
                    font-weight: 600;
                    margin-bottom: 8px;
                }

                .form-header p {
                    opacity: 0.9;
                    font-size: 14px;
                }

                .form-body {
                    padding: 40px;
                }

                .form-grid {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 20px;
                    margin-bottom: 20px;
                }

                .form-group {
                    margin-bottom: 20px;
                }

                .form-group.full-width {
                    grid-column: 1 / -1;
                }

                .form-group label {
                    display: block;
                    font-weight: 500;
                    color: #ffffff;
                    margin-bottom: 8px;
                    font-size: 14px;
                }

                .form-group label i {
                    margin-right: 6px;
                    color: #E50914;
                }

                .form-group input,
                .form-group select,
                .form-group textarea {
                    width: 100%;
                    padding: 12px 16px;
                    border: 2px solid #2F2F2F;
                    background: #2F2F2F;
                    color: white;
                    border-radius: 10px;
                    font-size: 15px;
                    font-family: 'Outfit', sans-serif;
                    transition: all 0.3s ease;
                }

                .form-group input:focus,
                .form-group select:focus,
                .form-group textarea:focus {
                    outline: none;
                    border-color: #E50914;
                    box-shadow: 0 0 0 3px rgba(229, 9, 20, 0.2);
                }

                .form-group textarea {
                    resize: vertical;
                    min-height: 100px;
                }

                .form-actions {
                    display: flex;
                    gap: 15px;
                    margin-top: 30px;
                    padding-top: 30px;
                    border-top: 2px solid #2F2F2F;
                }

                .btn {
                    flex: 1;
                    padding: 14px;
                    border: none;
                    border-radius: 10px;
                    font-size: 16px;
                    font-weight: 600;
                    cursor: pointer;
                    transition: transform 0.2s, box-shadow 0.2s;
                    font-family: 'Outfit', sans-serif;
                    text-decoration: none;
                    text-align: center;
                    display: inline-block;
                }

                .btn-primary {
                    background: #E50914;
                    color: white;
                }

                .btn-primary:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 20px rgba(229, 9, 20, 0.4);
                    background: #b20710;
                }

                .btn-secondary {
                    background: #2F2F2F;
                    color: #ffffff;
                }

                .btn-secondary:hover {
                    background: #3f3f3f;
                }

                .required {
                    color: #ef4444;
                    margin-left: 4px;
                }

                .help-text {
                    font-size: 12px;
                    color: #6b7280;
                    margin-top: 4px;
                }

                /* Multi-Select Styles */
                .multi-select-container {
                    position: relative;
                    width: 100%;
                }
                .selected-tags {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 8px;
                    padding: 8px 12px;
                    background: #2F2F2F;
                    border: 2px solid #2F2F2F;
                    border-radius: 10px;
                    min-height: 48px;
                    cursor: pointer;
                    transition: all 0.3s ease;
                }
                .selected-tags:hover {
                    border-color: #3f3f3f;
                }
                .selected-tags.active {
                    border-color: #E50914;
                    box-shadow: 0 0 0 3px rgba(229, 9, 20, 0.2);
                }
                .tag {
                    background: #E50914;
                    color: white;
                    padding: 4px 12px;
                    border-radius: 6px;
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    font-size: 13px;
                    font-weight: 500;
                    animation: popIn 0.2s ease-out;
                }
                @keyframes popIn {
                    from { transform: scale(0.8); opacity: 0; }
                    to { transform: scale(1); opacity: 1; }
                }
                .tag i {
                    cursor: pointer;
                    opacity: 0.8;
                    transition: opacity 0.2s;
                }
                .tag i:hover {
                    opacity: 1;
                }
                .dropdown-list {
                    position: absolute;
                    top: calc(100% + 5px);
                    left: 0;
                    right: 0;
                    background: #1f1f1f;
                    border: 1px solid #2F2F2F;
                    border-radius: 10px;
                    max-height: 250px;
                    overflow-y: auto;
                    z-index: 1000;
                    display: none;
                    box-shadow: 0 10px 30px rgba(0,0,0,0.6);
                }
                .dropdown-item {
                    padding: 12px 16px;
                    cursor: pointer;
                    transition: all 0.2s;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }
                .dropdown-item:hover {
                    background: #2F2F2F;
                }
                .dropdown-item.selected {
                    background: rgba(229, 9, 20, 0.1);
                    color: #E50914;
                }

                /* Seasons UI Improvements */
                .season-selector {
                    display: flex;
                    gap: 12px;
                    overflow-x: auto;
                    padding-bottom: 12px;
                    margin-bottom: 24px;
                    scrollbar-width: thin;
                    scrollbar-color: #E50914 transparent;
                }
                .season-tab {
                    padding: 12px 24px;
                    background: #232323;
                    border-radius: 12px;
                    cursor: pointer;
                    white-space: nowrap;
                    font-weight: 700;
                    font-size: 14px;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    border: 2px solid transparent;
                    color: #808080;
                }
                .season-tab:hover {
                    background: #2a2a2a;
                    color: #fff;
                    transform: translateY(-2px);
                }
                .season-tab.active {
                    background: rgba(229, 9, 20, 0.1);
                    border-color: #E50914;
                    color: #E50914;
                    transform: translateY(-2px);
                    box-shadow: 0 10px 20px rgba(229, 9, 20, 0.15);
                }
                .ep-card {
                    background: #1f1f1f;
                    border: 1px solid #2a2a2a;
                    border-radius: 12px;
                    padding: 16px;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    transition: all 0.3s ease;
                }
                .ep-card:hover {
                    background: #252525;
                    border-color: #3f3f3f;
                    transform: translateX(5px);
                }
                .ep-number {
                    width: 40px;
                    height: 40px;
                    background: #2a2a2a;
                    border-radius: 10px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-weight: 800;
                    color: #E50914;
                    font-size: 16px;
                }
                .hidden { display: none !important; }

                @media (max-width: 768px) {
                    .form-grid {
                        grid-template-columns: 1fr;
                    }
                }
            </style>
        </head>

        <body>
            <div class="container">
                <div class="form-card">
                    <div class="form-header">
                        <h1>
                            <i class="bi bi-${isEdit ? 'pencil' : 'plus-circle'}"></i>
                            ${isEdit ? 'Modifier' : 'Ajouter'} un contenu
                        </h1>
                        <p>Remplissez le formulaire ci-dessous pour ${isEdit ? 'modifier' : 'ajouter'} un film ou une
                            série</p>
                    </div>

                    <div class="form-body">
                        <form action="${pageContext.request.contextPath}/admin/contents/save" method="post">
                            <!-- Hidden ID for edit mode -->
                            <c:if test="${isEdit}">
                                <input type="hidden" name="id" value="${content.id}">
                            </c:if>

                            <div class="form-grid">
                                <!-- Titre -->
                                <div class="form-group full-width">
                                    <label for="titre">
                                        <i class="bi bi-film"></i> Titre <span class="required">*</span>
                                    </label>
                                    <input type="text" id="titre" name="titre" value="${content.titre}"
                                        placeholder="Ex: Inception, Breaking Bad..." required>
                                </div>

                                <!-- Type -->
                                <div class="form-group">
                                    <label for="typeContenu">
                                        <i class="bi bi-collection"></i> Type <span class="required">*</span>
                                    </label>
                                    <select id="typeContenu" name="typeContenu" required>
                                        <option value="">Sélectionner...</option>
                                        <option value="FILM" ${content.typeContenu=='FILM' ? 'selected' : '' }>Film
                                        </option>
                                        <option value="SERIE" ${content.typeContenu=='SERIE' ? 'selected' : '' }>Série
                                        </option>
                                        <option value="DOCUMENTAIRE" ${content.typeContenu=='DOCUMENTAIRE' ? 'selected' : '' }>Documentaire
                                        </option>
                                    </select>
                                </div>

                                <!-- Genres (Multi-Select Dropdown) -->
                                <div class="form-group full-width">
                                    <label class="mb-2 block text-sm font-bold uppercase tracking-widest text-gray-400">
                                        <i class="bi bi-tags"></i> Genres
                                    </label>
                                    
                                    <div class="multi-select-container" id="genresMultiSelect">
                                        <div class="selected-tags" onclick="toggleGenreDropdown(event)">
                                            <span class="placeholder text-gray-500" id="genrePlaceholder">Sélectionner les genres...</span>
                                            <!-- Selected tags will appear here -->
                                        </div>
                                        <div class="dropdown-list" id="genreDropdownList">
                                            <c:forEach items="${genres}" var="g">
                                                <div class="dropdown-item" 
                                                     data-id="${g.id}" 
                                                     data-name="${g.nom}"
                                                     onclick="selectGenre('${g.id}', '${g.nom}', event)">
                                                    <span>${g.nom}</span>
                                                    <i class="bi bi-check-lg check-icon hidden"></i>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <!-- Hidden inputs to store IDs -->
                                        <div id="hiddenGenreInputs">
                                            <c:forEach items="${content.genreIds}" var="gid">
                                                <input type="hidden" name="genreIds" value="${gid}">
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="help-text mt-2 text-gray-500 italic">
                                        Sélectionnez plusieurs genres. Cliquez sur un badge pour le retirer.
                                    </div>
                                </div>

                                <!-- Durée -->
                                <div class="form-group">
                                    <label for="dureeMinutes">
                                        <i class="bi bi-clock"></i> Durée (minutes) <span class="required">*</span>
                                    </label>
                                    <input type="number" id="dureeMinutes" name="dureeMinutes"
                                        value="${content.dureeMinutes}" placeholder="120" min="1" required>
                                    <div class="help-text">Pour les séries, indiquer la durée moyenne d'un épisode</div>
                                </div>

                                <!-- Langue -->
                                <div class="form-group">
                                    <label for="langue">
                                        <i class="bi bi-translate"></i> Langue
                                    </label>
                                    <select id="langue" name="langue">
                                        <option value="">Sélectionner...</option>
                                        <option value="Français" ${content.langue == 'Français' ? 'selected' : ''}>Français</option>
                                        <option value="Anglais" ${content.langue == 'Anglais' ? 'selected' : ''}>Anglais</option>
                                        <option value="Japonais" ${content.langue == 'Japonais' ? 'selected' : ''}>Japonais</option>
                                        <option value="Coréen" ${content.langue == 'Coréen' ? 'selected' : ''}>Coréen</option>
                                        <option value="Espagnol" ${content.langue == 'Espagnol' ? 'selected' : ''}>Espagnol</option>
                                        <option value="Italien" ${content.langue == 'Italien' ? 'selected' : ''}>Italien</option>
                                        <option value="Allemand" ${content.langue == 'Allemand' ? 'selected' : ''}>Allemand</option>
                                        <option value="Autre" ${not empty content.langue && content.langue != 'Français' && content.langue != 'Anglais' && content.langue != 'Japonais' && content.langue != 'Coréen' && content.langue != 'Espagnol' && content.langue != 'Italien' && content.langue != 'Allemand' ? 'selected' : ''}>Autre</option>
                                    </select>
                                </div>

                                <!-- Pays -->
                                <div class="form-group">
                                    <label for="pays">
                                        <i class="bi bi-globe"></i> Pays
                                    </label>
                                    <select id="pays" name="pays">
                                        <option value="">Sélectionner...</option>
                                        <option value="France" ${content.pays == 'France' ? 'selected' : ''}>France</option>
                                        <option value="USA" ${content.pays == 'USA' ? 'selected' : ''}>USA</option>
                                        <option value="UK" ${content.pays == 'UK' ? 'selected' : ''}>UK</option>
                                        <option value="Japon" ${content.pays == 'Japon' ? 'selected' : ''}>Japon</option>
                                        <option value="Corée du Sud" ${content.pays == 'Corée du Sud' ? 'selected' : ''}>Corée du Sud</option>
                                        <option value="Canada" ${content.pays == 'Canada' ? 'selected' : ''}>Canada</option>
                                        <option value="Espagne" ${content.pays == 'Espagne' ? 'selected' : ''}>Espagne</option>
                                        <option value="Italie" ${content.pays == 'Italie' ? 'selected' : ''}>Italie</option>
                                        <option value="Allemagne" ${content.pays == 'Allemagne' ? 'selected' : ''}>Allemagne</option>
                                        <option value="Inde" ${content.pays == 'Inde' ? 'selected' : ''}>Inde</option>
                                        <option value="Autre" ${not empty content.pays && content.pays != 'France' && content.pays != 'USA' && content.pays != 'UK' && content.pays != 'Japon' && content.pays != 'Corée du Sud' && content.pays != 'Canada' && content.pays != 'Espagne' && content.pays != 'Italie' && content.pays != 'Allemagne' && content.pays != 'Inde' ? 'selected' : ''}>Autre</option>
                                    </select>
                                </div>

                                <!-- Date de sortie -->
                                <div class="form-group">
                                    <label for="dateSortie">
                                        <i class="bi bi-calendar"></i> Date de sortie
                                    </label>
                                    <input type="date" id="dateSortie" name="dateSortie" value="${content.dateSortie}">
                                </div>

                                <!-- Note moyenne -->
                                <div class="form-group">
                                    <label for="noteMoyenne">
                                        <i class="bi bi-star"></i> Note moyenne
                                    </label>
                                    <input type="number" id="noteMoyenne" name="noteMoyenne"
                                        value="${content.noteMoyenne}" placeholder="7.5" min="0" max="10" step="0.1">
                                    <div class="help-text">Entre 0 et 10</div>
                                </div>

                                <!-- Nombre de votes -->
                                <div class="form-group">
                                    <label for="nbVotes">
                                        <i class="bi bi-hand-thumbs-up"></i> Nombre de votes
                                    </label>
                                    <input type="number" id="nbVotes" name="nbVotes" value="${content.nbVotes}"
                                        placeholder="0" min="0">
                                </div>

                                <!-- Poster URL -->
                                <div class="form-group full-width">
                                    <label for="posterUrl">
                                        <i class="bi bi-image"></i> URL du poster
                                    </label>
                                    <input type="url" id="posterUrl" name="posterUrl" value="${content.posterUrl}"
                                        placeholder="https://image.tmdb.org/t/p/w500/...">
                                    <div class="help-text">URL de l'image du poster (recommandé: 500x750px)</div>
                                </div>

                                <!-- Trailer URL -->
                                <div class="form-group full-width">
                                    <label for="trailerUrl">
                                        <i class="bi bi-play-circle"></i> URL de la bande-annonce
                                    </label>
                                    <input type="url" id="trailerUrl" name="trailerUrl" value="${content.trailerUrl}"
                                        placeholder="https://www.youtube.com/watch?v=...">
                                    <div class="help-text">Lien YouTube de la bande-annonce</div>
                                </div>

                                <!-- Description -->
                                <div class="form-group full-width">
                                    <label for="description">
                                        <i class="bi bi-text-paragraph"></i> Description
                                    </label>
                                    <textarea id="description" name="description"
                                        placeholder="Synopsis du film ou de la série...">${content.description}</textarea>
                                </div>
                            </div>

                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-${isEdit ? 'check' : 'plus'}-circle"></i>
                                    ${isEdit ? 'Enregistrer les modifications' : 'Ajouter le contenu'}
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">
                                    <i class="bi bi-x-circle"></i> Annuler
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Seasons Management for Series (Integrated & Dynamic) -->
        <div id="seasonsSection" class="${(isEdit && content.typeContenu == 'SERIE') ? '' : 'hidden'} container mt-8">
            <div class="form-card">
                <div class="form-header" style="background: #2F2F2F;">
                    <h1><i class="bi bi-collection-play"></i> Gestion des Saisons & Épisodes</h1>
                </div>
                
                <c:if test="${!isEdit}">
                    <div class="form-body text-center py-12">
                        <i class="bi bi-info-circle text-4xl text-gray-600 mb-4 block"></i>
                        <p class="text-gray-400 font-medium">Enregistrez d'abord la série pour pouvoir ajouter des saisons et des épisodes.</p>
                    </div>
                </c:if>

                <c:if test="${isEdit}">
                    <div class="form-body">
                        <!-- Add Season Form -->
                        <div class="mb-10 p-5 bg-black/30 border border-zinc-800 rounded-2xl">
                            <h3 class="font-bold mb-4 text-white uppercase tracking-wider text-sm flex items-center gap-2">
                                <i class="bi bi-plus-circle text-red-500"></i> Nouvelle Saison
                            </h3>
                            <form action="${pageContext.request.contextPath}/admin/seasons/add" method="post" class="flex gap-4 items-end">
                                <input type="hidden" name="contenuId" value="${content.id}">
                                <div class="w-32">
                                    <label class="block text-xs text-gray-500 mb-2 uppercase font-bold">N° Saison</label>
                                    <input type="number" name="numeroSaison" value="${saisons.size() + 1}" required min="1"
                                        class="w-full px-4 py-2 border border-zinc-800 bg-zinc-900 text-white rounded-lg focus:border-red-600 outline-none">
                                </div>
                                <button type="submit" class="bg-red-600 hover:bg-red-700 text-white px-6 py-2 rounded-lg font-bold transition-all flex items-center gap-2">
                                    <i class="bi bi-plus-lg"></i> Créer
                                </button>
                            </form>
                        </div>

                        <!-- Season Tabs / Selector -->
                        <c:if test="${not empty saisons}">
                            <div class="season-selector custom-scrollbar">
                                <c:forEach items="${saisons}" var="s" varStatus="status">
                                    <div class="season-tab ${status.first ? 'active' : ''}" 
                                         onclick="showSeason('${s.id}', this)">
                                        Saison ${s.numeroSaison}
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Episodes Container -->
                            <div id="episodesMasterContainer">
                                <c:forEach items="${saisons}" var="s" varStatus="status">
                                    <div id="seasonContent_${s.id}" class="season-content-block ${status.first ? '' : 'hidden'}">
                                        <div class="flex justify-between items-center mb-6">
                                            <div class="flex items-center gap-3">
                                                <h3 class="text-2xl font-bold text-white flex items-center gap-3">
                                                    <span class="bg-red-600/20 text-red-500 px-3 py-1 rounded-lg text-sm">SAISON ${s.numeroSaison}</span>
                                                    Catalogue des épisodes
                                                </h3>
                                                <form action="${pageContext.request.contextPath}/admin/seasons/delete/${s.id}" method="post" 
                                                      onsubmit="return confirm('Supprimer toute la saison et ses épisodes ?')" class="inline">
                                                    <input type="hidden" name="contenuId" value="${content.id}">
                                                    <button type="submit" class="text-xs text-gray-500 hover:text-red-500 transition-colors bg-zinc-800 px-2 py-1 rounded border border-zinc-700">
                                                        <i class="bi bi-trash"></i> Supprimer la saison
                                                    </button>
                                                </form>
                                            </div>
                                            <span class="text-gray-500 text-sm font-medium">${episodesMap[s.id].size()} épisodes enregistrés</span>
                                        </div>

                                        <!-- Add Episode Form -->
                                        <form action="${pageContext.request.contextPath}/admin/episodes/add" method="post"
                                            class="mb-10 p-6 bg-zinc-900/80 border border-zinc-800 rounded-2xl shadow-2xl">
                                            <input type="hidden" name="contenuId" value="${content.id}">
                                            <input type="hidden" name="saisonId" value="${s.id}">
                                            
                                            <div class="grid grid-cols-1 md:grid-cols-12 gap-4 items-end">
                                                <div class="md:col-span-1">
                                                    <label class="block text-[10px] text-zinc-500 mb-1.5 uppercase font-black tracking-tighter">№</label>
                                                    <input type="number" name="numeroEpisode" value="${episodesMap[s.id].size() + 1}" required
                                                        class="w-full px-3 py-2.5 bg-zinc-800 border-2 border-zinc-700 rounded-xl text-white font-bold focus:border-red-600 outline-none transition-all">
                                                </div>
                                                <div class="md:col-span-6">
                                                    <label class="block text-[10px] text-zinc-500 mb-1.5 uppercase font-black tracking-tighter">Titre de l'épisode</label>
                                                    <input type="text" name="titre" placeholder="Ex: Les origines..." required
                                                        class="w-full px-4 py-2.5 bg-zinc-800 border-2 border-zinc-700 rounded-xl text-white focus:border-red-600 outline-none transition-all">
                                                </div>
                                                <div class="md:col-span-2">
                                                    <label class="block text-[10px] text-zinc-500 mb-1.5 uppercase font-black tracking-tighter">Durée (min)</label>
                                                    <input type="number" name="dureeMinutes" value="45" required min="1"
                                                        class="w-full px-4 py-2.5 bg-zinc-800 border-2 border-zinc-700 rounded-xl text-white focus:border-red-600 outline-none transition-all">
                                                </div>
                                                <div class="md:col-span-3">
                                                    <button type="submit" class="w-full bg-red-600 text-white h-[48px] rounded-xl font-bold hover:bg-red-700 active:scale-95 transition-all flex items-center justify-center gap-2 shadow-lg shadow-red-600/20">
                                                        <i class="bi bi-plus-lg"></i> Ajouter l'épisode
                                                    </button>
                                                </div>
                                            </div>
                                        </form>

                                        <!-- Episodes Table/List -->
                                        <div class="space-y-3">
                                            <c:forEach items="${episodesMap[s.id]}" var="ep">
                                                <div class="ep-card group">
                                                    <div class="flex items-center gap-5">
                                                        <div class="ep-number shadow-inner">
                                                            ${ep.numeroEpisode}
                                                        </div>
                                                        <div>
                                                            <div class="font-bold text-white text-lg leading-tight">${ep.titre}</div>
                                                            <div class="flex items-center gap-3 mt-1">
                                                                <span class="text-[10px] font-black uppercase tracking-widest text-zinc-500 bg-zinc-800 px-2 py-0.5 rounded">ÉPISODE</span>
                                                                <span class="text-xs text-zinc-400 font-medium italic"><i class="bi bi-clock-history mr-1 text-red-500"></i> ${ep.dureeMinutes != null ? ep.dureeMinutes : '45'} minutes</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="flex items-center gap-3 opacity-0 group-hover:opacity-100 transition-all duration-300 transform translate-x-2 group-hover:translate-x-0">
                                                        <form action="${pageContext.request.contextPath}/admin/episodes/delete/${ep.id}" method="post" 
                                                              onsubmit="return confirm('⚠️ Supprimer cet épisode définitivement ?')" class="inline">
                                                            <input type="hidden" name="contenuId" value="${content.id}">
                                                            <button type="submit" class="w-10 h-10 flex items-center justify-center rounded-full bg-zinc-800 text-zinc-500 hover:bg-red-600 hover:text-white transition-all shadow-xl">
                                                                <i class="bi bi-trash-fill text-sm"></i>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <c:if test="${empty episodesMap[s.id]}">
                                                <div class="text-center py-10 text-gray-600 italic">
                                                    Aucun épisode pour le moment.
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>

        <script>
            // --- Multi-Select Genre Logic ---
            const selectedGenres = new Set();
            
            // Initialization: Load existing genres from hidden inputs
            document.addEventListener('DOMContentLoaded', () => {
                const hiddenInputs = document.querySelectorAll('#hiddenGenreInputs input');
                hiddenInputs.forEach(input => {
                    const id = input.value;
                    // Find name from dropdown
                    const item = document.querySelector(`.dropdown-item[data-id="${id}"]`);
                    if (item) {
                        const name = item.getAttribute('data-name');
                        addTag(id, name, false); // false = don't add to hidden again, it's already there
                        item.classList.add('selected');
                        item.querySelector('.check-icon').classList.remove('hidden');
                    }
                });
                
                // Content Type Logic
                const typeSelect = document.getElementById('typeContenu');
                typeSelect.addEventListener('change', function() {
                    const seasonsSection = document.getElementById('seasonsSection');
                    if (this.value === 'SERIE') {
                        seasonsSection.classList.remove('hidden');
                    } else {
                        seasonsSection.classList.add('hidden');
                    }
                });
            });

            function toggleGenreDropdown(e) {
                const dropdown = document.getElementById('genreDropdownList');
                const container = document.querySelector('.selected-tags');
                const isVisible = dropdown.style.display === 'block';
                
                // Close others if any
                dropdown.style.display = isVisible ? 'none' : 'block';
                container.classList.toggle('active', !isVisible);
                e.stopPropagation();
            }

            // Close dropdown when clicking outside
            document.addEventListener('click', () => {
                document.getElementById('genreDropdownList').style.display = 'none';
                document.querySelector('.selected-tags').classList.remove('active');
            });

            function selectGenre(id, name, e) {
                e.stopPropagation();
                if (selectedGenres.has(id)) {
                    removeTag(id);
                } else {
                    addTag(id, name, true);
                }
            }

            function addTag(id, name, addToHidden) {
                if (selectedGenres.has(id)) return;
                
                selectedGenres.add(id);
                document.getElementById('genrePlaceholder').classList.add('hidden');
                
                const tag = document.createElement('div');
                tag.className = 'tag';
                tag.id = `tag_${id}`;
                tag.innerHTML = `
                    <span>${name}</span>
                    <i class="bi bi-x-circle-fill" onclick="removeTag('${id}', event)"></i>
                `;
                document.querySelector('.selected-tags').appendChild(tag);
                
                // UI feedback in dropdown
                const item = document.querySelector(`.dropdown-item[data-id="${id}"]`);
                if(item) {
                    item.classList.add('selected');
                    item.querySelector('.check-icon').classList.remove('hidden');
                }

                // Add hidden input
                if (addToHidden) {
                    const hidden = document.createElement('input');
                    hidden.type = 'hidden';
                    hidden.name = 'genreIds';
                    hidden.value = id;
                    hidden.id = `hidden_${id}`;
                    document.getElementById('hiddenGenreInputs').appendChild(hidden);
                }
            }

            function removeTag(id, e) {
                if(e) e.stopPropagation();
                
                selectedGenres.delete(id);
                
                const tag = document.getElementById(`tag_${id}`);
                if (tag) tag.remove();
                
                const hidden = document.getElementById(`hidden_${id}`) || document.querySelector(`#hiddenGenreInputs input[value="${id}"]`);
                if (hidden) hidden.remove();
                
                // UI feedback
                const item = document.querySelector(`.dropdown-item[data-id="${id}"]`);
                if(item) {
                    item.classList.remove('selected');
                    item.querySelector('.check-icon').classList.add('hidden');
                }
                
                if (selectedGenres.size === 0) {
                    document.getElementById('genrePlaceholder').classList.remove('hidden');
                }
            }

            // --- Seasons Logic ---
            function showSeason(seasonId, tabElement) {
                // Deactivate all tabs
                document.querySelectorAll('.season-tab').forEach(t => t.classList.remove('active'));
                // Activate clicked tab
                tabElement.classList.add('active');
                
                // Hide all season blocks
                document.querySelectorAll('.season-content-block').forEach(b => b.classList.add('hidden'));
                // Show selected block
                document.getElementById('seasonContent_' + seasonId).classList.remove('hidden');
            }
        </script>

    </div>
</body>

        </html>