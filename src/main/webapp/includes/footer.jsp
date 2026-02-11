</main>

<footer class="border-t border-slate-800 bg-slate-900 mt-12">
    <div class="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
        <div class="flex flex-col md:flex-row justify-between items-center gap-6">
            <div class="flex items-center gap-2">
                <span class="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-blue-400 to-indigo-600">CineStream</span>
                <span class="text-slate-500 text-sm">© 2026</span>
            </div>
            
            <div class="flex gap-8 text-sm text-slate-400">
                <a href="#" class="hover:text-white transition-colors">Politique de confidentialité</a>
                <a href="#" class="hover:text-white transition-colors">Conditions d'utilisation</a>
                <a href="#" class="hover:text-white transition-colors">Contact</a>
            </div>
        </div>
    </div>
</footer>

<!-- Scripts -->
<script src="${pageContext.request.contextPath}/assets/js/api.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/ui.js"></script>
<script>
    // Global Auth Check
    document.addEventListener('DOMContentLoaded', () => {
        const user = localStorage.getItem('user');
        const authContainer = document.getElementById('auth-buttons');
        if (user && authContainer) {
            const userData = JSON.parse(user);
            authContainer.innerHTML = `
                <a href="${pageContext.request.contextPath}/profile.jsp" class="flex items-center gap-2 hover:bg-slate-800 p-1.5 rounded-lg transition-colors">
                    <img src="https://ui-avatars.com/api/?name=\${userData.username}&background=random" class="w-6 h-6 rounded-full">
                    <span class="text-sm font-medium text-slate-200">\${userData.username}</span>
                </a>
                <button onclick="ApiService.logout()" class="text-slate-400 hover:text-white">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path></svg>
                </button>
            `;
        }
    });

    // Global Search
    const searchInput = document.getElementById('nav-search');
    if(searchInput) {
        searchInput.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                window.location.href = '${pageContext.request.contextPath}/movies.jsp?query=' + encodeURIComponent(e.target.value);
            }
        });
    }
</script>
</body>
</html>
