<%@ page pageEncoding="UTF-8" %>
<%@ include file="includes/header.jspf" %>
<%@ include file="includes/navbar.jspf" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="min-h-screen bg-netflix-black pt-20">
    <c:if test="${not empty error}">
        <div class="max-w-7xl mx-auto px-4 md:px-12 mt-6">
            <div class="bg-red-500/10 border border-red-500/20 text-red-500 px-6 py-4 rounded-xl flex items-center gap-4 animate-bounce">
                <i class="bi bi-exclamation-triangle-fill text-xl"></i>
                <p class="font-medium text-sm">${error}</p>
            </div>
        </div>
    </c:if>
    <c:if test="${not empty movie}">
        <!-- Hero Section for Details -->
        <div class="relative h-[60vh] md:h-[70vh] w-full overflow-hidden">
            <div class="absolute inset-0">
                <img src="${not empty movie.posterUrl ? movie.posterUrl : 'https://images.unsplash.com/photo-1440404653325-ab127d49abc1?q=80&w=2070&auto=format&fit=crop'}" 
                     class="w-full h-full object-cover blur-sm scale-110 opacity-40" alt="Backdrop">
                <div class="absolute inset-0 bg-gradient-to-t from-netflix-black via-transparent to-netflix-black/60"></div>
            </div>

            <div class="relative h-full flex flex-col md:flex-row items-center justify-center gap-8 px-4 md:px-12 max-w-7xl mx-auto">
                <!-- Poster -->
                <div class="w-48 md:w-80 flex-none shadow-2xl rounded-lg overflow-hidden -mt-10 md:mt-0 transform -rotate-2 hover:rotate-0 transition-transform duration-500">
                    <img src="${not empty movie.posterUrl ? movie.posterUrl : 'https://via.placeholder.com/400x600'}" 
                         class="w-full h-full object-cover" alt="${movie.titre}">
                </div>

                <!-- Info -->
                <div class="flex-1 text-center md:text-left">
                    <div class="flex flex-wrap items-center justify-center md:justify-start gap-3 mb-4 text-xs md:text-sm font-semibold text-gray-400">
                        <span class="text-green-400">★ ${movie.noteMoyenne} (${movie.nbVotes} votes)</span>
                        <span>
                            <fmt:formatDate value="${movie.dateSortie}" pattern="yyyy" />
                        </span>
                        <span class="px-2 border border-gray-600 rounded text-[10px]">${movie.typeContenu}</span>
                        <span>${movie.dureeMinutes} min</span>
                    </div>
                    
                    <h1 class="text-4xl md:text-6xl font-bold mb-6">${movie.titre}</h1>
                    
                    <p class="text-gray-300 text-base md:text-lg mb-8 leading-relaxed max-w-2xl mx-auto md:mx-0">
                        ${movie.description}
                    </p>

                    <div class="flex flex-wrap items-center justify-center md:justify-start gap-4">
                        <c:if test="${not empty movie.trailerUrl}">
                            <a href="#trailer" class="bg-white text-black py-3 px-8 rounded-md font-bold flex items-center gap-2 hover:bg-gray-200 transition-all shadow-lg active:scale-95">
                                <i class="bi bi-play-fill text-2xl"></i> Regarder le Trailer
                            </a>
                        </c:if>

                        <c:if test="${not empty sessionScope.user}">
                            <form action="${pageContext.request.contextPath}/favorites/${isFavorite ? 'remove' : 'add'}/${movie.id}" method="post">
                                <button type="submit" class="bg-gray-500/30 text-white py-3 px-6 rounded-md font-bold flex items-center gap-2 hover:bg-white/20 transition-all border border-white/10">
                                    <i class="bi ${isFavorite ? 'bi-check-lg' : 'bi-plus-lg'} text-xl"></i> 
                                    ${isFavorite ? 'Ma Liste' : 'Ma Liste'}
                                </button>
                            </form>
                        </c:if>

                        <!-- Mini Rating Component -->
                        <c:if test="${not empty sessionScope.user}">
                            <form action="${pageContext.request.contextPath}/movies/${movie.id}/rate" method="post" class="flex items-center bg-white/10 p-1 rounded-lg border border-white/10">
                                <select name="note" class="bg-transparent text-white border-none text-sm focus:ring-0">
                                    <option value="10" class="text-black">10 - Masterpiece</option>
                                    <option value="9" class="text-black">9 - Excellent</option>
                                    <option value="8" class="text-black">8 - Très Bon</option>
                                    <option value="7" class="text-black">7 - Bon</option>
                                    <option value="6" class="text-black">6 - Moyen</option>
                                    <option value="5" class="text-black">5 - Mediocre</option>
                                </select>
                                <button type="submit" class="bg-netflix-red text-white py-1.5 px-3 rounded uppercase text-[10px] font-bold">Noter</button>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <div class="max-w-7xl mx-auto px-4 md:px-12 py-16 grid lg:grid-cols-3 gap-12">
            <div class="lg:col-span-2 space-y-16">
                <!-- Trailer Section (Integrated) -->
                <c:if test="${not empty movie.trailerUrl}">
                    <div id="trailer" class="scroll-mt-32">
                        <h2 class="text-2xl font-bold mb-6 flex items-center gap-3">
                            <i class="bi bi-play-circle text-netflix-red"></i> Bande-annonce
                        </h2>
                        <div class="aspect-video w-full rounded-2xl overflow-hidden shadow-2xl border border-white/10 bg-black">
                            <iframe src="${movie.getYouTubeEmbedUrl()}" 
                                    class="w-full h-full" 
                                    frameborder="0" 
                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                                    allowfullscreen>
                            </iframe>
                        </div>
                    </div>
                </c:if>

                <!-- Comments Section -->
                <div>
                    <h2 class="text-2xl font-bold mb-6 flex items-center gap-3">
                        <i class="bi bi-chat-left-text text-netflix-red"></i> Commentaires (${comments.size()})
                    </h2>
                    
                    <c:if test="${not empty sessionScope.user}">
                        <form action="${pageContext.request.contextPath}/movies/${movie.id}/comment" method="post" class="mb-10 bg-white/5 p-6 rounded-2xl border border-white/10">
                            <textarea name="texte" required rows="3" 
                                      class="w-full bg-netflix-black border border-white/10 rounded-xl p-4 text-white focus:ring-2 focus:ring-netflix-red focus:border-transparent transition-all"
                                      placeholder="Laissez un commentaire..."></textarea>
                            <div class="mt-4 flex justify-end">
                                <button type="submit" class="bg-netflix-red text-white px-8 py-2 rounded-lg font-bold hover:bg-red-700 transition-all">
                                    Publier
                                </button>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${empty sessionScope.user}">
                        <div class="mb-10 p-6 bg-white/5 rounded-2xl border border-dashed border-white/20 text-center">
                            <p class="text-gray-400 text-sm">Veuillez vous <a href="${pageContext.request.contextPath}/login" class="text-white font-bold underline">connecter</a> pour laisser un commentaire.</p>
                        </div>
                    </c:if>

                    <div class="bg-white/5 border border-white/5 rounded-2xl p-6">
                        <c:if test="${empty comments}">
                            <div class="py-12 text-center">
                                <p class="text-gray-600 italic">Pas encore de commentaires pour ce film.</p>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty comments}">
                            <div class="space-y-6">
                                <c:forEach items="${comments}" var="comment">
                                    <div class="border-b border-white/5 pb-6 last:border-0 last:pb-0">
                                        <div class="flex justify-between items-start mb-4">
                                            <div class="flex items-center gap-3">
                                                <div class="w-10 h-10 bg-gray-700 rounded-full flex items-center justify-center font-bold text-xs uppercase">
                                                    <c:choose>
                                                        <c:when test="${not empty comment.utilisateurNom}">
                                                            ${comment.utilisateurNom.substring(0,1)}
                                                        </c:when>
                                                        <c:otherwise>U</c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div>
                                                    <h4 class="font-bold text-sm">
                                                        <c:out value="${not empty comment.utilisateurNom ? comment.utilisateurNom : 'Utilisateur anonyme'}" />
                                                    </h4>
                                                    <span class="text-[10px] text-gray-500 uppercase tracking-widest">
                                                        <fmt:formatDate value="${comment.dateCreation}" pattern="dd MMM yyyy" />
                                                    </span>
                                                </div>
                                            </div>
                                            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                                <form action="${pageContext.request.contextPath}/admin/comments/block/${comment.id}" method="post">
                                                    <input type="hidden" name="movieId" value="${movie.id}">
                                                    <button type="submit" class="text-red-500 text-xs hover:underline">Bloquer</button>
                                                </form>
                                            </c:if>
                                        </div>
                                        <p class="text-gray-300 text-sm leading-relaxed">${comment.texte}</p>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Seasons & Episodes Section (Only for Series) -->
                <c:if test="${movie.typeContenu == 'Serie'}">
                    <div class="mt-12">
                        <h2 class="text-2xl font-bold mb-6 flex items-center gap-3">
                            <i class="bi bi-stack text-netflix-red"></i> Saisons & Épisodes
                        </h2>
                        
                        <div class="flex flex-wrap gap-3 mb-8">
                            <c:forEach items="${saisons}" var="saison" varStatus="status">
                                <button onclick="loadEpisodes('${saison.id}', this)" 
                                        class="season-tab px-6 py-2 rounded-full border border-white/10 hover:bg-white/10 transition-all font-semibold ${status.first ? 'bg-netflix-red border-netflix-red' : ''}">
                                    Saison ${saison.numeroSaison}
                                </button>
                                <c:if test="${status.first}">
                                    <script>
                                        document.addEventListener('DOMContentLoaded', () => {
                                            loadEpisodes('${saison.id}', document.querySelector('.season-tab'));
                                        });
                                    </script>
                                </c:if>
                            </c:forEach>
                        </div>

                        <div id="episodes-container" class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <!-- Episodes will be loaded here via JS -->
                            <div class="col-span-full py-10 text-center text-gray-500 italic">
                                Chargement des épisodes...
                            </div>
                        </div>
                    </div>

                    <script>
                        function loadEpisodes(saisonId, btn) {
                            // Style active tab
                            document.querySelectorAll('.season-tab').forEach(b => b.classList.remove('bg-netflix-red', 'border-netflix-red'));
                            btn.classList.add('bg-netflix-red', 'border-netflix-red');

                            const container = document.getElementById('episodes-container');
                            container.innerHTML = '<div class="col-span-full py-10 text-center text-gray-500 italic">Chargement...</div>';

                            fetch(`${pageContext.request.contextPath}/movies/saisons/\${saisonId}/episodes`)
                                .then(response => response.json())
                                .then(episodes => {
                                    if(episodes.length === 0) {
                                        container.innerHTML = '<div class="col-span-full py-10 text-center text-gray-500 italic">Aucun épisode trouvé pour cette saison.</div>';
                                        return;
                                    }
                                    container.innerHTML = episodes.map(ep => `
                                        <div class="bg-white/5 border border-white/5 p-4 rounded-xl flex items-center gap-4 hover:bg-white/10 transition-all group cursor-pointer">
                                            <div class="w-12 h-12 flex-none bg-netflix-black rounded-lg flex items-center justify-center font-bold text-netflix-red group-hover:bg-netflix-red group-hover:text-white transition-colors">
                                                \${ep.numeroEpisode}
                                            </div>
                                            <div class="flex-1 min-w-0">
                                                <h4 class="font-bold text-sm truncate">\${ep.titre}</h4>
                                                <p class="text-[10px] text-gray-500 uppercase tracking-widest">\${ep.dureeMinutes} minutes</p>
                                            </div>
                                            <i class="bi bi-play-circle text-xl opacity-0 group-hover:opacity-100 transition-opacity"></i>
                                        </div>
                                    `).join('');
                                })
                                .catch(err => {
                                    console.error('Error loading episodes:', err);
                                    container.innerHTML = '<div class="col-span-full py-10 text-center text-red-500 italic">Erreur lors du chargement des épisodes.</div>';
                                });
                        }
                    </script>
                </c:if>
            </div>

            <!-- Sidebar -->
            <div class="space-y-8">
                <div class="bg-netflix-darkGray p-8 rounded-2xl border border-white/5 shadow-2xl">
                    <h3 class="font-bold mb-6 uppercase tracking-widest text-xs text-gray-400">Score CineStream</h3>
                    <div class="flex items-end gap-2 mb-4">
                        <span class="text-6xl font-black text-white">${movie.noteMoyenne}</span>
                        <span class="text-gray-500 mb-2">/ 10</span>
                    </div>
                    <div class="w-full bg-gray-800 h-2.5 rounded-full overflow-hidden mb-2">
                        <div class="bg-green-500 h-full" style="width: ${movie.noteMoyenne * 10}%"></div>
                    </div>
                    <p class="text-[11px] text-gray-400 leading-relaxed font-medium">
                        Basé sur ${movie.nbVotes} avis de la communauté.
                    </p>
                </div>

                <div class="bg-netflix-darkGray/50 p-8 rounded-2xl border border-white/5">
                    <h3 class="font-bold mb-6 uppercase tracking-widest text-xs text-gray-400">Détails</h3>
                    <ul class="space-y-4 text-sm">
                        <li class="flex justify-between">
                            <span class="text-gray-500">Langue</span>
                            <span class="text-white">${movie.langue}</span>
                        </li>
                        <li class="flex justify-between">
                            <span class="text-gray-500">Pays</span>
                            <span class="text-white">${movie.pays}</span>
                        </li>
                        <li class="flex justify-between">
                            <span class="text-gray-500">Durée</span>
                            <span class="text-white">${movie.dureeMinutes} min</span>
                        </li>
                        <li class="flex justify-between">
                            <span class="text-gray-500">Genre</span>
                            <span class="text-white">
                                <c:forEach items="${genreNames}" var="genre" varStatus="loop">
                                    ${genre}${!loop.last ? ', ' : ''}
                                </c:forEach>
                            </span>
                        </li>
                    </ul>
                </div>

                <!-- Cast & Crew -->
                <c:if test="${not empty actors}">
                    <div class="bg-netflix-darkGray/50 p-8 rounded-2xl border border-white/5">
                        <h3 class="font-bold mb-6 uppercase tracking-widest text-xs text-gray-400">Acteurs & Équipe</h3>
                        <div class="space-y-4">
                            <c:forEach items="${actors}" var="actor">
                                <div class="flex items-center gap-3 group cursor-pointer">
                                    <div class="w-10 h-10 bg-gray-700 rounded-full flex items-center justify-center font-bold text-xs uppercase group-hover:bg-netflix-red transition-colors">
                                        ${actor.nom.substring(0,1)}
                                    </div>
                                    <div class="flex-1">
                                        <p class="text-sm font-bold group-hover:text-netflix-red transition-colors">${actor.nom}</p>
                                        <p class="text-[10px] text-gray-500 uppercase">${actor.role} <c:if test="${not empty actor.personnage}"> • ${actor.personnage}</c:if></p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="includes/footer.jspf" %>
