const API_BASE_URL = 'http://localhost:8080/api';

class ApiService {
    static async request(endpoint, options = {}) {
        const url = `${API_BASE_URL}${endpoint}`;
        const headers = {
            'Content-Type': 'application/json',
            ...options.headers
        };

        // Add auth token if available
        const token = localStorage.getItem('authToken');
        if (token) {
            headers['Authorization'] = `Bearer ${token}`;
        }

        try {
            const response = await fetch(url, { ...options, headers });
            if (!response.ok) {
                // Handle specific errors like 401
                if (response.status === 401) {
                   window.location.href = '/login.jsp';
                }
                const errorData = await response.json().catch(() => ({}));
                throw new Error(errorData.message || `Error ${response.status}`);
            }
            return await response.json();
        } catch (error) {
            console.error("API Call Failed:", error);
            throw error;
        }
    }

    // Movies
    static async getMovies(page = 0, size = 12, sortBy = 'popularity', genre = '', query = '') {
        const params = new URLSearchParams({ page, size, sortBy });
        if (genre) params.append('genre', genre);
        if (query) params.append('query', query);
        return this.request(`/movies?${params.toString()}`);
    }

    static async getMovieById(id) {
        return this.request(`/movies/${id}`);
    }

    static async getRecommendations() {
        return this.request(`/recommendations`); // Adjust endpoint as needed
    }

    static async rateMovie(movieId, rating) {
        return this.request(`/movies/${movieId}/rate`, {
            method: 'POST',
            body: JSON.stringify({ rating })
        });
    }

    // Auth
    static async login(username, password) {
        const data = await this.request(`/auth/login`, {
            method: 'POST',
            body: JSON.stringify({ username, password })
        });
        if (data.token) {
            localStorage.setItem('authToken', data.token);
            localStorage.setItem('user', JSON.stringify(data.user));
        }
        return data;
    }

    static async register(userData) {
        return this.request(`/auth/register`, {
            method: 'POST',
            body: JSON.stringify(userData)
        });
    }
    
    static logout() {
        localStorage.removeItem('authToken');
        localStorage.removeItem('user');
        window.location.href = '/login.jsp';
    }

    static getUserProfile() {
        return this.request(`/user/profile`);
    }
}

// Export global for vanilla JS
window.ApiService = ApiService;
