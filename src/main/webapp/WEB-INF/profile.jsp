<%@ include file="includes/header.jspf" %>
<%@ include file="includes/navbar.jspf" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="pt-32 pb-20 px-4 md:px-12 max-w-6xl mx-auto">
    <div class="flex flex-col md:flex-row gap-12">
        
        <!-- Profile Sidebar -->
        <div class="w-full md:w-1/3 lg:w-1/4">
            <div class="bg-netflix-darkGray/50 border border-white/5 rounded-2xl p-8 text-center sticky top-32">
                <div class="w-24 h-24 bg-netflix-red rounded-xl mx-auto flex items-center justify-center text-4xl font-bold shadow-2xl mb-6 shadow-red-900/20">
                    ${sessionScope.user.nom.substring(0,1)}${sessionScope.user.prenom.substring(0,1)}
                </div>
                <h2 class="text-xl font-bold text-white mb-1">${sessionScope.user.nom} ${sessionScope.user.prenom}</h2>
                <p class="text-gray-500 text-sm mb-6">${sessionScope.user.email}</p>
                
                <div class="space-y-2">
                    <div class="inline-flex items-center gap-2 bg-yellow-500/10 text-yellow-500 px-4 py-1.5 rounded-full text-xs font-bold border border-yellow-500/20">
                        <i class="bi bi-star-fill"></i> ${badge.nom} (Niveau ${badge.niveau})
                    </div>
                    <div class="text-[10px] text-gray-500 font-bold uppercase tracking-widest">
                        Score d'activité: <span class="text-white">${score}</span>
                    </div>
                </div>

                <div class="mt-10 space-y-2">
                    <button onclick="showSection('settings', this)" class="menu-btn w-full text-left px-4 py-3 rounded-lg bg-white/5 text-white hover:bg-white/10 transition-colors text-sm font-medium border border-white/5">
                        <i class="bi bi-person mr-3"></i> Paramètres
                    </button>
                    <button onclick="showSection('favorites', this)" class="menu-btn w-full text-left px-4 py-3 rounded-lg text-gray-400 hover:text-white hover:bg-white/5 transition-colors text-sm font-medium">
                        <i class="bi bi-heart mr-3"></i> Mes Favoris
                    </button>
                    <button onclick="showSection('history', this)" class="menu-btn w-full text-left px-4 py-3 rounded-lg text-gray-400 hover:text-white hover:bg-white/5 transition-colors text-sm font-medium">
                        <i class="bi bi-clock-history mr-3"></i> Historique
                    </button>
                    <div class="pt-4 mt-4 border-t border-white/5">
                        <a href="${pageContext.request.contextPath}/logout" class="block w-full text-left px-4 py-3 rounded-lg text-red-500 hover:bg-red-500/10 transition-colors text-sm font-medium">
                            <i class="bi bi-box-arrow-right mr-3"></i> Déconnexion
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="flex-1">
            <!-- Settings Section -->
            <div id="settings-section" class="section-content bg-netflix-darkGray/50 border border-white/5 rounded-2xl p-8 md:p-10">
                <h3 class="text-2xl font-bold text-white mb-8 border-b border-white/5 pb-4">Modifier mon Profil</h3>
                
                <c:if test="${param.success == 'true'}">
                    <div class="mb-8 bg-green-500/10 border border-green-500/20 text-green-500 px-6 py-4 rounded-xl flex items-center gap-4 animate-fade-in">
                        <i class="bi bi-check-circle-fill text-xl"></i>
                        <p class="font-medium text-sm">Vos informations ont été mises à jour avec succès.</p>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/profile/update" method="post" class="space-y-8">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                        <div>
                            <label class="block text-xs font-bold text-gray-500 uppercase tracking-widest mb-3 ml-1">Nom de famille</label>
                            <input type="text" name="nom" value="${sessionScope.user.nom}"
                                   class="w-full bg-netflix-black border border-white/10 rounded-xl py-3 px-5 text-white focus:outline-none focus:ring-2 focus:ring-netflix-red focus:border-transparent transition-all">
                        </div>
                        <div>
                            <label class="block text-xs font-bold text-gray-500 uppercase tracking-widest mb-3 ml-1">Prénom</label>
                            <input type="text" name="prenom" value="${sessionScope.user.prenom}"
                                   class="w-full bg-netflix-black border border-white/10 rounded-xl py-3 px-5 text-white focus:outline-none focus:ring-2 focus:ring-netflix-red focus:border-transparent transition-all">
                        </div>
                    </div>

                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase tracking-widest mb-3 ml-1">Adresse Email (Non modifiable)</label>
                        <input type="email" value="${sessionScope.user.email}" disabled
                               class="w-full bg-netflix-black/50 border border-white/5 rounded-xl py-3 px-5 text-gray-500 cursor-not-allowed">
                    </div>

                    <div class="pt-6 border-t border-white/5 flex justify-end gap-4">
                        <button type="submit" 
                                class="bg-netflix-red text-white px-10 py-3 rounded-xl font-bold hover:bg-red-700 active:scale-95 transition-all shadow-xl shadow-red-900/40">
                            Enregistrer les modifications
                        </button>
                    </div>
                </form>
            </div>

            <!-- Favorites Section -->
            <div id="favorites-section" class="section-content hidden bg-netflix-darkGray/50 border border-white/5 rounded-2xl p-8 md:p-10">
                <h3 class="text-2xl font-bold text-white mb-8 border-b border-white/5 pb-4">Mes Favoris</h3>
                
                <c:if test="${empty favoriteMovies}">
                    <div class="text-center py-10">
                        <i class="bi bi-heart text-4xl text-gray-600 mb-4 block"></i>
                        <p class="text-gray-500">Vous n'avez pas encore ajouté de favoris.</p>
                        <a href="${pageContext.request.contextPath}/movies" class="inline-block mt-4 text-netflix-red font-bold hover:underline">Explorer les films</a>
                    </div>
                </c:if>

                <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                    <c:forEach items="${favoriteMovies}" var="movie">
                        <a href="${pageContext.request.contextPath}/movies/${movie.id}" class="group block relative rounded-lg overflow-hidden bg-netflix-black aspect-[2/3] hover:ring-2 ring-netflix-red transition-all">
                            <img src="${not empty movie.posterUrl ? movie.posterUrl : 'https://via.placeholder.com/200x300'}" 
                                 class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" 
                                 alt="${movie.titre}">
                            <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex items-end p-3">
                                <p class="text-xs font-bold text-white truncate w-full">${movie.titre}</p>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>

            <!-- History Section -->
            <div id="history-section" class="section-content hidden bg-netflix-darkGray/50 border border-white/5 rounded-2xl p-8 md:p-10">
                <h3 class="text-2xl font-bold text-white mb-8 border-b border-white/5 pb-4">Historique de visionnage</h3>
                
                <c:if test="${empty historyItems}">
                    <div class="text-center py-10">
                        <i class="bi bi-clock-history text-4xl text-gray-600 mb-4 block"></i>
                        <p class="text-gray-500">Aucun historique disponible.</p>
                    </div>
                </c:if>

                <div class="space-y-4">
                    <c:forEach items="${historyItems}" var="item">
                        <c:set var="movie" value="${item.movie}" />
                        <div class="flex items-center gap-4 bg-white/5 p-4 rounded-xl border border-white/5 hover:bg-white/10 transition-colors">
                            <div class="w-16 h-24 flex-none rounded bg-netflix-black overflow-hidden relative">
                                <img src="${not empty movie.posterUrl ? movie.posterUrl : 'https://via.placeholder.com/100x150'}" 
                                     class="w-full h-full object-cover">
                            </div>
                            <div class="flex-1 min-w-0">
                                <div class="flex items-center gap-2 mb-1">
                                    <span class="text-[10px] font-bold uppercase tracking-widest 
                                        ${item.typeInteraction == 'VUE' ? 'text-blue-400' : ''}
                                        ${item.typeInteraction == 'LIKE' ? 'text-red-400' : ''}
                                        ${item.typeInteraction == 'COMMENTAIRE' ? 'text-green-400' : ''}
                                        ${item.typeInteraction == 'EVALUATION' ? 'text-yellow-400' : ''}">
                                        ${item.typeInteraction}
                                    </span>
                                    <span class="text-[10px] text-gray-500">
                                        <fmt:formatDate value="${item.date}" pattern="dd/MM HH:mm" />
                                    </span>
                                </div>
                                <h4 class="font-bold text-white text-lg truncate">${movie.titre}</h4>
                                <div class="flex items-center gap-2 text-xs text-gray-400 mt-1">
                                    <span class="px-2 py-0.5 border border-white/20 rounded">${movie.typeContenu}</span>
                                    <span>${movie.dureeMinutes} min</span>
                                </div>
                            </div>
                            <a href="${pageContext.request.contextPath}/movies/${movie.id}" class="w-10 h-10 rounded-full bg-white text-black flex items-center justify-center hover:bg-netflix-red hover:text-white transition-colors">
                                <i class="bi bi-play-fill text-xl ml-0.5"></i>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Stats/Badges Placeholder (Dynamic) -->
            <div class="mt-12 grid grid-cols-1 sm:grid-cols-3 gap-6">
                <div class="bg-netflix-darkGray/30 border border-white/5 rounded-2xl p-6 flex flex-col items-center justify-center text-center">
                    <span class="text-3xl font-black text-white mb-1">${watchedCount}</span>
                    <span class="text-[10px] text-gray-500 uppercase tracking-widest font-bold">Films Vus</span>
                </div>
                <div class="bg-netflix-darkGray/30 border border-white/5 rounded-2xl p-6 flex flex-col items-center justify-center text-center">
                    <span class="text-3xl font-black text-netflix-red mb-1">${favCount}</span>
                    <span class="text-[10px] text-gray-500 uppercase tracking-widest font-bold">Favoris</span>
                </div>
                <div class="bg-netflix-darkGray/30 border border-white/5 rounded-2xl p-6 flex flex-col items-center justify-center text-center">
                    <span class="text-3xl font-black text-yellow-500 mb-1">${badgeCount}</span>
                    <span class="text-[10px] text-gray-500 uppercase tracking-widest font-bold">Badges</span>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function showSection(sectionName, btn) {
    // Hide all sections
    document.querySelectorAll('.section-content').forEach(el => el.classList.add('hidden'));
    // Show selected section
    document.getElementById(sectionName + '-section').classList.remove('hidden');
    
    // Update button styles
    document.querySelectorAll('.menu-btn').forEach(b => {
        b.classList.remove('bg-white/5', 'text-white', 'border-white/5');
        b.classList.add('text-gray-400', 'hover:text-white');
    });
    
    btn.classList.remove('text-gray-400', 'hover:text-white');
    btn.classList.add('bg-white/5', 'text-white', 'border-white/5');
}
</script>

<%@ include file="includes/footer.jspf" %>