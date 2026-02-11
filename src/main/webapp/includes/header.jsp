<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineStream - ${param.title != null ? param.title : 'Accueil'}</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        slate: { 950: '#020617' }
                    },
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css">
</head>
<body class="bg-slate-950 text-white min-h-screen flex flex-col font-sans antialiased">

<nav class="fixed w-full z-50 glass-nav transition-all duration-300" id="navbar">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
            <div class="flex items-center gap-8">
                <a href="${pageContext.request.contextPath}/" class="text-2xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-blue-400 to-indigo-600">
                    CineStream
                </a>
                <div class="hidden md:block">
                    <div class="ml-10 flex items-baseline space-x-4">
                        <a href="${pageContext.request.contextPath}/" class="text-slate-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium transition-colors">Accueil</a>
                        <a href="${pageContext.request.contextPath}/movies.jsp" class="text-slate-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium transition-colors">Films</a>
                        <a href="${pageContext.request.contextPath}/recommendations.jsp" class="text-slate-300 hover:text-white px-3 py-2 rounded-md text-sm font-medium transition-colors">Pour Vous</a>
                    </div>
                </div>
            </div>
            
            <div class="flex items-center gap-4">
                <div class="relative hidden sm:block">
                    <input type="text" id="nav-search" placeholder="Rechercher..." 
                           class="bg-slate-800 text-sm rounded-full pl-10 pr-4 py-1.5 focus:outline-none focus:ring-2 focus:ring-blue-500 w-48 transition-all focus:w-64 border border-slate-700">
                    <svg class="w-4 h-4 absolute left-3 top-2.5 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                </div>

                <div id="auth-buttons" class="flex gap-2">
                    <!-- Configured via JS based on auth state -->
                    <a href="${pageContext.request.contextPath}/login.jsp" class="text-sm font-medium text-slate-300 hover:text-white">Connexion</a>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="bg-blue-600 hover:bg-blue-700 text-white text-sm px-4 py-1.5 rounded-full transition-colors">Inscription</a>
                </div>
            </div>
        </div>
    </div>
</nav>

<main class="flex-grow pt-16">
