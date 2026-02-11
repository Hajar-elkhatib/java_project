document.addEventListener('DOMContentLoaded', () => {
    let currentPage = 0;
    let currentGenre = '';
    let currentSort = 'popularity';
    let currentQuery = new URLSearchParams(window.location.search).get('query') || '';

    const grid = 'movies-grid';
    const genreSelect = document.getElementById('genre-filter');
    const sortSelect = document.getElementById('sort-filter');
    const prevBtn = document.getElementById('prev-page');
    const nextBtn = document.getElementById('next-page');
    const pageInfo = document.getElementById('page-info');

    // Init
    loadMovies();

    // Event Listeners
    genreSelect.addEventListener('change', (e) => {
        currentGenre = e.target.value;
        currentPage = 0;
        loadMovies();
    });

    sortSelect.addEventListener('change', (e) => {
        currentSort = e.target.value;
        currentPage = 0;
        loadMovies();
    });

    prevBtn.addEventListener('click', () => {
        if (currentPage > 0) {
            currentPage--;
            loadMovies();
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    });

    nextBtn.addEventListener('click', () => {
        currentPage++;
        loadMovies();
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });

    async function loadMovies() {
        UI.renderSkeletons(grid, 10);

        try {
            const data = await ApiService.getMovies(currentPage, 20, currentSort, currentGenre, currentQuery);
            const movies = data.content || data; // Handle Page<T> or List<T>
            const totalPages = data.totalPages || (movies.length < 20 ? currentPage + 1 : currentPage + 2); // Fallback estimation

            if (!movies || movies.length === 0) {
                UI.showEmptyState(grid, currentQuery ? `Aucun résultat pour "${currentQuery}"` : "Aucun film trouvé.");
                pageInfo.innerText = `Page ${currentPage + 1}`;
                prevBtn.disabled = true;
                nextBtn.disabled = true;
                return;
            }

            const html = movies.map(movie => UI.createMovieCard(movie)).join('');
            document.getElementById(grid).innerHTML = html;

            // Update Pagination UI
            pageInfo.innerText = `Page ${currentPage + 1} / ${totalPages}`;
            prevBtn.disabled = currentPage === 0;
            nextBtn.disabled = currentPage >= totalPages - 1;

        } catch (error) {
            console.error(error);
            UI.showToast("Erreur lors du chargement des films", "error");
            UI.showEmptyState(grid, "Erreur de connexion serveur.");
        }
    }
});
