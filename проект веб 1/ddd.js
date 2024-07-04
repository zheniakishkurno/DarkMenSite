document.addEventListener('DOMContentLoaded', function() {
    const workerCards = document.querySelectorAll('.worker-card');

    workerCards.forEach(function(workerCard) {
        const workerId = workerCard.getAttribute('data-worker-id');
        const savedValue = localStorage.getItem(`rating-${workerId}`);
        const initialValue = savedValue ? parseInt(savedValue) : 0;

        const starsElement = workerCard.querySelector('.stars');
        starsElement.textContent = initialValue;

        highlightStars(workerCard, initialValue);
    });

    function highlightStars(workerCard, value) {
        const stars = workerCard.querySelectorAll('.star');
        stars.forEach(function(star, index) {
            if (index < value) {
                star.style.color = 'orange';
            } else {
                star.style.color = 'black';
            }
        });
    }
});
