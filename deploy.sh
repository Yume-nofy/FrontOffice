#!/bin/bash
APP="frontend-0.0.1-SNAPSHOT.war"

echo "🚀 Déploiement de $APP..."

mvn clean package -DskipTests || { echo "❌ Erreur de build"; exit 1; }

pkill -f "target/$APP" 2>/dev/null

sleep 2

nohup java -jar target/$APP > app.log 2>&1 &

echo "✅ $APP lancé avec succès !"
