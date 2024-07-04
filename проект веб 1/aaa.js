function showPhoneNumber(element) {
    // Находим родительский элемент worker-card
    let workerCard = element.closest('.worker-card');
    // Получаем номер телефона из атрибута data-phone-number
    let phoneNumber = workerCard.getAttribute('data-phone-number');
    // Находим div, где будет отображаться номер телефона
    let phoneNumberDiv = workerCard.querySelector('.phone-number');
    // Устанавливаем номер телефона
    phoneNumberDiv.innerHTML = "Телефон: " + phoneNumber;
    // Показываем div с номером телефона
    phoneNumberDiv.style.display = 'block';
}




document.addEventListener('DOMContentLoaded', function() {
    const ratings = document.querySelectorAll('.rating');

    ratings.forEach(function(rating) {
        const stars = rating.querySelectorAll('.star');
        const workerId = rating.getAttribute('data-worker-id');
        const savedValue = localStorage.getItem(`rating-${workerId}`);
        const initialValue = savedValue ? parseInt(savedValue) : 0;  

        const ratingValue = document.createElement('span');
        ratingValue.classList.add('rating-value');
        ratingValue.style.marginLeft = '10px';
        rating.appendChild(ratingValue);

        stars.forEach(function(star, index) {
            star.addEventListener('click', function() {
                const value = index + 1;
                rating.setAttribute('data-rating', value);
                highlightStars(rating, value);
                localStorage.setItem(`rating-${workerId}`, value);
                ratingValue.textContent = `Рейтинг: ${value}`;
                location.reload();

            });

            star.addEventListener('mouseenter', function() {
                const value = index + 1;
                highlightStars(rating, value);
            });

            star.addEventListener('mouseleave', function() {
                highlightStars(rating, initialValue);
            });
        });

        highlightStars(rating, initialValue);
        ratingValue.textContent = `Рейтинг: ${initialValue}`;

    });

    function highlightStars(rating, value) {
        const stars = rating.querySelectorAll('.star');
        stars.forEach(function(star, index) {
            if (index < value) {
                star.style.color = 'orange';
            } else {
                star.style.color = 'black';
            }
        });
    }
});

