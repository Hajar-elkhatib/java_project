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
                                    </select>
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
                                    <input type="text" id="langue" name="langue" value="${content.langue}"
                                        placeholder="Français, Anglais...">
                                </div>

                                <!-- Pays -->
                                <div class="form-group">
                                    <label for="pays">
                                        <i class="bi bi-globe"></i> Pays
                                    </label>
                                    <input type="text" id="pays" name="pays" value="${content.pays}"
                                        placeholder="France, USA...">
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
        </body>

        </html>