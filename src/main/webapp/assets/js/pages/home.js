document.addEventListener('DOMContentLoaded', async () => {
    const container = 'featured-movies';
    UI.renderSkeletons(container, 5);

    try {
        // Fetch top 5 popular movies
        const result = await ApiService.getMovies(0, 5, 'popularity');
        const movies = result.content || result; // Handle Spring Page or direct list

        if (movies.length === 0) {
            UI.showEmptyState(container);
            return;
        }

        const html = movies.map(movie => UI.createMovieCard(movie)).join('');
        document.getElementById(container).innerHTML = html;

    } catch (error) {
        console.error(error);
        UI.showToast("Erreur lors du chargement des films populaires", "error");
        UI.showEmptyState(container, "Impossible de charger les films.");
    }
});
