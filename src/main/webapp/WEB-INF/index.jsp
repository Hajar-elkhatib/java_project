<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jspf" %>
<%@ include file="includes/navbar.jspf" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Hero Banner -->
<div class="relative h-[85vh] w-full">
    <!-- Background Image -->
    <div class="absolute inset-0">
        <img src="https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=2070&auto=format&fit=crop" 
             class="w-full h-full object-cover" alt="Hero Banner">
        <div class="absolute inset-0 bg-gradient-to-r from-netflix-black via-netflix-black/60 to-transparent"></div>
        <div class="absolute inset-0 hero-gradient"></div>
    </div>

    <!-- Hero Content -->
    <div class="relative h-full flex flex-col justify-center px-4 md:px-12 pt-20 max-w-2xl">
        <h1 class="text-4xl md:text-6xl font-bold mb-4 drop-shadow-2xl">CineStream</h1>
        <p class="text-base md:text-lg text-gray-200 mb-8 line-clamp-3">
            Découvrez les meilleurs films, séries et documentaires en streaming. Créez votre liste, notez vos favoris et profitez d'une expérience immersive pensée pour vous.
        </p>
        <div class="flex items-center gap-3">
            <a href="${pageContext.request.contextPath}/movies" 
               class="bg-white text-black font-bold py-2 px-8 rounded flex items-center gap-2 hover:bg-gray-200 transition-colors">
                <i class="bi bi-play-fill text-2xl"></i> Lecture
            </a>
            <a href="${pageContext.request.contextPath}/recommendations" 
               class="bg-gray-500/50 text-white font-bold py-2 px-8 rounded flex items-center gap-2 hover:bg-gray-500/40 transition-colors backdrop-blur-md">
                <i class="bi bi-info-circle text-xl"></i> Plus d'infos
            </a>
        </div>
    </div>
</div>

<!-- Movie Sections -->
<div class="relative -mt-32 pb-20 px-4 md:px-12 space-y-12">
    
    <!-- À la Une section (Featured) -->
    <section>
        <div class="flex items-center justify-between mb-4">
            <h2 class="text-xl md:text-2xl font-semibold">À la une sur CineStream</h2>
            <a href="${pageContext.request.contextPath}/movies" class="text-gray-400 hover:text-white text-sm font-medium transition-colors">Tout explorer</a>
        </div>
        
        <div class="flex overflow-x-auto gap-4 py-4 hide-scrollbar scroll-smooth">
            <c:forEach items="${featuredContents}" var="content">
                <!-- Movie Card -->
                <div class="flex-none w-40 md:w-56 movie-card-zoom cursor-pointer" 
                     onclick="window.location.href='${pageContext.request.contextPath}/movies/${content.id}'">
                    <div class="relative aspect-[2/3] rounded-md overflow-hidden shadow-2xl">
                        <img src="${not empty content.posterUrl ? content.posterUrl : 'https://via.placeholder.com/300x450?text=CineStream'}" 
                             class="w-full h-full object-cover" alt="${content.titre}">
                        
                        <!-- Mini Info Overlay (visible on hover) -->
                        <div class="absolute inset-0 bg-black/60 opacity-0 hover:opacity-100 transition-opacity flex flex-col justify-end p-4">
                            <h3 class="text-sm font-bold truncate">${content.titre}</h3>
                            <div class="flex items-center justify-between mt-1">
                                <span class="text-[10px] text-green-400 font-semibold">${content.noteMoyenne} Score</span>
                                <span class="text-[10px] border border-gray-500 px-1 uppercase">${content.typeContenu}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty featuredContents}">
                 <div class="flex items-center justify-center w-full py-20 text-gray-500 italic">
                    Aucun contenu à la une pour le moment.
                 </div>
            </c:if>
        </div>
    </section>

</div>

<%@ include file="includes/footer.jspf" %>
