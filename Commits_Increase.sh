#!/bin/bash

# Кількість ітерацій (за замовчуванням 5)
ITERATIONS=${1:-5}

# Список реалістичних назв файлів
FILENAMES=("app.py" "server.js" "config.sh" "database.py" "utils.js" "script.sh" "main.py" "index.js" "run.sh" "notes.txt")

# Функція для генерації псевдокоду
generate_fake_code() {
    local FILENAME="$1"
    case "$FILENAME" in
        *.sh)
            echo -e "#!/bin/bash\n\nfor i in {1..5}; do\n  echo \"Processing item \$i\"\n  sleep 1\ndone"
            ;;
        *.py)
            echo -e "#!/usr/bin/env python3\n\nfor i in range(5):\n    print(f'Processing item {i}')\n    import time\n    time.sleep(1)"
            ;;
        *.js)
            echo -e "for (let i = 0; i < 5; i++) {\n  console.log(`Processing item ${i}`);\n  await new Promise(r => setTimeout(r, 1000));\n}"
            ;;
        *.txt)
            echo -e "TODO List:\n- Implement random script generator\n- Optimize performance\n- Add more randomization"
            ;;
    esac
}

# Запускаємо цикл
for ((i=1; i<=ITERATIONS; i++)); do
    FILENAME=${FILENAMES[$RANDOM % ${#FILENAMES[@]}]}
    
    # Генеруємо контент для файлу
    generate_fake_code "$FILENAME" > "$FILENAME"

    if [[ "$FILENAME" == *.sh || "$FILENAME" == *.py ]]; then
        chmod +x "$FILENAME"
    fi

    git add "$FILENAME"
    git commit -m "Added random fake script: $FILENAME"

    echo "[$i/$ITERATIONS] Створено і закомічено файл: $FILENAME"
done

# Пушимо всі коміти разом
git push origin main  # Якщо основна гілка "master", заміни "main" на "master"

echo "✅ Успішно створено $ITERATIONS випадкових файлів та запушено в репозиторій!"
