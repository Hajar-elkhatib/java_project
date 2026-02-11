<%@ include file="includes/header.jspf" %>
<%@ include file="includes/navbar.jspf" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="pt-32 pb-20 px-4 md:px-12 space-y-16">
    
    <header class="max-w-3xl">
        <h1 class="text-3xl md:text-5xl font-bold mb-4">Recommandations</h1>
        <p class="text-gray-400 text-lg">Découvrez une sélection personnalisée basée sur vos goûts. Les meilleurs contenus triés pour votre plaisir.</p>
    </header>

    <!-- Movies Section -->
    <section>
        <div class="flex items-center justify-between mb-4 border-l-4 border-netflix-red pl-4">
            <h2 class="text-xl md:text-2xl font-bold">Films Recommandés</h2>
        </div>
        
        <div class="flex overflow-x-auto gap-4 py-4 hide-scrollbar scroll-smooth">
            <c:forEach items="${films}" var="movie">
                <div class="flex-none w-40 md:w-56 movie-card-zoom cursor-pointer" 
                     onclick="window.location.href='${pageContext.request.contextPath}/movies/${movie.id}'">
                    <div class="relative aspect-[2/3] rounded-md overflow-hidden shadow-2xl bg-netflix-darkGray">
                        <img src="${not empty movie.posterUrl ? movie.posterUrl : 'https://via.placeholder.com/300x450?text=Film'}" 
                             class="w-full h-full object-cover" alt="${movie.titre}">
                        <div class="absolute inset-x-0 bottom-0 bg-gradient-to-t from-black p-4 opacity-0 hover:opacity-100 transition-opacity">
                            <p class="text-xs font-bold truncate">${movie.titre}</p>
                            <span class="text-[10px] text-green-400">★ ${movie.noteMoyenne}</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty films}">
                <p class="text-gray-500 italic py-10">Aucun film recommandé pour le moment.</p>
            </c:if>
        </div>
    </section>

    <!-- Series Section -->
    <section>
        <div class="flex items-center justify-between mb-4 border-l-4 border-blue-600 pl-4">
            <h2 class="text-xl md:text-2xl font-bold">Séries à ne pas manquer</h2>
        </div>
        
        <div class="flex overflow-x-auto gap-4 py-4 hide-scrollbar scroll-smooth">
            <c:forEach items="${series}" var="serie">
                <div class="flex-none w-40 md:w-56 movie-card-zoom cursor-pointer" 
                     onclick="window.location.href='${pageContext.request.contextPath}/movies/${serie.id}'">
                    <div class="relative aspect-[2/3] rounded-md overflow-hidden shadow-2xl bg-netflix-darkGray">
                        <img src="${not empty serie.posterUrl ? serie.posterUrl : 'https://via.placeholder.com/300x450?text=Serie'}" 
                             class="w-full h-full object-cover" alt="${serie.titre}">
                        <div class="absolute inset-x-0 bottom-0 bg-gradient-to-t from-black p-4 opacity-0 hover:opacity-100 transition-opacity">
                            <p class="text-xs font-bold truncate">${serie.titre}</p>
                            <span class="text-[10px] text-blue-400">${serie.dureeMinutes} min / ep</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty series}">
                <p class="text-gray-500 italic py-10">Aucune série recommandée pour le moment.</p>
            </c:if>
        </div>
    </section>

    <!-- Documentaries Section -->
    <section>
        <div class="flex items-center justify-between mb-4 border-l-4 border-green-600 pl-4">
            <h2 class="text-xl md:text-2xl font-bold">Documentaires</h2>
        </div>
        
        <div class="flex overflow-x-auto gap-4 py-4 hide-scrollbar scroll-smooth">
            <c:forEach items="${documentaires}" var="doc">
                <div class="flex-none w-40 md:w-56 movie-card-zoom cursor-pointer" 
                     onclick="window.location.href='${pageContext.request.contextPath}/movies/${doc.id}'">
                    <div class="relative aspect-[2/3] rounded-md overflow-hidden shadow-2xl bg-netflix-darkGray">
                        <img src="${not empty doc.posterUrl ? doc.posterUrl : 'https://via.placeholder.com/300x450?text=Documentaire'}" 
                             class="w-full h-full object-cover" alt="${doc.titre}">
                        <div class="absolute inset-x-0 bottom-0 bg-gradient-to-t from-black p-4 opacity-0 hover:opacity-100 transition-opacity">
                            <p class="text-xs font-bold truncate">${doc.titre}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty documentaires}">
                <p class="text-gray-500 italic py-10">Aucun documentaire recommandé pour le moment.</p>
            </c:if>
        </div>
    </section>

</div>

<%@ include file="includes/footer.jspf" %>