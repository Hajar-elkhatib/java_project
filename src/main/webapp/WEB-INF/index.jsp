<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jspf" %>
<%@ include file="includes/navbar.jspf" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Hero Banner (Immersive) -->
<div class="relative h-[85vh] w-full overflow-hidden">
    <!-- Background Content -->
    <div class="absolute inset-0">
        <!-- High Quality Hero Image -->
        <img src="https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=2070&auto=format&fit=crop" 
             class="w-full h-full object-cover transform scale-105" alt="Hero Banner">
        
        <!-- Gradient Overlays for Readability & Style -->
        <div class="absolute inset-0 bg-black/30"></div> <!-- Dimmer -->
        <div class="absolute inset-0 hero-vignette"></div> <!-- Vignette -->
        <div class="absolute bottom-0 left-0 right-0 h-1/2 hero-bottom-fade"></div> <!-- Bottom Fade -->
        <div class="absolute inset-0 bg-gradient-to-r from-[#141414] via-[#141414]/50 to-transparent w-2/3"></div> <!-- Side Gradient -->
    </div>

    <!-- Hero Content -->
    <div class="relative h-full flex flex-col justify-center px-4 md:px-12 pt-24 max-w-3xl z-10">
        <!-- Animated Title/Logo -->
        <div class="transform origin-left hover:scale-105 transition-transform duration-700">
            <h1 class="text-5xl md:text-7xl font-black mb-4 drop-shadow-2xl tracking-tight leading-tight">
                CINE<span class="text-netflix-red">STREAM</span>
            </h1>
        </div>

        <div class="flex items-center gap-4 text-sm md:text-base text-gray-300 mb-6 font-medium">
            <span class="text-green-400 font-bold">98% Match</span>
            <span class="border border-gray-500 px-2 rounded-sm text-xs">TV-MA</span>
            <span>2024</span>
            <span>3 Seasons</span>
            <span class="border border-white/40 px-1 rounded text-xs">HD</span>
        </div>

        <p class="text-base md:text-xl text-gray-100 mb-10 line-clamp-3 font-medium drop-shadow-md text-shadow-sm max-w-xl">
            Plongez dans un univers où chaque histoire prend vie. Films primés, séries originales et documentaires captivants, sélectionnés spécialement pour vous.
        </p>

        <!-- CTA Buttons -->
        <div class="flex items-center gap-4">
            <a href="${pageContext.request.contextPath}/movies" 
               class="bg-white text-black text-lg font-bold py-3 px-8 rounded hover:bg-white/90 transition-all flex items-center gap-3 transform hover:scale-105 active:scale-95">
                <i class="bi bi-play-fill text-3xl -ml-1"></i> 
                <span>Lecture</span>
            </a>
            <a href="${pageContext.request.contextPath}/recommendations" 
               class="bg-gray-500/40 text-white text-lg font-bold py-3 px-8 rounded hover:bg-gray-500/30 transition-all flex items-center gap-3 backdrop-blur-md transform hover:scale-105 active:scale-95">
                <i class="bi bi-info-circle text-2xl"></i> 
                <span>Plus d'infos</span>
            </a>
        </div>
    </div>
</div>

