import React, { useState } from 'react';
import './1.css';

function WorkerCard({ worker }) {
    const [rating, setRating] = useState(worker.rating);
    const [showPhone, setShowPhone] = useState(false);

    const handleRating = (value) => {
        setRating(value);
    };

    const showPhoneNumber = () => {
        setShowPhone(true);
    };

    return (
        <div className="worker-card" data-phone-number={worker.phone}>
            <img src={worker.img} alt="Рабочий" />
            <h3>{worker.name}</h3>
            <p>Возраст: {worker.age} лет</p>
            <p>Рейтинг от вас: {rating}</p>
            <div className="rating" data-worker-id={worker.id} data-rating={rating}>
                {[1, 2, 3, 4, 5].map(value => (
                    <span
                        key={value}
                        className="star"
                        data-value={value}
                        onClick={() => handleRating(value)}
                        style={{ color: value <= rating ? 'gold' : 'gray' }}
                    >
                        &#9733;
                    </span>
                ))}
            </div>
            <p>Пол: Мужчина</p>
            <p>Навыки:</p>
            <ul>
                {worker.skills.map(skill => <li key={skill}>{skill}</li>)}
            </ul>
            <p>Прайс-лист:</p>
            <ul>
                {worker.priceList.map(price => <li key={price}>{price}</li>)}
            </ul>
            <p>Доступное время: {worker.availableTime}</p>
            <button onClick={showPhoneNumber}>Заказать</button>
            {showPhone && <div className="phone-number">{worker.phone}</div>}
        </div>
    );
}

const workers = [
    {
        id: 1,
        img: "worker.jpg",
        name: "Омар",
        age: 30,
        rating: 0,
        skills: ["Тяжелая атлетика", "Мелкие ремонтные работы", "Вынос мусора", "Малярные работы"],
        priceList: ["Тяжелая атлетика: от 5 руб. / ч", "Вынос мусора: от 7 руб. / ч"],
        availableTime: "8:00 - 18:00",
        phone: "+375441234567"
    },
    {
        id: 2,
        img: "3.jpg",
        name: "Алексей",
        age: 28,
        rating: 0,
        skills: ["Электромонтажные работы", "Сантехника", "Ремонт техники", "Мелкие ремонтные работы"],
        priceList: ["Электромонтажные работы: от 10 руб. / ч", "Сантехника: от 12 руб. / ч"],
        availableTime: "9:00 - 19:00",
        phone: "+375441234568"
    },
    // Добавьте других работников здесь
];

function App() {
    return (
        <div className="container">
            {workers.map(worker => (
                <WorkerCard key={worker.id} worker={worker} />
            ))}
        </div>
    );
}

export default App;
