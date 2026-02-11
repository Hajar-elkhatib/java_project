class UI {
    static showToast(message, type = 'info') {
        const container = document.getElementById('toast-container') || this.createToastContainer();
        const toast = document.createElement('div');
        toast.className = `toast ${type}`;

        let icon = 'ℹ️';
        if (type === 'success') icon = '✅';
        if (type === 'error') icon = '❌';
        if (type === 'warning') icon = '⚠️';

        toast.innerHTML = `<span>${icon}</span> <span>${message}</span>`;
        container.appendChild(toast);

        // Remove after 3 seconds
        setTimeout(() => {
            toast.style.opacity = '0';
            setTimeout(() => toast.remove(), 300);
        }, 3000);
    }

    static createToastContainer() {
        const container = document.createElement('div');
        container.id = 'toast-container';
        document.body.appendChild(container);
        return container;
    }

    static showLoading(elementId) {
        const el = document.getElementById(elementId);
        if (el) {
            el.innerHTML = `
                <div class="flex items-center justify-center p-12">
                    <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500"></div>
                </div>
            `;
        }
    }

    static createMovieCardSkeleton() {
        return `
            <div class="glass rounded-xl overflow-hidden p-0 animate-pulse">
                <div class="h-64 bg-slate-800 w-full"></div>
                <div class="p-4 space-y-3">
                    <div class="h-4 bg-slate-700 rounded w-3/4"></div>
                    <div class="h-3 bg-slate-700 rounded w-1/2"></div>
                    <div class="flex justify-between mt-4">
                        <div class="h-3 bg-slate-700 rounded w-1/4"></div>
                        <div class="h-3 bg-slate-700 rounded w-1/4"></div>
                    </div>
                </div>
            </div>
        `;
    }

    static renderSkeletons(containerId, count = 8) {
        const container = document.getElementById(containerId);
        if (container) {
            container.innerHTML = Array(count).fill(this.createMovieCardSkeleton()).join('');
        }
    }

    static showEmptyState(containerId, message = "Aucun contenu trouvé.") {
        const container = document.getElementById(containerId);
        if (container) {
            container.innerHTML = `
                <div class="col-span-full flex flex-col items-center justify-center py-20 text-slate-500">
                    <svg class="w-16 h-16 mb-4 opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z"></path>
                    </svg>
                    <p class="text-lg font-medium">${message}</p>
                </div>
            `;
        }
    }

    static createMovieCard(movie) {
        // Fallback image
        const poster = movie.posterUrl || 'https://via.placeholder.com/300x450?text=No+Poster';

        return `
            <div class="glass rounded-xl overflow-hidden card-hover group relative">
                <a href="movie-details.jsp?id=${movie.id}" class="block">
                    <div class="aspect-[2/3] overflow-hidden relative">
                         <img src="${poster}" alt="${movie.title}" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" loading="lazy">
                         <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end p-4">
                            <span class="text-white bg-blue-600 px-3 py-1 rounded-full text-xs font-bold">Voir détails</span>
                         </div>
                         <div class="absolute top-2 right-2 bg-black/60 backdrop-blur-md px-2 py-1 rounded-md text-yellow-400 font-bold text-sm flex items-center gap-1">
                            <span>★</span> ${movie.rating?.toFixed(1) || 'N/A'}
                         </div>
                    </div>
                    <div class="p-4">
                        <h3 class="font-semibold text-white text-lg truncate mb-1" title="${movie.title}">${movie.title}</h3>
                        <div class="flex justify-between items-center text-slate-400 text-sm">
                            <span>${movie.releaseDate ? new Date(movie.releaseDate).getFullYear() : 'Unknown'}</span>
                            <span class="border border-slate-700 px-2 py-0.5 rounded text-xs">${movie.genre || 'Action'}</span>
                        </div>
                    </div>
                </a>
            </div>
        `;
    }
}

window.UI = UI;