<!-- Main Content Area -->
<div class="relative z-20 -mt-24 px-4 md:px-12 space-y-16 pb-24">
    
    <!-- Section: À la Une (Featured) -->
    <section class="group relative">
        <div class="flex items-end justify-between mb-4 px-1">
            <h2 class="text-xl md:text-2xl font-semibold text-white group-hover:text-netflix-red transition-colors cursor-pointer">
                À la une sur CineStream
                <i class="bi bi-chevron-right text-sm ml-2 opacity-0 group-hover:opacity-100 transition-opacity"></i>
            </h2>
            <div class="hidden md:flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                <!-- Pagination Indicators (Visual Only for now) -->
                <div class="w-12 h-0.5 bg-gray-600"></div>
                <div class="w-3 h-0.5 bg-gray-600"></div>
                <div class="w-3 h-0.5 bg-gray-600"></div>
            </div>
        </div>
        
        <!-- Carousel Container -->
        <div class="relative">
            <!-- Scroll Left Button -->
            <button onclick="scrollContainer('featuredContainer', -1)" 
                    class="absolute left-0 top-0 bottom-0 w-12 bg-black/50 z-40 hover:bg-black/70 flex items-center justify-center text-white scroll-btn rounded-l-md -ml-4 md:-ml-12 h-full">
                <i class="bi bi-chevron-left text-2xl"></i>
            </button>

            <!-- Scrollable Area -->
            <div id="featuredContainer" class="flex overflow-x-auto gap-4 py-8 no-scrollbar scroll-smooth pl-1 pr-12">
                <c:forEach items="${featuredContents}" var="content">
                    <!-- Standard Vertical Card -->
                    <div class="flex-none w-[160px] md:w-[220px] relative transition-all duration-300 hover:z-50 hover:scale-110 origin-center cursor-pointer group/card"
                         onclick="window.location.href='${pageContext.request.contextPath}/movies/${content.id}'">
                        
                        <div class="aspect-[2/3] rounded-md overflow-hidden shadow-lg bg-[#2f2f2f] relative">
                            <!-- Image -->
                            <img src="${not empty content.posterUrl ? content.posterUrl : 'https://via.placeholder.com/300x450?text=CineStream'}" 
                                 class="w-full h-full object-cover" 
                                 loading="lazy"
                                 alt="${content.titre}">
                            
                            <!-- Hover Overlay info -->
                            <div class="absolute inset-0 bg-gradient-to-t from-black via-transparent to-transparent opacity-0 group-hover/card:opacity-100 transition-opacity duration-300 flex flex-col justify-end p-4">
                                <div class="flex items-center gap-2 mb-2">
                                    <button class="w-8 h-8 rounded-full bg-white text-black flex items-center justify-center hover:bg-gray-200 transition-colors">
                                        <i class="bi bi-play-fill text-xl"></i>
                                    </button>
                                    <button class="w-8 h-8 rounded-full border-2 border-gray-400 text-white flex items-center justify-center hover:border-white transition-colors">
                                        <i class="bi bi-plus text-xl"></i>
                                    </button>
                                </div>
                                <h3 class="font-bold text-sm text-white mb-1 leading-tight drop-shadow-lg">${content.titre}</h3>
                                <div class="flex items-center gap-2 text-[10px] text-gray-300 font-semibold">
                                    <span class="text-green-400">98% Recommandé</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty featuredContents}">
                    <div class="w-full py-20 text-center text-gray-500 italic">
                        Le contenu arrive bientôt...
                    </div>
                </c:if>
            </div>

            <!-- Scroll Right Button -->
            <button onclick="scrollContainer('featuredContainer', 1)" 
                    class="absolute right-0 top-0 bottom-0 w-12 bg-black/50 z-40 hover:bg-black/70 flex items-center justify-center text-white scroll-btn rounded-r-md -mr-4 md:-mr-12 h-full">
                <i class="bi bi-chevron-right text-2xl"></i>
            </button>
        </div>
    </section>

    <!-- Section: Top 10 Trending -->
    <section class="group relative">
        <h2 class="text-xl md:text-2xl font-semibold text-white mb-6 px-1">Le Top 10 des tendances aujourd'hui</h2>
        
        <div class="relative">
            <!-- Scroll Buttons -->
            <button onclick="scrollContainer('trendingContainer', -1)" 
                    class="absolute left-0 top-0 bottom-0 w-12 bg-black/50 z-40 hover:bg-black/70 flex items-center justify-center text-white scroll-btn rounded-l-md -ml-4 md:-ml-12 h-full">
                <i class="bi bi-chevron-left text-2xl"></i>
            </button>

            <!-- Scrollable Area -->
            <div id="trendingContainer" class="flex overflow-x-auto gap-4 md:gap-8 py-8 no-scrollbar scroll-smooth pl-1 pr-12 items-center">
                <c:forEach items="${trendingContents}" var="content" varStatus="status">
                    <!-- Top 10 Card -->
                    <div class="flex-none flex items-center group/rank cursor-pointer transform transition-transform duration-300 hover:scale-105"
                         onclick="window.location.href='${pageContext.request.contextPath}/movies/${content.id}'">
                        
                        <!-- The Big Number -->
                        <div class="rank-number -mr-6 md:-mr-10 translate-y-2">
                            ${status.index + 1}
                        </div>
                        
                        <!-- The Poster -->
                        <div class="w-[130px] md:w-[150px] aspect-[2/3] rounded-md overflow-hidden shadow-2xl z-10 bg-[#2f2f2f]">
                             <img src="${not empty content.posterUrl ? content.posterUrl : 'https://via.placeholder.com/300x450?text=CineStream'}" 
                                 class="w-full h-full object-cover" 
                                 loading="lazy"
                                 alt="${content.titre}">
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty trendingContents}">
                     <div class="flex items-center justify-center w-full py-20 text-gray-500 italic">
                        Classement en cours de calcul...
                     </div>
                </c:if>
            </div>

            <button onclick="scrollContainer('trendingContainer', 1)" 
                    class="absolute right-0 top-0 bottom-0 w-12 bg-black/50 z-40 hover:bg-black/70 flex items-center justify-center text-white scroll-btn rounded-r-md -mr-4 md:-mr-12 h-full">
                <i class="bi bi-chevron-right text-2xl"></i>
            </button>
        </div>
    </section>

</div>

<script>
    function scrollContainer(containerId, direction) {
        const container = document.getElementById(containerId);
        const scrollAmount = window.innerWidth * 0.7; // Scroll 70% of screen width
        container.scrollBy({
            left: direction * scrollAmount,
            behavior: 'smooth'
        });
    }
</script>

<%@ include file="includes/footer.jspf" %>
