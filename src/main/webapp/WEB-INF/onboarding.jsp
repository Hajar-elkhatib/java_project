<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="includes/header.jspf" %>

<div class="min-h-screen bg-netflix-black pt-20 px-4 md:px-10">
    <div class="max-w-6xl mx-auto">
        <!-- Progress Stepper -->
        <div class="flex justify-center mb-12">
            <div class="flex items-center space-x-4">
                <div id="step1-dot" class="w-4 h-4 rounded-full bg-netflix-red"></div>
                <div class="w-16 h-1 bg-netflix-lightGray"></div>
                <div id="step2-dot" class="w-4 h-4 rounded-full bg-netflix-lightGray"></div>
            </div>
        </div>

        <form id="onboardingForm" action="/onboarding" method="post" class="space-y-12">
            
            <!-- STEP 1: GENRES -->
            <div id="step1" class="onboarding-step">
                <div class="text-center mb-10">
                    <h1 class="text-4xl md:text-5xl font-bold mb-4">Quels genres préférez-vous ?</h1>
                    <p class="text-gray-400 text-xl">Choisissez jusqu'à 5 genres pour nous aider à vous connaître.</p>
                </div>
                
                <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                    <c:forEach items="${genres}" var="genre">
                        <label class="relative group cursor-pointer">
                            <input type="checkbox" name="genres" value="${genre.id}" class="peer hidden genre-checkbox" onchange="limitCheckboxes('genre-checkbox', 5)">
                            <div class="bg-netflix-darkGray border-2 border-transparent peer-checked:border-netflix-red peer-checked:bg-netflix-red/10 p-6 rounded-xl text-center transition-all hover:bg-netflix-lightGray">
                                <span class="text-lg font-semibold">${genre.nom}</span>
                            </div>
                        </label>
                    </c:forEach>
                </div>
            </div>

            <!-- STEP 2: LIKED CONTENT -->
            <div id="step2" class="onboarding-step hidden">
                <div class="text-center mb-10">
                    <h1 class="text-4xl md:text-5xl font-bold mb-4">Quels sont vos films/séries coups de ❤️ ?</h1>
                    <p class="text-gray-400 text-xl">Sélectionnez 5 titres que vous adorez.</p>
                </div>
                
                <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-6">
                    <c:forEach items="${contents}" var="content">
                        <label class="relative cursor-pointer group">
                            <input type="checkbox" name="liked" value="${content.id}" class="peer hidden liked-checkbox" onchange="limitCheckboxes('liked-checkbox', 5)">
                            <div class="relative rounded-lg overflow-hidden border-4 border-transparent peer-checked:border-netflix-red transition-all">
                                <img src="${content.posterUrl}" alt="${content.titre}" class="w-full aspect-[2/3] object-cover group-hover:scale-105 transition-transform">
                                <div class="absolute inset-0 bg-black/40 flex items-center justify-center opacity-0 peer-checked:opacity-100">
                                    <i class="bi bi-check-circle-fill text-4xl text-netflix-red"></i>
                                </div>
                            </div>
                            <p class="mt-2 text-sm font-medium truncate">${content.titre}</p>
                        </label>
                    </c:forEach>
                </div>
            </div>

            <!-- BUTTONS -->
            <div class="flex justify-between items-center py-10 border-t border-netflix-lightGray">
                <button type="button" id="prevBtn" onclick="nextStep(-1)" class="hidden py-3 px-8 text-xl font-bold text-gray-400 hover:text-white transition-colors">Retour</button>
                <div class="flex-grow"></div>
                <button type="button" id="nextBtn" onclick="nextStep(1)" class="py-4 px-12 bg-netflix-red text-white text-xl font-bold rounded shadow-lg hover:bg-opacity-90 transition-all">Suivant</button>
                <button type="submit" id="submitBtn" class="hidden py-4 px-12 bg-netflix-red text-white text-xl font-bold rounded shadow-lg hover:bg-opacity-90 transition-all">Terminer</button>
            </div>
        </form>
    </div>
</div>

<script>
    let currentStep = 1;
    const totalSteps = 2;

    function nextStep(n) {
        document.getElementById('step' + currentStep).classList.add('hidden');
        document.getElementById('step' + currentStep + '-dot').classList.replace('bg-netflix-red', 'bg-netflix-lightGray');
        
        currentStep += n;
        
        document.getElementById('step' + currentStep).classList.remove('hidden');
        document.getElementById('step' + currentStep + '-dot').classList.replace('bg-netflix-lightGray', 'bg-netflix-red');

        // Buttons visibility
        document.getElementById('prevBtn').classList.toggle('hidden', currentStep === 1);
        document.getElementById('nextBtn').classList.toggle('hidden', currentStep === totalSteps);
        document.getElementById('submitBtn').classList.toggle('hidden', currentStep !== totalSteps);
        
        window.scrollTo(0,0);
    }

    function limitCheckboxes(className, limit) {
        const checkboxes = document.querySelectorAll('.' + className);
        const checkedCount = Array.from(checkboxes).filter(cb => cb.checked).length;
        
        checkboxes.forEach(cb => {
            if (!cb.checked && checkedCount >= limit) {
                cb.disabled = true;
                cb.parentElement.classList.add('opacity-30', 'grayscale');
            } else {
                cb.disabled = false;
                cb.parentElement.classList.remove('opacity-30', 'grayscale');
            }
        });
    }
</script>

<style>
    .onboarding-step {
        animation: fadeIn 0.5s ease-in-out;
    }
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

<%@ include file="includes/footer.jspf" %>
