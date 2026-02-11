<%@ include file="includes/header.jspf" %>
<div class="min-h-screen flex items-center justify-center relative px-4 py-32 overflow-hidden">
    <!-- Background Decoration -->
    <div class="absolute inset-0 z-0">
        <img src="https://images.unsplash.com/photo-1574267431850-281fd752458a?q=80&w=2000&auto=format&fit=crop" 
             class="w-full h-full object-cover opacity-20 blur-sm scale-105" alt="Login Background">
        <div class="absolute inset-0 bg-gradient-to-b from-transparent via-netflix-black/60 to-netflix-black"></div>
    </div>

    <!-- Login Card -->
    <div class="relative z-10 w-full max-w-md bg-black/70 backdrop-blur-xl border border-white/10 rounded-2xl p-8 md:p-12 shadow-2xl">
        <div class="text-center mb-10">
            <a href="${pageContext.request.contextPath}/" class="text-netflix-red text-4xl font-black uppercase tracking-tighter mb-4 inline-block">CineStream</a>
            <h2 class="text-2xl font-bold text-white">S'identifier</h2>
        </div>

        <c:if test="${not empty error}">
            <div class="mb-6 bg-red-500/10 border border-red-500/50 text-red-500 text-sm p-4 rounded-lg flex items-center gap-3 animate-pulse">
                <i class="bi bi-exclamation-circle text-lg"></i>
                <p>${error}</p>
            </div>
        </c:if>
        
        <c:if test="${not empty param.success}">
            <div class="mb-6 bg-green-500/10 border border-green-500/50 text-green-500 text-sm p-4 rounded-lg flex items-center gap-3">
                <i class="bi bi-check-circle text-lg"></i>
                <p>Inscription réussie ! Veuillez vous connecter.</p>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-6">
            <div>
                <label class="block text-xs font-bold text-gray-400 uppercase tracking-widest mb-1.5 ml-1">Email</label>
                <input type="email" name="email" required
                       class="w-full bg-netflix-lightGray/50 border border-white/5 rounded-lg py-3 px-4 text-white focus:outline-none focus:ring-2 focus:ring-netflix-red focus:bg-netflix-lightGray transition-all"
                       placeholder="votre@email.com">
            </div>
            
            <div>
                <div class="flex items-center justify-between mb-1.5 ml-1">
                    <label class="text-xs font-bold text-gray-400 uppercase tracking-widest">Mot de passe</label>
                    <a href="#" class="text-[10px] text-gray-500 hover:text-white transition-colors">Oublié ?</a>
                </div>
                <input type="password" name="motDePasse" required
                       class="w-full bg-netflix-lightGray/50 border border-white/5 rounded-lg py-3 px-4 text-white focus:outline-none focus:ring-2 focus:ring-netflix-red focus:bg-netflix-lightGray transition-all"
                       placeholder="••••••••">
            </div>

            <button type="submit" 
                    class="w-full bg-netflix-red text-white py-3.5 rounded-lg font-bold text-lg hover:bg-red-700 active:scale-[0.98] transition-all shadow-xl shadow-red-900/40">
                Se connecter
            </button>
        </form>

        <div class="mt-10 pt-8 border-t border-white/5 text-center">
            <p class="text-gray-500 text-sm">
                Première visite sur CineStream ? 
                <a href="${pageContext.request.contextPath}/register" class="text-white font-bold hover:underline transition-all">Inscrivez-vous maintenant</a>.
            </p>
        </div>
    </div>
</div>
</body>
</html>