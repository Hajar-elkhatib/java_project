document.addEventListener('DOMContentLoaded', async () => {
    const params = new URLSearchParams(window.location.search);
    const movieId = params.get('id');

    if (!movieId) {
        window.location.href = 'movies.jsp';
        return;
    }

    try {
        const movie = await ApiService.getMovieById(movieId);
        renderMovie(movie);
    } catch (error) {
        UI.showToast("Erreur lors du chargement des détails", "error");
        document.getElementById('movie-content').innerHTML = `
            <div class="h-screen flex items-center justify-center">
                <div class="text-center">
                    <h1 class="text-4xl font-bold mb-4">Oups !</h1>
                    <p class="text-slate-400 mb-6">Ce film semble introuvable.</p>
                    <a href="movies.jsp" class="text-blue-500 hover:underline">Retour au catalogue</a>
                </div>
            </div>
        `;
    }

    // Modal Logic
    setupRatingModal(movieId);
});

function renderMovie(movie) {
    const backdrop = movie.backdropUrl || movie.posterUrl || '';
    const poster = movie.posterUrl || 'https://via.placeholder.com/300x450';

    document.getElementById('movie-content').innerHTML = `
        <div class="relative h-[60vh] w-full overflow-hidden">
            <div class="absolute inset-0 bg-cover bg-center" style="background-image: url('${backdrop}'); filter: blur(20px) brightness(0.3);"></div>
            <div class="absolute inset-0 bg-gradient-to-t from-slate-950 via-slate-950/50 to-transparent"></div>
            
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-full flex items-end pb-12 relative z-10">
                <div class="flex flex-col md:flex-row gap-8 items-end">
                    <img src="${poster}" class="w-48 md:w-64 rounded-xl shadow-2xl glass transform md:translate-y-16 border-4 border-slate-900">
                    <div class="flex-1 mb-4 md:mb-0">
                        <div class="flex gap-2 mb-2">
                             ${(movie.genres || []).map(g => `<span class="px-2 py-0.5 bg-blue-600/20 text-blue-400 rounded text-xs border border-blue-600/30">${g}</span>`).join('')}
                        </div>
                        <h1 class="text-4xl md:text-5xl font-bold text-white mb-2">${movie.title}</h1>
                        <div class="flex items-center gap-4 text-slate-300 text-sm md:text-base">
                            <span>${movie.releaseDate ? new Date(movie.releaseDate).getFullYear() : 'N/A'}</span>
                            <span>•</span>
                            <span class="flex items-center gap-1 text-yellow-400">★ ${movie.rating?.toFixed(1) || 'N/A'}</span>
                            <span>•</span>
                            <span>${movie.duration ? movie.duration + ' min' : 'Durée inconnue'}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-20 pb-20">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-12">
                <div class="lg:col-span-2 space-y-8">
                    <div class="glass p-8 rounded-2xl">
                        <h2 class="text-2xl font-bold mb-4">Synopsis</h2>
                        <p class="text-slate-300 leading-relaxed text-lg">${movie.overview || "Aucune description disponible."}</p>
                    </div>

                    <div>
                        <h2 class="text-xl font-bold mb-4">Casting</h2>
                        <div class="flex gap-4 overflow-x-auto pb-4 custom-scrollbar">
                            ${(movie.cast || []).map(actor => `
                                <div class="min-w-[120px] text-center">
                                    <div class="w-20 h-20 mx-auto rounded-full overflow-hidden mb-2 bg-slate-800">
                                        <img src="${actor.profileUrl || 'https://ui-avatars.com/api/?name=' + actor.name}" class="w-full h-full object-cover">
                                    </div>
                                    <p class="text-white text-sm font-medium truncate">${actor.name}</p>
                                    <p class="text-slate-500 text-xs truncate">${actor.character}</p>
                                </div>
                            `).join('') || '<p class="text-slate-500">Information non disponible.</p>'}
                        </div>
                    </div>
                </div>

                <div class="space-y-6">
                    <button onclick="openRatingModal()" class="w-full py-4 bg-gradient-to-r from-yellow-500 to-amber-600 hover:from-yellow-400 hover:to-amber-500 text-white font-bold rounded-xl shadow-lg shadow-amber-500/20 transition-all hover:scale-105">
                        ⭐ Noter ce film
                    </button>
                    
                    <button class="w-full py-4 glass hover:bg-white/10 text-white font-bold rounded-xl transition-all flex items-center justify-center gap-2">
                         💙 Ajouter aux Favoris
                    </button>

                    <div class="glass p-6 rounded-2xl">
                        <h3 class="font-bold mb-4">Détails</h3>
                        <dl class="space-y-2 text-sm">
                            <div class="flex justify-between">
                                <dt class="text-slate-400">Réalisateur</dt>
                                <dd class="text-white">${movie.director || 'N/A'}</dd>
                            </div>
                             <div class="flex justify-between">
                                <dt class="text-slate-400">Langue orig.</dt>
                                <dd class="text-white uppercase">${movie.originalLanguage || 'EN'}</dd>
                            </div>
                        </dl>
                    </div>
                </div>
            </div>
        </div>
    `;
}

// Modal Logic
let selectedRating = 0;
const modal = document.getElementById('rating-modal');
const modalContent = document.getElementById('rating-modal-content');
const stars = document.querySelectorAll('#star-rating button');

window.openRatingModal = () => {
    modal.classList.remove('opacity-0', 'pointer-events-none');
    modalContent.classList.remove('scale-95');
    modalContent.classList.add('scale-100');
};

window.closeRatingModal = () => {
    modal.classList.add('opacity-0', 'pointer-events-none');
    modalContent.classList.remove('scale-100');
    modalContent.classList.add('scale-95');
};

stars.forEach(star => {
    star.addEventListener('click', () => {
        selectedRating = parseInt(star.dataset.value);
        updateStars();
    });
    star.addEventListener('mouseenter', () => {
        updateStars(parseInt(star.dataset.value));
    });
    document.getElementById('star-rating').addEventListener('mouseleave', () => {
        updateStars(selectedRating);
    });
});

function updateStars(hoverValue = selectedRating) {
    stars.forEach(s => {
        const val = parseInt(s.dataset.value);
        if (val <= hoverValue) {
            s.classList.add('text-yellow-400');
            s.classList.remove('text-slate-600');
        } else {
            s.classList.remove('text-yellow-400');
            s.classList.add('text-slate-600');
        }
    });
}

document.getElementById('submit-rating').addEventListener('click', async () => {
    if (selectedRating === 0) {
        UI.showToast("Veuillez sélectionner une note.", "warning");
        return;
    }
    const movieId = new URLSearchParams(window.location.search).get('id');
    try {
        await ApiService.rateMovie(movieId, selectedRating);
        UI.showToast("Merci pour votre note !", "success");
        closeRatingModal();
        // Optional: reload to update average rating
    } catch (err) {
        UI.showToast("Erreur lors de l'envoi de la note.", "error");
    }
});
