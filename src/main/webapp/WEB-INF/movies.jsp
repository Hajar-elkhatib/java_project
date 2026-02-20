<%@ page pageEncoding="UTF-8" %>
<%@ include file="includes/header.jspf" %>
<%@ include file="includes/navbar.jspf" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="pt-32 pb-20 px-4 md:px-12">
    <div class="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-6">
        <div>
            <h1 class="text-3xl md:text-5xl font-bold mb-2">${pageTitle != null ? pageTitle : 'Catalogue'}</h1>
            <p class="text-gray-400">Explorez notre collection complète de divertissements.</p>
        </div>
        
        <!-- Search & Filter Bar -->
        <div class="flex flex-col sm:flex-row items-center gap-3 w-full md:w-auto">
            <!-- Genre Filter Dropdown -->
            <select onchange="const url = new URL(window.location.href); if(this.value) url.searchParams.set('genreId', this.value); else url.searchParams.delete('genreId'); window.location.href=url.toString();" 
                    class="bg-white/5 border border-white/10 text-white text-sm rounded-lg py-2 px-4 focus:ring-netflix-red focus:border-netflix-red w-full sm:w-48 cursor-pointer transition-all">
                <option value="">Tous les genres</option>
                <c:forEach items="${genres}" var="g">
                    <option value="${g.id}" ${param.genreId == g.id || selectedGenreId == g.id ? 'selected' : ''}>${g.nom}</option>
                </c:forEach>
            </select>

            <form action="${pageContext.request.contextPath}/movies" method="get" class="flex items-center bg-white/5 border border-white/10 rounded-lg p-1 w-full md:w-80">
                <input type="text" name="search" value="${param.search}" 
                       class="bg-transparent border-none text-white text-sm py-2 px-4 focus:ring-0 w-full"
                       placeholder="Rechercher...">
                <!-- Keep genreId if present -->
                <c:if test="${not empty param.genreId}">
                    <input type="hidden" name="genreId" value="${param.genreId}">
                </c:if>
                <button type="submit" class="bg-netflix-red text-white p-2 rounded-md hover:bg-red-700 transition-colors">
                    <i class="bi bi-search"></i>
                </button>
            </form>
        </div>
    </div>

    <!-- Content Grid -->
    <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-6">
        <c:forEach items="${contents}" var="movie">
            <div class="movie-card-zoom cursor-pointer group" 
                 onclick="window.location.href='${pageContext.request.contextPath}/movies/${movie.id}'">
                <div class="relative aspect-[2/3] rounded-lg overflow-hidden shadow-xl bg-netflix-darkGray">
                    <img src="${not empty movie.posterUrl ? movie.posterUrl : 'https://via.placeholder.com/300x450?text=CineStream'}" 
                         class="w-full h-full object-cover group-hover:opacity-50 transition-opacity" alt="${movie.titre}">
                    
                    <!-- Hover Info -->
                    <div class="absolute inset-0 flex flex-col justify-end p-4 opacity-0 group-hover:opacity-100 transition-opacity translate-y-4 group-hover:translate-y-0 duration-300">
                        <h3 class="text-sm font-bold mb-2 line-clamp-2">${movie.titre}</h3>
                        <div class="flex items-center gap-2 mb-3">
                            <span class="text-green-400 text-xs font-bold">★ ${movie.noteMoyenne}</span>
                            <span class="text-gray-400 text-xs">•</span>
                            <span class="text-gray-300 text-xs">
                                <fmt:formatDate value="${movie.dateSortie}" pattern="yyyy" />
                            </span>
                        </div>
                        <button class="w-full py-1.5 bg-white text-black text-xs font-bold rounded hover:bg-gray-200 transition-colors">
                            Détails
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty contents}">
        <div class="py-32 text-center">
            <i class="bi bi-search text-6xl text-gray-700 mb-4 block"></i>
            <h3 class="text-xl font-medium text-gray-400">Aucun contenu trouvé</h3>
            <p class="text-gray-500 mt-2">Essayez d'ajuster vos filtres ou votre recherche.</p>
            <a href="${pageContext.request.contextPath}/movies" class="text-netflix-red hover:underline mt-4 inline-block font-semibold">Voir tout le catalogue</a>
        </div>
    </c:if>
</div>

<%@ include file="includes/footer.jspf" %>