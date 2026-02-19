<%@ include file="includes/header.jspf" %>
    <%@ include file="includes/navbar.jspf" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <div class="pt-32 pb-20 px-4 md:px-12 min-h-screen bg-black text-white">
                <div class="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-6">
                    <div>
                        <h1 class="text-3xl md:text-5xl font-bold mb-2">Historique de lecture</h1>
                        <p class="text-gray-400">Retrouvez tous les contenus que vous avez visionnés.</p>
                    </div>

                    <c:if test="${not empty history}">
                        <form action="${pageContext.request.contextPath}/history/clear" method="post"
                            onsubmit="return confirm('Voulez-vous vraiment effacer tout votre historique ?');">
                            <button type="submit"
                                class="flex items-center gap-2 px-6 py-2 bg-white/10 hover:bg-red-600 border border-white/20 rounded-full transition-all duration-300 group">
                                <i class="bi bi-trash3 group-hover:scale-110 transition-transform"></i>
                                <span>Effacer l'historique</span>
                            </button>
                        </form>
                    </c:if>
                </div>

                <!-- Watch History Grid -->
                <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-8">
                    <c:forEach items="${history}" var="item">
                        <div class="flex flex-col gap-3 group">
                            <div class="relative aspect-[2/3] rounded-xl overflow-hidden shadow-2xl bg-zinc-900 border border-white/5 cursor-pointer"
                                onclick="window.location.href='${pageContext.request.contextPath}/movies/${item.contentId}'">
                                <img src="${not empty item.posterUrl ? item.posterUrl : 'https://via.placeholder.com/300x450?text=CineStream'}"
                                    class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500 opacity-80 group-hover:opacity-100"
                                    alt="${item.title}">

                                <div
                                    class="absolute inset-0 bg-gradient-to-t from-black via-transparent to-transparent opacity-60">
                                </div>

                                <!-- Hover Play Icon -->
                                <div
                                    class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                                    <div
                                        class="w-14 h-14 bg-red-600 rounded-full flex items-center justify-center shadow-lg shadow-red-600/40">
                                        <i class="bi bi-play-fill text-3xl"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="px-1">
                                <h3 class="text-sm font-bold truncate group-hover:text-red-500 transition-colors">
                                    ${item.title}</h3>
                                <div class="flex items-center gap-1.5 mt-1 text-xs text-zinc-500 font-medium">
                                    <i class="bi bi-clock-history"></i>
                                    <span>
                                        <fmt:formatDate value="${item.watchedAt}" pattern="dd MMM yyyy, HH:mm" />
                                    </span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Empty State -->
                <c:if test="${empty history}">
                    <div class="py-40 flex flex-col items-center text-center">
                        <div
                            class="w-24 h-24 bg-zinc-900 rounded-full flex items-center justify-center mb-6 border border-white/5">
                            <i class="bi bi-collection-play text-4xl text-zinc-700"></i>
                        </div>
                        <h3 class="text-2xl font-bold text-white mb-2">Votre historique est vide</h3>
                        <p class="text-zinc-500 max-w-md">Commencez à explorer notre catalogue de films et séries. Vos
                            visionnages apparaîtront ici.</p>
                        <a href="${pageContext.request.contextPath}/movies"
                            class="mt-8 px-8 py-3 bg-red-600 hover:bg-red-700 text-white font-bold rounded-lg transition-colors">
                            Découvrir du contenu
                        </a>
                    </div>
                </c:if>
            </div>

            <%@ include file="includes/footer.jspf" %>