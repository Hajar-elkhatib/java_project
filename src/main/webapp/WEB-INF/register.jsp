<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="includes/header.jspf" %>
        <div class="min-h-screen flex items-center justify-center relative px-4 py-32 overflow-hidden">
            <!-- Background Decoration -->
            <div class="absolute inset-0 z-0">
                <img src="https://images.unsplash.com/photo-1574267431850-281fd752458a?q=80&w=2000&auto=format&fit=crop"
                    class="w-full h-full object-cover opacity-20 blur-sm scale-105" alt="Register Background">
                <div class="absolute inset-0 bg-gradient-to-b from-transparent via-netflix-black/60 to-netflix-black">
                </div>
            </div>

            <!-- Register Card -->
            <div
                class="relative z-10 w-full max-w-xl bg-black/70 backdrop-blur-xl border border-white/10 rounded-2xl p-8 md:p-12 shadow-2xl">
                <div class="text-center mb-10">
                    <a href="${pageContext.request.contextPath}/"
                        class="text-netflix-red text-4xl font-black uppercase tracking-tighter mb-4 inline-block">CineStream</a>
                    <h2 class="text-2xl font-bold text-white">Rejoindre l'aventure</h2>
                    <p class="text-gray-400 text-sm mt-2">Créez votre compte en quelques secondes.</p>
                </div>

                <c:if test="${not empty error}">
                    <div
                        class="mb-6 bg-red-500/10 border border-red-500/50 text-red-500 text-sm p-4 rounded-lg flex items-center gap-3 animate-pulse">
                        <i class="bi bi-exclamation-circle text-lg"></i>
                        <p>${error}</p>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="post" class="space-y-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label
                                class="block text-xs font-bold text-gray-400 uppercase tracking-widest mb-1.5 ml-1">Nom</label>
                            <input type="text" name="nom" required
                                class="w-full bg-netflix-lightGray/50 border border-white/5 rounded-lg py-3 px-4 text-white focus:outline-none focus:ring-2 focus:ring-netflix-red focus:bg-netflix-lightGray transition-all"
                                placeholder="Nom">
                        </div>
                        <div>
                            <label
                                class="block text-xs font-bold text-gray-400 uppercase tracking-widest mb-1.5 ml-1">Prénom</label>
                            <input type="text" name="prenom" required
                                class="w-full bg-netflix-lightGray/50 border border-white/5 rounded-lg py-3 px-4 text-white focus:outline-none focus:ring-2 focus:ring-netflix-red focus:bg-netflix-lightGray transition-all"
                                placeholder="Prénom">
                        </div>
                    </div>

                    <div>
                        <label
                            class="block text-xs font-bold text-gray-400 uppercase tracking-widest mb-1.5 ml-1">Email</label>
                        <input type="email" name="email" required
                            class="w-full bg-netflix-lightGray/50 border border-white/5 rounded-lg py-3 px-4 text-white focus:outline-none focus:ring-2 focus:ring-netflix-red focus:bg-netflix-lightGray transition-all"
                            placeholder="votre@email.com">
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label
                                class="block text-xs font-bold text-gray-400 uppercase tracking-widest mb-1.5 ml-1">Mot
                                de passe</label>
                            <input type="password" name="motDePasse" required
                                class="w-full bg-netflix-lightGray/50 border border-white/5 rounded-lg py-3 px-4 text-white focus:outline-none focus:ring-2 focus:ring-netflix-red focus:bg-netflix-lightGray transition-all"
                                placeholder="••••••••">
                        </div>
                        <div>
                            <label
                                class="block text-xs font-bold text-gray-400 uppercase tracking-widest mb-1.5 ml-1">Confirmer</label>
                            <input type="password" name="confirmPassword" required
                                class="w-full bg-netflix-lightGray/50 border border-white/5 rounded-lg py-3 px-4 text-white focus:outline-none focus:ring-2 focus:ring-netflix-red focus:bg-netflix-lightGray transition-all"
                                placeholder="••••••••">
                        </div>
                    </div>

                    <button type="submit"
                        class="w-full bg-netflix-red text-white py-4 rounded-lg font-bold text-lg hover:bg-red-700 active:scale-[0.98] transition-all shadow-xl shadow-red-900/40 mt-4">
                        Créer mon compte
                    </button>
                </form>

                <div class="mt-10 pt-8 border-t border-white/5 text-center">
                    <p class="text-gray-500 text-sm">
                        Déjà membre ?
                        <a href="${pageContext.request.contextPath}/login"
                            class="text-white font-bold hover:underline transition-all">Connectez-vous</a>.
                    </p>
                </div>
            </div>
        </div>
        </body>

        </html>