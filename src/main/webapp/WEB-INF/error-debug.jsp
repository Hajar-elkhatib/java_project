<%@ include file="includes/header.jspf" %>
<div class="min-h-screen flex items-center justify-center p-4">
    <div class="bg-netflix-darkGray p-8 rounded-2xl border border-netflix-red/30 max-w-2xl w-full shadow-2xl">
        <h1 class="text-3xl font-bold text-netflix-red mb-4 flex items-center gap-3">
            <i class="bi bi-exclamation-triangle"></i> Erreur Système
        </h1>
        <div class="space-y-4 text-gray-300">
            <p class="font-bold text-white">${errorTitle}</p>
            <div class="bg-black/50 p-4 rounded-lg font-mono text-sm border border-white/10 break-all">
                ${errorMessage}
            </div>
            <p class="text-sm italic text-gray-500">
                L'erreur a été enregistrée dans la console du serveur.
            </p>
            <div class="pt-6">
                <a href="${pageContext.request.contextPath}/" class="bg-white text-black px-6 py-2 rounded font-bold hover:bg-gray-200">
                    Retour à l'accueil
                </a>
            </div>
        </div>
    </div>
</div>
<%@ include file="includes/footer.jspf" %>
